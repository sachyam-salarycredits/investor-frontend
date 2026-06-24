import 'package:Monexo/language/language_en.dart';
import 'package:Monexo/providers/app_state_provider.dart';
import 'package:Monexo/supporting_file/appsFlyerSdk.dart';
import 'package:Monexo/supporting_file/hyperverge_api.dart';
import 'package:Monexo/supporting_file/hyperverse_web_sdk.dart';
import 'package:Monexo/supporting_file/api_calling.dart';
import 'package:Monexo/utils/api_constant.dart';
import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/fonts.dart';
import 'package:Monexo/utils/images.dart';
import 'package:Monexo/utils/responsive.dart';
import 'package:Monexo/utils/user_preferences.dart';
import 'package:Monexo/utils/utils.dart';
import 'package:Monexo/widgets/custom_button.dart';
import 'package:Monexo/widgets/header.dart';
import 'package:Monexo/widgets/loader.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../routes_management/routes_list.dart';
import '../../home/screens/home_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AadhaarVerificationScreen extends StatefulWidget {
  const AadhaarVerificationScreen({Key? key}) : super(key: key);

  @override
  _AadhaarVerificationScreenState createState() =>
      _AadhaarVerificationScreenState();
}

class _AadhaarVerificationScreenState extends State<AadhaarVerificationScreen> {
  bool isOcrDone = false;
  bool _isLoading = false;
  HyperVergeData documentUriData =
      HyperVergeData(frontUri: '', backUri: '', faceDetails: null);
  Map? aadharFrontDetail;
  Map? aadharBackDetail;
  int faceMatchScore = 0;
  var ip = "";

  @override
  void initState() {
    super.initState();
    Utils.getUserLocation(context).catchError((e) {
      print(e);
    });
    getIp();
  }

  Future<void> getIp() async {
    ip = await Utils.getIpAddress();
  }

  _sendEmail() {
    final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: 'lend@monexo.co');
    launchUrlString(_emailLaunchUri.toString());
  }

  void submitBtnAction() async {
    if (isOcrDone) {
      // Other backend steps
      submitAadharDetails();
    } else {
      if (Utils.isWeb) {
        setLoading(true);
        var token = await HyperVergeSession.generateWebTokenHyperverse(context);
        setLoading(false);
        init(token ?? "");
      }
      startOCRProcess();
    }
  }

  // Start OCR process with Hyperverge sdk
  void startOCRProcess() async {
    var docData = await HyperVergeSession.startKYC();
    if (docData == null) {
      return;
    }
    documentUriData = docData;
    callFaceMatchApi();
  }

  //MARK: Call Face match api to match the selfie with doc photo
  void callFaceMatchApi() async {
    setLoading(true);

    var matchScore = (Utils.isWeb)
        ? (await runFaceMatch(documentUriData.faceDetails?.faceUri ?? "",
            documentUriData.frontUri))
        : (await HyperVergeSession.callFaceMatchApi(
            documentUriData.faceDetails?.faceUri, documentUriData.frontUri));

    faceMatchScore = matchScore ?? 0;
    print('match score aadhar screen ${matchScore}');
    setLoading(false);

    // if (matchScore == null || matchScore < 75) {
    if (matchScore == null || matchScore == 0) {
      var faceDetails = (Utils.isWeb)
          ? (await runFaceScanner())
          : (await HyperVergeSession.openFaceCaptureScreen());

      if (faceDetails == null) {
        return;
      }
      documentUriData.faceDetails = faceDetails;
      callFaceMatchApi();
      // Utils.showToast(msg: 'Something went wrong, Please try after sometime.');

      return;
    }
    callOCRApi(true);
  }

  //MARK: Call OCR api to get details of document
  void callOCRApi(isFront) async {
    setLoading(true);
    var aadharData = await HyperVergeSession.callOCRApi(
        (isFront ? documentUriData.frontUri : documentUriData.backUri),
        isFront);
    setLoading(false);

    if (aadharData == null) {
      return;
    }
    if (isFront) {
      aadharFrontDetail = aadharData;
      callOCRApi(false);
    } else {
      aadharBackDetail = aadharData;
      setState(() {
        isOcrDone = true;
      });
      submitAadharDetails();
    }
  }

  /// Submit Aadhar details
  Future<void> submitAadharDetails() async {
    setLoading(true);
    var locationData = await Utils.getUserLocation(context);

    var param = Map<String, String>();
    param[ApiParams.customerId] = (context.read<AppStateProvider>().customerId);

    if (locationData != null) {
      param[ApiParams.latitute] = "${locationData.latitude ?? 0.0}";
      param[ApiParams.longitute] = "${locationData.longitude ?? 0.0}";
    }
    param[ApiParams.customerId] = (context.read<AppStateProvider>().customerId);
    param[ApiParams.fullName] = aadharFrontDetail?[HyperVergeSession.name];
    param[ApiParams.dateOfBirth] = aadharFrontDetail?[HyperVergeSession.dob];
    param[ApiParams.gender] = aadharFrontDetail?[HyperVergeSession.gender];
    param[ApiParams.aadharCardNumber] =
        aadharFrontDetail?[HyperVergeSession.aadhaar];
    param[ApiParams.address] = aadharBackDetail?[HyperVergeSession.address];
    param[ApiParams.faceMatch] =
        documentUriData.faceDetails?.live?.toString() ?? '';
    param[ApiParams.faceMatchScore] = faceMatchScore.toString();
    param[ApiParams.livenessScore] =
        documentUriData.faceDetails?.livenessScore ?? '';
    param[ApiParams.ip] = ip;
    var files = Map<String, PlatformFile>();

    files[ApiParams.profileImage] =
        Utils.getPlatformFile(documentUriData.faceDetails?.faceUri ?? '')!;
    files[ApiParams.aadharFrontImage] =
        Utils.getPlatformFile(documentUriData.frontUri)!;
    files[ApiParams.aadharBackImage] =
        Utils.getPlatformFile(documentUriData.backUri)!;

    var submitRes =
        await context.read<AppStateProvider>().aadharSubmit(param, files);
    setLoading(false);
    // if (submitRes) {
    //   AFSdk.logEvent(AFSdk.af_ekyc, null);
    //   // context.pop();
    //   // Utils.showToast(msg: LanguageHelper.textEkycDone);
    //   Utils.showAlert(
    //       context: context,
    //       msg: LanguageHelper.textEkycDone,
    //       onTap: () {
    //         Navigator.push(
    //             context, MaterialPageRoute(builder: (context) => HomeScreen()));
    //       });
    // }
    if (submitRes) {
      AFSdk.logEvent(AFSdk.af_ekyc, null);
      // context.pop();
      // Utils.showToast(msg: LanguageHelper.textEkycDone);
      if (faceMatchScore < 75) {
        showDialog<void>(
          context: context,
          useRootNavigator: true,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Monexo',
                style: TextStyle(
                  fontSize: 22,
                  color: ColorsUtil.blueColor,
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    RichText(
                      // textAlign:
                      //     TextAlign
                      //         .justify,
                      text: TextSpan(
                        text:
                            'Your e-KYC is incomplete because the Selfie doesn`t match with the Aadhar image. Please send the self attested image of the Aadhar card to ',
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorsUtil.black,
                          height: 1.5,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'lend@monexo.co',
                              style: TextStyle(
                                // height:
                                //     1.9,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                                decorationThickness: 1.5,
                                height: 1.5,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _sendEmail),
                          TextSpan(
                            text: ' for completing KYC process.',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorsUtil.black,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('ok'),
                  onPressed: () {
                    context.pushNamed(RoutesName.SettingsScreen);
                  },
                ),
              ],
            );
          },
        );
        // Utils.showAlert(
        //     context: context,
        //     msg: 'Your KYC is incomplete because of improper face Match',
        //     onTap: () {
        //       context.pushNamed(RoutesName.SettingsScreen);
        //     });
      } else {
        Utils.showAlert(
            context: context,
            msg: LanguageHelper.textEkycDone,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            });
      }
    }
  }

  void setLoading(loading) {
    setState(() {
      _isLoading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: MonexoLoader(
          isLoading: _isLoading,
          child: SafeArea(
            child: ResponsiveWidget.isSmallScreen(context)
                ? Column(
                    children: [
                      Header(
                        backOnPressed: () {
                          context.pop();
                        },
                      ),
                      mainWidgets(context),
                      submitButton(context),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 20),
                        child: RichText(
                          text: TextSpan(
                            text:
                                'NOTE : You can either upload your Aadhaar card or send us to ',
                            style: TextStyle(
                                height: 1.25,
                                fontFamily: CustomFonts.nunito,
                                fontSize: 16,
                                color: ColorsUtil.black,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'lend@monexo.co',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue,
                                    decorationThickness: 1.5,
                                    height: 1.5,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = _sendEmail),
                              TextSpan(
                                text: ' for completing Ekyc.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Container(
                        width: screenSize.width * .56,
                        color: ColorsUtil.white,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Header(
                                backOnPressed: () {
                                  context.pop();
                                },
                              ),
                              SizedBox(height: 50),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                                    child: Center(
                                      child: Container(
                                        width: screenSize.width * .4,
                                        constraints:
                                            BoxConstraints(maxWidth: 500),
                                        child: Column(
                                          children: [
                                            mainWidgets(context),
                                            submitButton(context),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 20),
                                              child: RichText(
                                                text: TextSpan(
                                                  text:
                                                      'NOTE : You can either upload your Aadhaar card or send us to ',
                                                  style: TextStyle(
                                                      height: 1.25,
                                                      fontFamily:
                                                          CustomFonts.nunito,
                                                      fontSize: 16,
                                                      color: ColorsUtil.black,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: 'lend@monexo.co',
                                                        style: TextStyle(
                                                          color: Colors.blue,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          decorationColor:
                                                              Colors.blue,
                                                          decorationThickness:
                                                              1.5,
                                                          height: 1.5,
                                                        ),
                                                        recognizer:
                                                            TapGestureRecognizer()
                                                              ..onTap =
                                                                  _sendEmail),
                                                    TextSpan(
                                                      text:
                                                          ' for completing Ekyc.',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: screenSize.width * .44,
                        color: ColorsUtil.blueColor,
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget mainWidgets(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aadhaar Verification',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: CustomFonts.nunito,
                fontSize: 25,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            'If you have your Aadhaar card with you, you can share your details by scanning front and back side of Aadhaar or uploading them.',
            textAlign: TextAlign.left,
            // maxLines: 3,
            style: TextStyle(
                height: 1.25,
                fontFamily: CustomFonts.nunito,
                fontSize: 17,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 25.0,
          ),
          Text(
            'Preferred method; keep your Aadhaar card handy to make a faster and easy form filling. You may also need to take a selfie for image verifications.',
            textAlign: TextAlign.left,
            // maxLines: 3,
            style: TextStyle(
                height: 1.25,
                fontFamily: CustomFonts.nunito,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: ColorsUtil.lighterGrey),
          ),
          SizedBox(
            height: 15.0,
          ),
          Visibility(
            visible: isOcrDone,
            child: Row(
              children: [
                Image.asset(
                  LocalImages.green_sheild_tick,
                  width: 30,
                  height: 30,
                  color: ColorsUtil.blueColor,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'OCR completed. Click on submit to\ncomplete other steps.',
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: TextStyle(
                      fontFamily: CustomFonts.nunito,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorsUtil.blueColor),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget submitButton(context) {
    return CustomButton(
      titleStr: getButtonTitle(),
      onPress: submitBtnAction,
    );
  }

  String getButtonTitle() {
    if (!isOcrDone) {
      return 'Scan Aadhaar Now';
    } else {
      return 'Submit and continue';
    }
  }
}
