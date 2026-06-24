import 'dart:async';

import 'package:Monexo/language/language_en.dart';
import 'package:Monexo/modules/onboardingSteps/models/cashfree_response.dart';
import 'package:Monexo/providers/app_state_provider.dart';
import 'package:Monexo/supporting_file/web_utils.dart';
import 'package:Monexo/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart';

import '../../../routes_management/routes_list.dart';
import '../../../supporting_file/appsFlyerSdk.dart';
import '../../../utils/constants.dart';

class PaymentWebScreen extends StatefulWidget {
  final CashFreeResponse cashFreeResponse;
  final String amount;

  PaymentWebScreen({
    required this.cashFreeResponse,
    required this.amount,
  });

  @override
  _PaymentWebScreenState createState() => _PaymentWebScreenState();
}

class _PaymentWebScreenState extends State<PaymentWebScreen> {
  Timer? timer;

  @override
  void initState() {
    if (Utils.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();

    if (Utils.isWeb) {
      isLoading.value = false;
      timer = Timer.periodic(Duration(seconds: 5), (timer) {
        getOrderStatus(widget.cashFreeResponse.orderId ?? "", isDelay: false);
      });
      openWebWindow(widget.cashFreeResponse.data?.url ?? "");
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.cashFreeResponse.data!.url.isEmpty) {
        getOrderStatus(widget.cashFreeResponse.orderId ?? "");
      }
    });
  }

  late WebViewXController webViewController;
  var isLoading = ValueNotifier(true);
  bool onStartResponded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var userAgent = "";
    if (Utils.isAndroid) {
      userAgent =
          'Mozilla/5.0 (iPhone; CPU iPhone OS 13_2_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Mobile/15E148 Safari/604.1';
    } else if (Utils.isIos) {
      userAgent =
          'Mozilla/5.0 (Linux; Android 8.0.0; SM-G955U Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Mobile Safari/537.36';
    }
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Builder(builder: (context) {
          if (Utils.isWeb) {
            return Center(
              child: Container(
                width: size.shortestSide,
                height: size.shortestSide,
                child: AlertDialog(
                  title: Text("Fetching Payment Details"),
                  content: Text(
                      "if you already made payment, tap to refresh details"),
                  actions: [
                    ValueListenableBuilder<bool>(
                        valueListenable: isLoading,
                        builder: (context, loading, _) {
                          if (loading) {
                            return TextButton.icon(
                                onPressed: null,
                                icon: SizedBox(
                                  height: 12,
                                  width: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                label: Text("Checking"));
                          }

                          return TextButton(
                              onPressed: () {
                                print("order id " +
                                    (widget.cashFreeResponse.orderId ?? ""));
                                getOrderStatus(
                                    widget.cashFreeResponse.orderId ?? "");
                              },
                              child: Text("Refresh"));
                        })
                  ],
                ),
              ),
            );
          }

          //for upi link method
          if (widget.cashFreeResponse.data!.url.isEmpty &&
              widget.cashFreeResponse.data?.payload?.entries.length > 0) {
            return Column(
              children: widget.cashFreeResponse.data!.payload!.entries
                  .toList()
                  .map((e) => Card(
                        child: ListTile(
                          title: Text(e.key),
                          onTap: () {
                            launch(e.value);
                          },
                        ),
                      ))
                  .toList(),
            );
          }

          return Stack(
            children: [
              WebViewX(
                height: size.height,
                width: size.width,
                initialContent: widget.cashFreeResponse.data!.url,
                // javascriptMode: JavascriptMode.unrestricted,
                userAgent: Utils.isWeb ? null : userAgent,
                webSpecificParams: WebSpecificParams(
                    webAllowFullscreenContent: true,
                    additionalSandboxOptions: [
                      "allow-forms",
                      "allow-scripts",
                      "allow-top-navigation"
                    ]),
                initialSourceType: SourceType.url,
                onPageStarted: (value) {
                  isLoading.value = false;
                  print(value);
                  if (value.contains("order_id")) {
                    final uri = Uri.dataFromString(value);
                    final id = uri.queryParameters['order_id'];
                    if (id != null) {
                      setState(() {
                        onStartResponded = true;
                      });
                      getOrderStatus(id);
                    }
                  }
                },
                onPageFinished: (url) {
                  print("finished $url");
                  if (url.contains("order_id") && Utils.isIos) {
                    final uri = Uri.dataFromString(url);
                    final id = uri.queryParameters['order_id'];
                    if (id != null && !onStartResponded) {
                      getOrderStatus(id);
                    }
                  }
                },
                onWebViewCreated: (controller) =>
                    webViewController = controller,
              ),
              WebViewAware(
                child: ValueListenableBuilder<bool>(
                  valueListenable: isLoading,
                  builder: (context, loading, child) {
                    if (loading) {
                      return Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator());
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Future<void> SetRegistrationStatus(bool status) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setBool('set_registrationStatus', status);
  }

  //for simulating process without backend
  Future getOrderStatus(String orderId, {bool isDelay = true}) async {
    isLoading.value = true;
    if (isDelay) await Future.delayed(Duration(seconds: 4));
    final cashFreeResponse =
        await context.read<AppStateProvider>().getCashFreeOrderStatus(orderId);
    isLoading.value = false;

    if (cashFreeResponse != null) {
      if (cashFreeResponse.orderStatus == "ACTIVE" && !isDelay) {
        return;
      }

      //closing browser window

      if (Utils.isWeb) {
        closeWindow();
        timer!.cancel();
      }
      context.read<AppStateProvider>().getUserFundDetails();
      context.read<AppStateProvider>().getStepsStatus();

      var value = Map<String, dynamic>();
      value["af_revenue"] = widget.amount;
      value["af_currency"] = "INR";
      // AFSdk.logEvent(AFSdk.af_fundTransfer, value);

      Future.delayed(Duration(seconds: 5), () {
        Utils.showRatingAlert(context: context);
      });
      Utils.showAlert(
          context: context,
          msg: cashFreeResponse.txMsg ?? "Payment pending!",
          onTap: () async {
            var pref = await SharedPreferences.getInstance();
            var getRegistrationStatus =
                await pref.getBool('set_registrationStatus') ?? true;
            if (getRegistrationStatus) {
              SetRegistrationStatus(false);
            }
            context.pushNamed(RoutesName.FundTransferSuccessScreen, params: {
              Constants.amount: widget.amount,
              Constants.cashFreeText: cashFreeResponse.txMsg ?? 'pending'
            });
          });
    } else {
      if (!isDelay) {
        Utils.showAlert(
            context: context,
            msg: LanguageHelper.textSomethingWentWrong,
            onTap: () async {
              var pref = await SharedPreferences.getInstance();
              var getRegistrationStatus =
                  await pref.getBool('set_registrationStatus') ?? true;
              if (getRegistrationStatus) {
                SetRegistrationStatus(false);
                context.pushNamed(RoutesName.HomeScreen, queryParams: {
                  "data": Utils.buildTokenJson(
                      context.read<AppStateProvider>().token ?? "",
                      context.read<AppStateProvider>().customerId)
                });
              } else {
                Navigator.pop(context);
              }
            });
      }
    }

// if((cashFreeResponse.orderStatus??"")=="SUCCESS")
// {
//   return true;
// }
//
// if((cashFreeResponse.orderStatus??"")=="FAILED")
// {
//   return false;
// }
  }

  @override
  void dispose() {
    if (Utils.isWeb) {}
    super.dispose();
  }
}
