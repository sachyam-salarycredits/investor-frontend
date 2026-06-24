


// client calls the auth api to get the token from their backend server
// var bc = new BroadcastChannel('internal_notification');
// bc.postMessage('New listening connected!');

var faceImage = '';
var docImage = '';
 var flyySDK = new FlyySDK();
function init(token) {

    var jwtToken = token;

    HyperSnapSDK.init(jwtToken, HyperSnapParams.Region.India);
    HyperSnapSDK.startUserSession();

    console.log("hyperverse initialised");
}

async function runOcrFuture(isFront) {
    var data = await runDocumentOcrPromise(isFront);
    console.log(data);
    return data;
}


function initFlyySdk(token, deviceId, partnerId, stage) {
    var data = {
          package_name: "com.monexo.lender.app",
          partner_id: partnerId,
          ext_user_token: token,
          device_id: deviceId,
          environment: stage //"STAGE" //"PRODUCTION"
        };
    console.log(data);
    flyySDK.initSDK(JSON.stringify(data));

    console.log("Flyy web initialised");
}

function initStartReferalTracking() {
    flyySDK.startReferralTracking();
}





// function startProcess() {

//     runLiveness();
// }

// function runLiveness() {
//     hvFaceConfig = new HVFaceConfig();
//     hvFaceConfig.setShouldShowInstructionPage(true);
//     hvFaceConfig.setLivenessAPIParameters({
//         rejectFaceMask: 'yes',
//         allowEyesClosed: 'no',
//         allowMultipleFaces: 'no',
//     });

//     callback = (HVError, hvResponse) => {

//         if (HVError) {
//             var para = document.createElement('p');
//             var node = document.createTextNode(JSON.stringify(HVError));
//             para.appendChild(node);
//             var element = document.getElementById('error');
//             element.appendChild(para);

//         } else {
//             var para = document.createElement('p');
//             var node = document.createTextNode(JSON.stringify(hvResponse));
//             var element = document.getElementById('response');
//             element.appendChild(para);


//         }

//     };
//     HVFaceModule.start(hvFaceConfig, callback);





// }



// function runOCR(isFront) {


//     hvDocConfig = new HVDocConfig();

//     var type = hvDocConfig.DocumentSide.FRONT;
//     if (isFront) {
//         type = hvDocConfig.DocumentSide.BACK;
//     } else {
//         type = hvDocConfig.DocumentSide.FRONT
//     }

//     hvDocConfig.setOCRDetails(
//         'https://ind-docs.hyperverge.co/v2.0/readKYC',
//         type,
//         {},
//         {},
//     );
//     hvDocConfig.setShouldShowInstructionPage(true);
//     hvDocConfig.setShouldShowDocReviewScreen(true);

//     callback = (HVError, hvResponse) => {
//         if (HVError) {
//             //case of error
//             console.log(HVError);

//             return null;
//         } else {


//             var apiResults = hvResponse.getApiResult();
//             var apiHeaders = hvResponse.getApiHeaders();
//             var imageBase64 = hvResponse.getImageBase64();
//             //case of response

//             bc.postMessage(imageBase64);
//             console.log(hvResponse);
//             docImage = imageBase64;
//             console.log(docImage);

//             return matchFaceCall();

//         }
//     };

//     HVDocsModule.start(hvDocConfig, callback);



// }


// function matchFaceCall() {

//     console.log(faceImage);

//     console.log(docImage);


//     console.log("started");

//     var callback = (HVError, HVResponse) => {
//         if (HVError) {
//             var errorCode = HVError.getErrorCode();
//             var errorMessage = HVError.getErrorMessage();
//             console.log(HVError);
//             return null;
//         }
//         if (HVResponse) {
//             var apiResults = HVResponse.getApiResult();
//             var apiHeaders = HVResponse.getApiHeaders();

//             console.log(HVResponse);

//             return apiResults;

//         }
//     };

//     console.log("end with callback");


//     HVNetworkHelper.makeFaceMatchCall(faceImage, docImage, {}, {}, callback);


//     console.log("end with network call");
// }


// async function runOcrFuture(result) {

//     var data = await runOcrPromise();
//     // var para = document.createElement('p');
//     // var node = document.createTextNode(data);
//     // var element = document.getElementById('response');
//     // element.appendChild(para);

//     result(data);
//     return data;
// }



function runDocumentOcr(isFront, onSuccess, onError) {
    hvDocConfig = new HVDocConfig();

    var type = hvDocConfig.DocumentSide.FRONT;
    if (isFront == true) {
     hvDocConfig.setDocCaptureTitle("Capture Front Of Your Aadhaar Card")
        type = hvDocConfig.DocumentSide.FRONT;
    } else {
         hvDocConfig.setDocCaptureTitle("Capture Back Of Your Aadhaar Card")
        type = hvDocConfig.DocumentSide.BACK
    }


    hvDocConfig.setOCRDetails(
        'https://ind-docs.hyperverge.co/v2.0/readKYC',
        type,
        {},
        {},
    );
    hvDocConfig.setShouldShowInstructionPage(true);
    hvDocConfig.setShouldShowDocReviewScreen(true);
    return new Promise((resolve, reject) => {

        HVDocsModule.start(hvDocConfig, (HVError, hvResponse) => {
            if (HVError) {
                //case of error



                return reject(JSON.stringify(HVError));


            } else {


                return resolve(JSON.stringify(hvResponse));
            }
        });
    }).then((value) => {
        onSuccess(value);
        return value;
    }).catch((e) => {
        onError(e);
        return e;
    })


}




async function runFaceFuture() {
    hvFaceConfig = new HVFaceConfig();
    hvFaceConfig.setShouldShowInstructionPage(true);
    hvFaceConfig.setLivenessAPIParameters({
        rejectFaceMask: 'yes',
        allowEyesClosed: 'no',
        allowMultipleFaces: 'no',
    });
    return new Promise((resolve, reject) => {

        HVFaceModule.start(hvFaceConfig, (HVError, hvResponse) => {
            if (HVError) {
                //case of error

                return reject(JSON.stringify(HVError));


            } else {


                return resolve(JSON.stringify(hvResponse));
            }
        });
    }).then((value) => {

        return value;
    }).catch((e) => {

        return e;
    })
}

function runFaceScanner(onSuccess, onError) {
    hvFaceConfig = new HVFaceConfig();
    hvFaceConfig.setShouldShowInstructionPage(true);
    hvFaceConfig.setLivenessAPIParameters({
        rejectFaceMask: 'yes',
        allowEyesClosed: 'no',
        allowMultipleFaces: 'no',
    });
    return new Promise((resolve, reject) => {

        HVFaceModule.start(hvFaceConfig, (HVError, hvResponse) => {
            if (HVError) {
                //case of error

                return reject(JSON.stringify(HVError));


            } else {


                return resolve(JSON.stringify(hvResponse));
            }
        });
    }).then((value) => {
        onSuccess(value);
        return value;
    }).catch((e) => {
        onError(e);
        return e;
    })
}


async function runFaceMatchApiFuture(faceImage, docImage) {
    return new Promise((resolve, reject) => {

        HVNetworkHelper.makeFaceMatchCall(faceImage, docImage, {}, {}, (HVError, hvResponse) => {
            if (HVError) {
                //case of error

                return reject(JSON.stringify(HVError));


            } else {


                return resolve(JSON.stringify(hvResponse));
            }
        });
    }).then((value) => {

console.log(value);

        return value;
    }).catch((e) => {


console.log(e);

        return e;
    })

}

function matchFaceApi(faceImage, docImage, onSuccess, onError) {

    return new Promise((resolve, reject) => {

        HVNetworkHelper.makeFaceMatchCall(faceImage, docImage, {}, {}, (HVError, hvResponse) => {
            if (HVError) {
                //case of error

                return reject(JSON.stringify(HVError));


            } else {


                return resolve(JSON.stringify(hvResponse));
            }
        });
    }).then((value) => {
        onSuccess(value);
        return value;
    }).catch((e) => {
        onError(e);
        return e;
    })


}


async function detectCamera(){

return new Promise((resolve, reject) => {

        HVCamModule.detectWebcam().then((cameraDetected) => {
          if(!cameraDetected){

          reject(null);
          }else{

          resolve(true);
          }

        });
    }).then((value) => {

        return value;
    }).catch((e) => {

        return e;
    })

}
async function runDocumentOcrPromise(isFront) {
    hvDocConfig = new HVDocConfig();

 var type = hvDocConfig.DocumentSide.FRONT;
    if (isFront == true) {
        type = hvDocConfig.DocumentSide.FRONT;
    } else {
        type = hvDocConfig.DocumentSide.BACK;
    }
    hvDocConfig.setOCRDetails(
        'https://ind-docs.hyperverge.co/v2.0/readKYC',
        type,
        {},
        {},
    );
    hvDocConfig.setShouldShowInstructionPage(true);
    hvDocConfig.setShouldShowDocReviewScreen(true);
    return new Promise((resolve, reject) => {

        HVDocsModule.start(hvDocConfig, (HVError, hvResponse) => {
            if (HVError) {
                //case of error



                return reject(JSON.stringify(HVError));


            } else {


                return resolve(JSON.stringify(hvResponse));
            }
        });
    }).then((value) => {
        // onSuccess(value);
        return value;
    }).catch((e) => {
        // onError(e);
        return e;
    })


}

// function startKyc(onSuccess, onError) {
//     await runDocumentOcr(true, onSuccess, onError);
//     await runFaceScanner(onSuccess, onError);

// }

