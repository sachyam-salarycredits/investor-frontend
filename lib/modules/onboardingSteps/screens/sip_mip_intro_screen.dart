import 'dart:async';
import 'package:Monexo/providers/app_state_provider.dart';
import 'package:Monexo/routes_management/routes_list.dart';
import 'package:Monexo/utils/api_constant.dart';
import 'package:Monexo/utils/colours_util.dart';
import 'package:Monexo/utils/images.dart';
import 'package:Monexo/utils/responsive.dart';
import 'package:Monexo/utils/utils.dart';
import 'package:Monexo/widgets/custom_button.dart';
import 'package:Monexo/utils/fonts.dart';
import 'package:Monexo/widgets/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';
import '../../home/models/YoutubeVediosModel.dart';

class SIPMIPIntroScreen extends StatefulWidget {
  final bool forSIP;
  const SIPMIPIntroScreen({Key? key, required this.forSIP}) : super(key: key);

  @override
  _SIPMIPIntroScreen createState() => _SIPMIPIntroScreen();
}

class _SIPMIPIntroScreen extends State<SIPMIPIntroScreen> {
  bool _isLoading = false;
  List<VideoData>? youtubevideos = [];
  bool loading = false;
  String thumbnailUrl = '';
  setLoader(bool value) {
    setState(() {
      loading = value;
    });
  }

  @override
  void initState() {
    super.initState();
    getYoutubeVideosLocaly();

    Timer(Duration(seconds: 1), () {
      navigateToVideoPlayer();
    });
  }

  getYoutubeVideosLocaly() async {
    final youtubeVideo = context.read<AppStateProvider>().youtubeVideos;
    youtubevideos = youtubeVideo?.data;
    print('youtube:::$youtubeVideo');
    if(widget.forSIP) {
      thumbnailUrl = youtubevideos
          ?.firstWhere((element) => element.videoType == 'SIP')
          .thumbnailUrl ?? '';
    } else {
      thumbnailUrl = youtubevideos
          ?.firstWhere((element) => element.videoType == 'MIP')
          .thumbnailUrl ?? '';
    }
  }

  void navigateToVideoPlayer() {
    String? url;
    if (widget.forSIP) {
      url = youtubevideos
          ?.firstWhere((element) => element.videoType == 'SIP')
          .videoUrl;
    } else {
      url = youtubevideos
          ?.firstWhere((element) => element.videoType == 'MIP')
          .videoUrl;
    }
    if (Utils.isWeb) {
      Utils.launchURL(url ?? '');
    } else {
      context.pushNamed(RoutesName.VideoPlayerPage, params: {
        Constants.videoUrl: url ?? '',
        Constants.validateWatchTime: 'false',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    // context.read<AppStateProvider>().context = context;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: MonexoLoader(
          isLoading: _isLoading,
          child: SafeArea(
              child: ResponsiveWidget.isSmallScreen(context)
                  ? Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  //mobile UI
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        icon: Icon(Icons.keyboard_backspace,size: 30,),
                        onPressed: (){
                          context.pop();
                        },
                      ),
                    ),
                    mainWidgets(context),
                  ],
                ),
              )
                  : Row(
                // Web UI
                children: [
                  Container(
                    width: screenSize.width * .56,
                    height: screenSize.height,
                    color: ColorsUtil.white,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                            icon: Icon(Icons.keyboard_backspace,size: 30,),
                            onPressed: (){
                              context.pop();
                            },
                          ),
                        ),
                        // Header(
                        //   isDownloadBarVisible: true,
                        //   backOnPressed: () {
                        //     context.pop();
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 50,
                        // ),
                        SizedBox(height: 50),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: Container(
                                width: screenSize.width * .4,
                                constraints:
                                BoxConstraints(maxWidth: 500),
                                margin:
                                EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 30),
                                    mainWidgets(context)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: screenSize.width * .44,
                    color: ColorsUtil.blueColor,
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget mainWidgets(BuildContext context) {
    var provider = Provider.of<AppStateProvider>(context, listen: false);
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          widget.forSIP
                              ? content[0].titleText
                              : content[1].titleText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: CustomFonts.nunito,
                              fontSize: 22,
                              color: ColorsUtil.blueColor,
                              fontWeight: FontWeight.w700)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          widget.forSIP
                              ? content[0].subTitleText
                              : content[1].subTitleText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: CustomFonts.nunito,
                              fontSize: 14,
                              color: ColorsUtil.blueColor,
                              fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorsUtil.inputBG,
                          border: Border.all(
                              width: 1.25, color: ColorsUtil.blueColor),
                          // color: ColorsUtil.blueColor,
                          borderRadius: BorderRadius.all(Radius.circular(
                              5.0) //                 <--- border radius here
                          ),
                        ),
                        child: Container(
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    navigateToVideoPlayer();
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      thumbnailUrl,
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 35,
                                    width: 90,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              EdgeInsets.only(
                                                  top: 10,
                                                  bottom: 10,
                                                  left: 15)),
                                          backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              ColorsUtil.blueColor),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(20.0),
                                              ))),
                                      onPressed: () {
                                        navigateToVideoPlayer();
                                      },
                                      child: Row(
                                        // mainAxisAlignment:
                                        // MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              widget.forSIP
                                                  ? content[0].videoText
                                                  : content[1].videoText,
                                              style: TextStyle(
                                                  fontFamily: CustomFonts.nunito,
                                                  fontSize: 17,
                                                  color: ColorsUtil.white,
                                                  fontWeight: FontWeight.w700)),
                                          Icon(
                                            Icons.arrow_right,
                                            size: 30,
                                            color: ColorsUtil.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
                widget.forSIP
                    ? content[0].descriptionText
                    : content[1].descriptionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: CustomFonts.nunito,
                    fontSize: 14,
                    color: ColorsUtil.blueColor,
                    fontWeight: FontWeight.w400)),
          ),
          const SizedBox(height: 20),
          CustomButton(
            titleStr: widget.forSIP
                ? content[0].btnText
                : content[1].btnText,
            onPress: () {
              if (widget.forSIP) {
                context.pushNamed(RoutesName.SIP);
              } else {
                context.pushNamed(RoutesName.MIPSetUp);
              }
            },
          ),
        ],
      ),
    );
  }
}

/// FirstDeposit Screen Content Data Model Class
class SIPMIPIntroScreenContent {
  String titleText;
  String subTitleText;
  String videoText;
  String descriptionText;
  String btnText;

  SIPMIPIntroScreenContent({
    required this.titleText,
    required this.subTitleText,
    required this.videoText,
    required this.descriptionText,
    required this.btnText,
  });
}

/// First Deposit Screen Content Data List
List<SIPMIPIntroScreenContent> content = [
  //before SIP screen content
  SIPMIPIntroScreenContent(
    titleText: 'Setup you SIP',
    subTitleText:
    'Don’t miss out on investment opportunities and make the most out to compound your returns',
    videoText: 'Play',
    btnText: 'Setup SIP',
    descriptionText: 'Automate adding funds to your Monexo Account with our SIP Feature',
  ),
 //before mip screen content
  SIPMIPIntroScreenContent(
    titleText: 'Setup you MIP',
    subTitleText:
    'Transfer your montly interest earnings back to your\nbank account',
    videoText: 'Play',
    btnText: 'Setup MIP',
    descriptionText:
    'Automate what to do with your interest earned every month',
  ),
];
