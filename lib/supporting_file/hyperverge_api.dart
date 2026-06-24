import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:Monexo/language/language_en.dart';
import 'package:http/http.dart' as http;

import 'package:Monexo/supporting_file/hyperverse_web_sdk.dart';
import 'package:Monexo/supporting_file/api_calling.dart';
import 'package:Monexo/utils/api_constant.dart';
import 'package:Monexo/utils/constants.dart';
import 'package:Monexo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hypersnapsdk_flutter/HVDocsCapture.dart';
import 'package:hypersnapsdk_flutter/HVFaceCapture.dart';
import 'package:hypersnapsdk_flutter/HVNetworkHelper.dart';

class HyperVergeData {
  String frontUri;
  String backUri;
  FaceDetails? faceDetails;

  HyperVergeData({
    required this.frontUri,
    required this.backUri,
    required this.faceDetails,
  });
}

class FaceDetails {
  String live;
  String livenessScore;
  String faceUri;

  FaceDetails({
    required this.live,
    required this.livenessScore,
    required this.faceUri,
  });
}

class HyperVergeSession {
  static var name = 'name';
  static var gender = 'gender';
  static var dob = 'dob';
  static var aadhaar = 'aadhaar';
  static var yob = 'yob';
  static var address = 'address';
  static var pin = 'pin';

  static Map? adhaarFront, adhaarBack;

  static Future<HyperVergeData?> startKYC() async {
    var frontUri;
    adhaarFront = null;
    adhaarBack = null;

    if (Utils.isWeb) {
      var output = await runOcr(true);
      if (output != null) {
        frontUri = output.image;
        adhaarFront = output.data;
      }
    } else {
      frontUri = await openDocumentCaptureScreen(true);
    }

    if (frontUri == null) {
      Utils.showToast(msg: LanguageHelper.textNeedToScanFrontDocAgain);
      return null;
    }
    debugPrint('Front uri done');
    var backUri;

    if (Utils.isWeb) {
      var output = await runOcr(false);
      if (output != null) {
        backUri = output.image;
        adhaarBack = output.data;
      }
    } else {
      backUri = await openDocumentCaptureScreen(false);
    }

    if (backUri == null) {
      Utils.showToast(msg: LanguageHelper.textNeedToScanFrontBackAgain);
      return null;
    }
    debugPrint('Back uri done');
    var faceDetails = (Utils.isWeb)
        ? (await runFaceScanner())
        : (await openFaceCaptureScreen());
    if (faceDetails == null) {
      Utils.showToast(msg: LanguageHelper.textNeedToScanFaceAgain);
      return null;
    }
    debugPrint('Face uri done');

    var data = HyperVergeData(
        frontUri: frontUri, backUri: backUri, faceDetails: faceDetails);
    return data;
  }

  static Future<String?> openDocumentCaptureScreen(bool isFront) async {
    var docUIStrings = {
      "docCaptureTitle": "Aadhar verification",
      "docCaptureDescription":
          "Make sure your document is without any glare and is fully inside",
      "docCaptureSubText": isFront ? "Front Side" : "Back Side",
      "docRetakeTitleText": "Retake Photo",
      "docRetakeButtonText": "Retake ID Card Photo",
      "docReviewRetakeButton": "Retake",
      "docReviewContinueButton": "Use This Photo",
      "docReviewTitle": "Review This Page",
      "docReviewDescription": "Make sure the image is clear and glare free",
    };

    HVDocsCapture.docsCaptureSetUIStrings(docUIStrings);
    HVDocsCapture.docsCaptureSetShouldShowReviewScreen(true);

    Map docCaptureMap = await HVDocsCapture.docsCaptureStart();

    Map docResultObj = docCaptureMap["resultObj"];
    Map docErrorObj = docCaptureMap["errorObj"];

    debugPrint("Doc Results Map - " + docResultObj.toString());
    debugPrint("Doc Error Map - " + docErrorObj.toString());

    if (docErrorObj.isNotEmpty) {
      // Handle error
      debugPrint(docErrorObj["errorCode"]?.toString());
      debugPrint(docErrorObj["errorMessage"]);
      Utils.showToast(msg: docErrorObj["errorMessage"]);

      return null;
    } else {
      // Handle success results
      debugPrint(docResultObj["apiResult"]);
      debugPrint(docResultObj["imageUri"]);
      return docResultObj["imageUri"];
    }
  }

  /// MARK: Open face capture
  static Future<FaceDetails?> openFaceCaptureScreen() async {
    var docUIStrings = {
      "docCaptureTitle": "Image verification",
      "docCaptureDescription":
          "Make sure your document is without any glare and is fully inside",
      "faceRetakeTitleText": "Retake Photo",
      "faceRetakeButtonText": "Retake Selfie",
    };

    HVFaceCapture.faceCaptureSetFaceCaptureTitle("Face Capture");
    HVFaceCapture.faceCaptureSetShouldShowCameraSwitchButton(true);

    Map faceCaptureMap = await HVFaceCapture.faceCaptureStart();

    Map faceResultObj = faceCaptureMap["resultObj"];
    Map faceErrorObj = faceCaptureMap["errorObj"];

    print(faceCaptureMap);
    debugPrint("Face Results Map - " + faceResultObj.toString());
    debugPrint("Face Error Map - " + faceErrorObj.toString());

    if (faceErrorObj.isNotEmpty) {
      // Handle error
      debugPrint(faceErrorObj["errorCode"]?.toString());
      debugPrint(faceErrorObj["errorMessage"]);
      Utils.showToast(msg: faceErrorObj["errorMessage"]);
      return null;
    } else {
      var apiResult = json.decode(faceResultObj["apiResult"]);
      var result = apiResult['result'];
      var live = result['live'];
      var score = result['liveness-score'];
      if (live == 'yes' && double.parse(score) >= 0.90) {
        return FaceDetails(
            live: live,
            livenessScore: score,
            faceUri: faceResultObj["imageUri"]);
      }
      Utils.showToast(msg: LanguageHelper.textCaptureLiveFace);
      return null;
    }
  }

  /// MARK: Face Match api

  static Future<int?> callFaceMatchApi(faceUri, documentUriFront) async {
// Create API request params
    Map params = new Map();
// Create API request headers
    Map headers = new Map();
    Map faceMatchAPICallResult =
        await HVNetworkHelper.networkHelperMakeFaceMatchCall(
      APIUrls.hyperVergeFaceApi,
      faceUri,
      documentUriFront,
      params,
      headers,
    );

    Map faceResultObj = faceMatchAPICallResult["resultObj"];
    Map faceErrorObj = faceMatchAPICallResult["errorObj"];

    debugPrint("Face Match result Map - " + faceResultObj.toString());
    debugPrint("Face Match Error Map - " + faceErrorObj.toString());

    if (faceErrorObj.isNotEmpty) {
      // Handle error
      debugPrint(faceErrorObj["errorCode"]?.toString());
      debugPrint(faceErrorObj["errorMessage"]);
      Utils.showToast(msg: faceErrorObj["errorMessage"]);
      return null;
    } else {
      var apiResult = json.decode(faceResultObj["apiResult"]);
      if (apiResult['statusCode'] == '200') {
        final result = apiResult['result'];
        if (result['match'] == 'yes') {
          print('match score hyperverge ${result["match-score"]}');
          return result["match-score"];
        }
        // print('match score hyperverge ${result["match-score"]}');
      }

      Utils.showToast(msg: LanguageHelper.textFaceNotMatch);
      return null;
    }
  }

  /// MARK: Call OCR api to get detail doc detail
  static Future<Map?> callOCRApi(docUri, isFront) async {
    if (Utils.isWeb) {
      return getAadharDetails(
          isFront ? adhaarFront as Map : adhaarBack as Map, isFront);
    }

// Create API request params
    Map params = new Map();
// Create API request headers
    Map headers = new Map();
    Map ocrAPICallResult = await HVNetworkHelper.networkHelperMakeOCRCall(
      APIUrls.hyperVergeOcrApi,
      docUri,
      params,
      headers,
    );

    Map ocrResultObj = ocrAPICallResult["resultObj"];
    Map ocrErrorObj = ocrAPICallResult["errorObj"];

    debugPrint("OCR result Map - " + ocrResultObj.toString());
    debugPrint("OCR Error Map - " + ocrErrorObj.toString());

    if (ocrErrorObj.isNotEmpty) {
      // Handle error
      debugPrint(ocrErrorObj["errorCode"]?.toString());
      debugPrint(ocrErrorObj["errorMessage"]);
      Utils.showToast(msg: ocrErrorObj["errorMessage"]);
      return null;
    } else {
      var apiResult = json.decode(ocrResultObj["apiResult"]);
      if (apiResult['statusCode'] == '200') {
        List<dynamic> result = apiResult['result'] as List<dynamic>;
        if (result.length > 0) {
          return getAadharDetails(result.first as Map, isFront);
        }
      }
      Utils.showToast(
          msg: 'Something went wrong! Unable to fetch Document detail');
      return null;
    }
  }

  //starting web integration of hyperverse

  //use to init hyperverse on web
  static Future<String?> generateWebTokenHyperverse(
      BuildContext context) async {
    var code = await http.post(Uri.parse(APIUrls.hyperverseToken),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader:
              APICalling.getApiClient(context: context).getToken(),
        },
        body: json.encode({
          "appId": Constants.hyperVergeAppId,
          "appKey": Constants.hyperVergeAppKey,
          "expiry": 18000
        }));

    var data = json.decode(code.body);

    print(data);
    var token = data["result"]["token"];
    return token;
  }

  //use to start kyc on web
  // static startKYCWeb(Function(String error) onError,
  //     Function(
  //         HyperVergeData? resultUri,
  //         Map? docData,
  //         Map? faceMatchData,
  //         )
  //     onSuccess) async {
  //   final channel = js.context;
  //   HyperVergeData? result;
  //   var frontDocUri;
  //   var faceUri;
  //   Map docData;
  //   Map faceMatchData;
  //
  //
  //
  //
  //
  //   channel.callMethod("runDocumentOcr", [
  //     true,
  //         (response) {
  //       debugPrint("response");
  //       frontDocUri = json.decode(response)["imgBase64"];
  //       docData = json.decode(response)["result"];
  //
  //       channel.callMethod("runFaceScanner", [
  //             (response) {
  //           debugPrint("response");
  //           faceUri = json.decode(response)["imgBase64"];
  //           // docData = json.decode(response)["result"];
  //           js.context.callMethod("matchFaceApi", [
  //             faceUri,
  //             frontDocUri,
  //                 (response) {
  //               debugPrint("response");
  //
  //               faceMatchData = json.decode(response);
  //
  //               //returning data to caller side
  //               onSuccess(
  //                   HyperVergeData(
  //                       frontUri: frontDocUri, backUri: "",faceDetails: FaceDetails(live: "live", livenessScore: "livenessScore", faceUri: faceUri)),
  //                   docData,
  //                   faceMatchData);
  //
  //               debugPrint(docData.toString());
  //             },
  //                 (error) {
  //               onError(error);
  //               debugPrint("error");
  //               debugPrint(error);
  //             }
  //           ]);
  //
  //           debugPrint(response);
  //         },
  //             (error) {
  //           Utils.showToast(
  //               msg: 'Something went wrong! Unable to match face detail');
  //           onError(error);
  //           debugPrint(error);
  //         }
  //       ]);
  //     },
  //         (error) {
  //       onError(error);
  //       Utils.showToast(msg: 'Something went wrong! on fetch  document detail');
  //       debugPrint("error");
  //       debugPrint(error);
  //     }
  //   ]);
  // }

  /// Deconstruction of Aadhar card details
  static Map? getAadharDetails(aadharDetail, isFront) {
    if (!aadharDetail.containsKey('details')) {
      return null;
    }
    var aadharMap = Map<String, String>();
    var details = aadharDetail['details'];
    if (isFront) {
      if (details.containsKey(name)) {
        aadharMap[name] = details[name]['value'];
      }
      if (details.containsKey(gender)) {
        aadharMap[gender] = details[gender]['value'];
      }
      if (details.containsKey(dob) && details[dob]['value'] != null) {
        aadharMap[dob] = details[dob]['value'];
      } else if (details.containsKey(yob) && details[yob]['value'] != null) {
        aadharMap[dob] = details[yob]['value'];
      }
      if (details.containsKey(aadhaar)) {
        aadharMap[aadhaar] = details[aadhaar]['value'];
      }
    } else {
      if (details.containsKey(address)) {
        aadharMap[address] = details[address]['value'];
      }
      if (details.containsKey(pin)) {
        aadharMap[pin] = details[pin]['value'];
      }
    }
    return aadharMap;
  }
}
