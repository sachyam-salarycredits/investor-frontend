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
  static const _pollInterval = Duration(seconds: 5);

  late WebViewXController webViewController;
  var isLoading = ValueNotifier(true);
  bool onStartResponded = false;
  bool _paymentResolved = false;

  @override
  void initState() {
    if (Utils.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();

    final orderId = widget.cashFreeResponse.orderId ?? "";

    if (Utils.isWeb) {
      isLoading.value = false;
      _startStatusPolling(orderId);
      openWebWindow(widget.cashFreeResponse.data?.url ?? "");
    } else {
      _startStatusPolling(orderId);
    }
  }

  void _startStatusPolling(String orderId) {
    if (orderId.isEmpty) return;
    timer?.cancel();
    getOrderStatus(orderId, isPolling: true);
    timer = Timer.periodic(_pollInterval, (_) {
      getOrderStatus(orderId, isPolling: true);
    });
  }

  void _stopPolling() {
    timer?.cancel();
    timer = null;
  }

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
                                    widget.cashFreeResponse.orderId ?? "",
                                    isPolling: false);
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
                      getOrderStatus(id, isPolling: true);
                    }
                  }
                },
                onPageFinished: (url) {
                  print("finished $url");
                  if (url.contains("order_id") && Utils.isIos) {
                    final uri = Uri.dataFromString(url);
                    final id = uri.queryParameters['order_id'];
                    if (id != null && !onStartResponded) {
                      getOrderStatus(id, isPolling: true);
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

  Future<void> getOrderStatus(String orderId,
      {bool isPolling = false}) async {
    if (_paymentResolved || !mounted || orderId.isEmpty) return;

    isLoading.value = true;
    if (!isPolling) {
      await Future.delayed(const Duration(seconds: 4));
    }
    final cashFreeResponse =
        await context.read<AppStateProvider>().getCashFreeOrderStatus(orderId);
    isLoading.value = false;

    if (!mounted || _paymentResolved) return;

    if (cashFreeResponse == null) {
      if (!isPolling) {
        _showStatusError();
      }
      return;
    }

    final status = (cashFreeResponse.orderStatus ?? '').toUpperCase();

    if (status == 'ACTIVE' || status == 'PENDING') {
      return;
    }

    if (status != 'SUCCESS') {
      _paymentResolved = true;
      _stopPolling();
      Utils.showAlert(
        context: context,
        msg: cashFreeResponse.txMsg ?? LanguageHelper.textSomethingWentWrong,
        onTap: () => Navigator.pop(context),
      );
      return;
    }

    _paymentResolved = true;
    _stopPolling();

    if (Utils.isWeb) {
      closeWindow();
    }

    context.read<AppStateProvider>().getUserFundDetails();
    context.read<AppStateProvider>().getStepsStatus();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        Utils.showRatingAlert(context: context);
      }
    });
    Utils.showAlert(
        context: context,
        msg: cashFreeResponse.txMsg ?? LanguageHelper.textFundTransfer,
        onTap: () async {
          var pref = await SharedPreferences.getInstance();
          var getRegistrationStatus =
              await pref.getBool('set_registrationStatus') ?? true;
          if (getRegistrationStatus) {
            SetRegistrationStatus(false);
          }
          context.pushNamed(RoutesName.FundTransferSuccessScreen, params: {
            Constants.amount: widget.amount,
            Constants.cashFreeText:
                cashFreeResponse.txMsg ?? LanguageHelper.textFundTransfer
          });
        });
  }

  void _showStatusError() {
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

  @override
  void dispose() {
    _stopPolling();
    super.dispose();
  }
}
