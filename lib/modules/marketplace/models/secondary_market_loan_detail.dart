// To parse this JSON data, do
//
//     final secondartMarketLoanDetail = secondartMarketLoanDetailFromJson(jsonString);

import 'dart:convert';

SecondaryMarketLoanDetail secondartMarketLoanDetailFromJson(String str) =>
    SecondaryMarketLoanDetail.fromJson(json.decode(str));

String secondartMarketLoanDetailToJson(SecondaryMarketLoanDetail data) =>
    json.encode(data.toJson());

class SecondaryMarketLoanDetail {
  SecondaryMarketLoanDetail({
    this.repayments = const [],
    this.aboutInvestmentOrder,
  });

  List<Repayment> repayments;
  AboutInvestmentOrder? aboutInvestmentOrder;

  factory SecondaryMarketLoanDetail.fromJson(Map<String, dynamic> json) =>
      SecondaryMarketLoanDetail(
        repayments: json["repayments"] == null
            ? []
            : List<Repayment>.from(
                json["repayments"].map((x) => Repayment.fromJson(x))),
        aboutInvestmentOrder: json["aboutInvestmentOrder"] == null
            ? null
            : AboutInvestmentOrder.fromJson(json["aboutInvestmentOrder"]),
      );

  Map<String, dynamic> toJson() => {
        "repayments": List<dynamic>.from(repayments.map((x) => x.toJson())),
        "aboutInvestmentOrder": aboutInvestmentOrder == null
            ? null
            : aboutInvestmentOrder!.toJson(),
      };
}

class AboutInvestmentOrder {
  AboutInvestmentOrder({
    this.tenor = 0,
    this.status = "",
    this.rating = "",
    this.principalReceived = 0,
    this.paymentReceivedTillDate = 0,
    this.monexoFees = "",
    this.miscIncome = "",
    this.loanAmount = 0,
    this.interestReceived = 0,
    this.interestRate = 0,
    this.balancePrincipalOs = 0,
  });

  int tenor;
  String status;
  String rating;
  int principalReceived;
  int paymentReceivedTillDate;
  dynamic monexoFees;
  dynamic miscIncome;
  int loanAmount;
  int interestReceived;
  int interestRate;
  int balancePrincipalOs;

  factory AboutInvestmentOrder.fromJson(Map<String, dynamic> json) =>
      AboutInvestmentOrder(
        tenor: json["tenor"] == null ? 0 : json["tenor"].toInt(),
        status: json["status"] == null ? "" : json["status"],
        rating: json["rating"] ?? "",
        principalReceived: json["principalReceived"] == null
            ? 0
            : json["principalReceived"].toInt(),
        paymentReceivedTillDate: json["paymentReceivedTillDate"] == null
            ? 0
            : json["paymentReceivedTillDate"].toInt(),
        monexoFees: json["monexoFees"] ?? "",
        miscIncome: json["miscIncome"] ?? "",
        loanAmount: json["loanAmount"] == null ? 0 : json["loanAmount"].toInt(),
        interestReceived: json["interestReceived"] == null
            ? 0
            : json["interestReceived"].toInt(),
        interestRate:
            json["interestRate"] == null ? 0 : json["interestRate"].toInt(),
        balancePrincipalOs: json["balancePrincipalOS"] == null
            ? 0
            : json["balancePrincipalOS"].toInt(),
      );

  Map<String, dynamic> toJson() => {
        "tenor": tenor,
        "status": status,
        "rating": rating,
        "principalReceived": principalReceived,
        "paymentReceivedTillDate": paymentReceivedTillDate,
        "monexoFees": monexoFees,
        "miscIncome": miscIncome,
        "loanAmount": loanAmount,
        "interestReceived": interestReceived,
        "interestRate": interestRate,
        "balancePrincipalOS": balancePrincipalOs,
      };
}

class Repayment {
  Repayment({
    this.transationId = "",
    this.repaymentDate,
    this.principalReceived = 0,
    this.paidByBorrower = 0,
    this.netAmount = 0,
    this.monexoFee = 0,
    this.miscIncome = 0,
    this.interest = "",
  });

  String transationId;
  DateTime? repaymentDate;
  int principalReceived;
  int paidByBorrower;
  int netAmount;
  int monexoFee;
  int miscIncome;
  String interest;

  factory Repayment.fromJson(Map<String, dynamic> json) => Repayment(
        transationId: json["transationId"] == null ? "" : json["transationId"],
        repaymentDate: json["repaymentDate"] == null
            ? null
            : DateTime.parse(json["repaymentDate"]),
        principalReceived: json["principalReceived"] == null
            ? 0
            : json["principalReceived"].toInt(),
        paidByBorrower:
            json["paidByBorrower"] == null ? 0 : json["paidByBorrower"].toInt(),
        netAmount: json["netAmount"] == null ? 0 : json["netAmount"].toInt(),
        monexoFee: json["monexoFee"] == null ? 0 : json["monexoFee"].toInt(),
        miscIncome: json["miscIncome"] == null ? 0 : json["miscIncome"].toInt(),
        interest: json["interest"] == null ? "" : json["interest"],
      );

  Map<String, dynamic> toJson() => {
        "transationId": transationId,
        "repaymentDate":
            "${repaymentDate!.year.toString().padLeft(4, '0')}-${repaymentDate!.month.toString().padLeft(2, '0')}-${repaymentDate!.day.toString().padLeft(2, '0')}",
        "principalReceived": principalReceived,
        "paidByBorrower": paidByBorrower,
        "netAmount": netAmount,
        "monexoFee": monexoFee,
        "miscIncome": miscIncome,
        "interest": interest,
      };
}
