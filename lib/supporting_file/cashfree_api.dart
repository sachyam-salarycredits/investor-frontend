import 'dart:convert';

import 'package:Monexo/language/language_en.dart';
import 'package:Monexo/modules/onboardingSteps/models/cashfree_response.dart';
import 'package:Monexo/modules/onboardingSteps/screens/web_payment.dart';
import 'package:Monexo/supporting_file/api_calling.dart';
import 'package:Monexo/utils/constants.dart';
import 'package:Monexo/utils/utils.dart';
import 'package:flutter/material.dart';

import '../utils/enums.dart';

class CashFreeParams {
  String orderID;
  String orderAmount;
  String? orderToken;
  String tokenData;
  String customerName;
  String customerPhone;
  String customerEmail;
  String? paymentCode;
  String? upiID;
  String? paymentLink;

  CashFreeParams({
    required this.orderID,
    required this.orderAmount,
    required this.tokenData,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    this.orderToken,
    this.paymentCode = '',
    this.upiID = '',
  });
}

class PaymentOptions {
  String typeLabel;
  PaymentType type;

  PaymentOptions({
    required this.type,
    required this.typeLabel,
  });
}

class CashFreeApi {
  //NOTE change it "TEST" for development and "PROD" for production
  static String currency = 'INR';
  static String stage = Constants.isProd ? "PROD" : "TEST";
  static String notifyUrl = 'https://test.gocashfree.com/notify';

  static var upiApps;

  static var paymentTypes = <PaymentOptions>[
    PaymentOptions(type: PaymentType.upi, typeLabel: 'UPI'),
    PaymentOptions(type: PaymentType.netBanking, typeLabel: 'Internet Banking'),
  ];

  //MARK:- Make Netbanking payment
  static Future<bool> doNetBankingPayment(CashFreeParams params) async {
    debugPrint('LOCAL MODE: Cashfree native SDK disabled');
    Utils.showToast(msg: 'Payments disabled in local dev mode');
    return false;
  }

  //MARK:- Make UPI Payment
  static Future<bool> doUpiPayment(CashFreeParams params) async {
    debugPrint('LOCAL MODE: Cashfree native SDK disabled');
    Utils.showToast(msg: 'Payments disabled in local dev mode');
    return false;
  }
}

class CashFreeApiWeb {
  //for testing
  static final CASH_FREE_URL = Constants.isProd
      ? "https://api.cashfree.com/pg"
      : "https://sandbox.cashfree.com/pg";
  static final PAY_URL = "$CASH_FREE_URL/orders/pay";
  static final CHECK_ORDER_STATUS = "$CASH_FREE_URL/orders/";

  //NOTE change it "TEST" for development and "PROD" for production
  static String currency = 'INR';
  static String stage = Constants.isProd ? "PROD" : "TEST";
//  static String notifyUrl = 'https://test.gocashfree.com/notify';

  static var upiApps;

  static var paymentTypes = <PaymentOptions>[
    PaymentOptions(type: PaymentType.upi, typeLabel: 'UPI'),
    PaymentOptions(type: PaymentType.netBanking, typeLabel: 'Internet Banking'),
  ];

  //MARK:- Make Netbanking payment
  static doNetBankingPayment(
      CashFreeParams params, BuildContext context, String amount) async {
    print("code ${params.paymentCode}");
    final body = {
      "order_token": "${params.orderToken}",
      "payment_method": {
        "netbanking": {
          "channel": "link",
          "netbanking_bank_code": int.tryParse(params.paymentCode ?? "0")
        }
      }
    };

    final apiCall = APICalling.getApiClient(context: context);

    final data = await apiCall.postRequest(
        url: PAY_URL, parameters: body, headers: null);

    if (data.isEmpty) {
      return;
    }
    final result = json.decode(data);

    final response = CashFreeResponse.fromJson(result);
    response.orderId = params.orderID;

    if (response.data != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentWebScreen(
                    cashFreeResponse: response,
                    amount: amount,
                  )));
    } else {
      Utils.showAlert(
          context: context, msg: LanguageHelper.textSomethingWentWrong);
    }
  }

  //MARK:- Make UPI Payment
  static doUpiPayment(
      CashFreeParams params, BuildContext context, String amount) async {
    final body = {
      "order_token": "${params.orderToken}",
      "payment_method": {
        "upi": {"channel": "link", "upi_id": params.upiID ?? ""}
      }
    };
    final apiCall = APICalling.getApiClient(context: context);

    final data = await apiCall.postRequest(
        url: PAY_URL, parameters: body, headers: null);

    if (data.isEmpty) {
      return;
    }
    final result = json.decode(data);

    final response = CashFreeResponse.fromJson(result);

    response.data?.url = params.paymentLink ?? "";
    response.orderId = params.orderID;

    if (response.data != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentWebScreen(
                    cashFreeResponse: response,
                    amount: amount,
                  )));
    } else {
      Utils.showAlert(
          context: context, msg: LanguageHelper.textSomethingWentWrong);
    }
  }
}
