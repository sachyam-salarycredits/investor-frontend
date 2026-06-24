// // To parse this JSON data, do
// //
// //     final viewRiskDataModel = viewRiskDataModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ViewRiskDataModel viewRiskDataModelFromJson(String str) =>
//     ViewRiskDataModel.fromJson(json.decode(str));
//
// String viewRiskDataModelToJson(ViewRiskDataModel data) =>
//     json.encode(data.toJson());
//
// class ViewRiskDataModel {
//   ViewRiskDataModel({
//     this.data,
//     this.sfLogs,
//   });
//
//   RiskData? data;
//   dynamic sfLogs;
//
//   factory ViewRiskDataModel.fromJson(Map<String, dynamic> json) =>
//       ViewRiskDataModel(
//         data: RiskData.fromJson(json["data"]),
//         sfLogs: json["sfLogs"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": data?.toJson(),
//         "sfLogs": sfLogs,
//       };
// }
//
// class RiskData {
//   RiskData({
//     this.tenureData,
//     this.statusCode,
//     this.risk,
//     this.remainingTenureData,
//     this.message,
//     this.interestRateList,
//   });
//
//   List<TenureDatum>? tenureData;
//   int? statusCode;
//   Risk? risk;
//   List<TenureDatum>? remainingTenureData;
//   String? message;
//   List<InterestRateList>? interestRateList;
//
//   factory RiskData.fromJson(Map<String, dynamic> json) => RiskData(
//         tenureData: List<TenureDatum>.from(
//             json["tenureData"].map((x) => TenureDatum.fromJson(x))),
//         statusCode: json["statusCode"],
//         risk: Risk.fromJson(json["risk"]),
//         remainingTenureData: List<TenureDatum>.from(
//             json["remainingTenureData"].map((x) => TenureDatum.fromJson(x))),
//         message: json["message"],
//         interestRateList: List<InterestRateList>.from(
//             json["interestRateList"].map((x) => InterestRateList.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "tenureData": List<dynamic>.from(tenureData.map((x) => x.toJson())),
//         "statusCode": statusCode,
//         "risk": risk?.toJson(),
//         "remainingTenureData":
//             List<dynamic>.from(remainingTenureData.map((x) => x.toJson())),
//         "message": message,
//         "interestRateList":
//             List<dynamic>.from(interestRateList.map((x) => x.toJson())),
//       };
// }
//
// class InterestRateList {
//   InterestRateList({
//     this.xirr,
//     this.startDate,
//     this.name,
//     this.investmentAmount,
//     this.interestRateonLoanRange,
//     this.interestRateonLoan,
//     this.contractId,
//   });
//
//   double? xirr;
//   DateTime? startDate;
//   String? name;
//   int? investmentAmount;
//   String? interestRateonLoanRange;
//   double? interestRateonLoan;
//   String? contractId;
//
//   factory InterestRateList.fromJson(Map<String, dynamic> json) =>
//       InterestRateList(
//         xirr: json["XIRR"].toDouble(),
//         startDate: DateTime.parse(json["startDate"]),
//         name: json["name"],
//         investmentAmount: json["investmentAmount"],
//         interestRateonLoanRange: json["interestRateonLoanRange"],
//         interestRateonLoan: json["interestRateonLoan"].toDouble(),
//         contractId: json["contractId"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "XIRR": xirr,
//         "startDate":
//             "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
//         "name": name,
//         "investmentAmount": investmentAmount,
//         "interestRateonLoanRange": interestRateonLoanRange,
//         "interestRateonLoan": interestRateonLoan,
//         "contractId": contractId,
//       };
// }
//
// class TenureDatum {
//   TenureDatum({
//     this.xirr,
//     this.totalTerm,
//     this.termCategory,
//     this.status,
//     this.startDate,
//     this.remainingTerm,
//     this.remainingAmount,
//     this.name,
//     this.contractId,
//     this.amount,
//   });
//
//   double? xirr;
//   int? totalTerm;
//   String? termCategory;
//   String? status;
//   DateTime? startDate;
//   int? remainingTerm;
//   int? remainingAmount;
//   String? name;
//   String? contractId;
//   int? amount;
//
//   factory TenureDatum.fromJson(Map<String, dynamic> json) => TenureDatum(
//         xirr: json["XIRR"].toDouble(),
//         totalTerm: json["totalTerm"] == null ? null : json["totalTerm"],
//         termCategory: json["termCategory"],
//         status: json["status"],
//         startDate: DateTime.parse(json["startDate"]),
//         remainingTerm:
//             json["remainingTerm"] == null ? null : json["remainingTerm"],
//         remainingAmount:
//             json["remainingAmount"] == null ? null : json["remainingAmount"],
//         name: json["name"],
//         contractId: json["contractId"],
//         amount: json["amount"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "XIRR": xirr,
//         "totalTerm": totalTerm == null ? null : totalTerm,
//         "termCategory": termCategory,
//         "status": status,
//         "startDate":
//             "${startDate?.year.toString().padLeft(4, '0')}-${startDate?.month.toString().padLeft(2, '0')}-${startDate?.day.toString().padLeft(2, '0')}",
//         "remainingTerm": remainingTerm == null ? null : remainingTerm,
//         "remainingAmount": remainingAmount == null ? null : remainingAmount,
//         "name": name,
//         "contractId": contractId,
//         "amount": amount,
//       };
// }
//
// class Risk {
//   Risk({
//     this.medium,
//     this.high,
//     this.conservative,
//   });
//
//   Conservative? medium;
//   Conservative? high;
//   Conservative? conservative;
//
//   factory Risk.fromJson(Map<String, dynamic> json) => Risk(
//         medium: Conservative.fromJson(json["medium"]),
//         high: Conservative.fromJson(json["high"]),
//         conservative: Conservative.fromJson(json["conservative"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "medium": medium?.toJson(),
//         "high": high?.toJson(),
//         "conservative": conservative?.toJson(),
//       };
// }
//
// class Conservative {
//   Conservative({
//     this.investOrderList,
//   });
//
//   List<InvestOrderList>? investOrderList;
//
//   factory Conservative.fromJson(Map<String, dynamic> json) => Conservative(
//         investOrderList: List<InvestOrderList>.from(
//             json["investOrderList"].map((x) => InvestOrderList.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "investOrderList":
//             List<dynamic>.from(investOrderList.map((x) => x.toJson())),
//       };
// }
//
// class InvestOrderList {
//   InvestOrderList({
//     this.attributes,
//     this.peerCreditBandAllocationC,
//     this.id,
//     this.name,
//     this.loanInvestorStartDateC,
//     this.loanInvestmentAmountC,
//     this.borrowerNameC,
//     this.loanRemainingInvestmentAmountC,
//     this.loanLoanC,
//     this.loanStatusC,
//     this.loanCertificateRateC,
//     this.loanLoanR,
//   });
//
//   Attributes? attributes;
//   String? peerCreditBandAllocationC;
//   String? id;
//   String? name;
//   DateTime? loanInvestorStartDateC;
//   int? loanInvestmentAmountC;
//   String? borrowerNameC;
//   int? loanRemainingInvestmentAmountC;
//   String? loanLoanC;
//   String? loanStatusC;
//   double? loanCertificateRateC;
//   LoanLoanR? loanLoanR;
//
//   factory InvestOrderList.fromJson(Map<String, dynamic> json) =>
//       InvestOrderList(
//         attributes: Attributes.fromJson(json["attributes"]),
//         peerCreditBandAllocationC: json["peer__Credit_Band_Allocation__c"],
//         id: json["Id"],
//         name: json["Name"],
//         loanInvestorStartDateC:
//             DateTime.parse(json["loan__Investor_Start_Date__c"]),
//         loanInvestmentAmountC: json["loan__Investment_Amount__c"],
//         borrowerNameC: json["Borrower_Name__c"],
//         loanRemainingInvestmentAmountC:
//             json["loan__Remaining_Investment_Amount__c"],
//         loanLoanC: json["loan__Loan__c"],
//         loanStatusC: json["loan__Status__c"],
//         loanCertificateRateC: json["loan__Certificate_Rate__c"].toDouble(),
//         loanLoanR: LoanLoanR.fromJson(json["loan__Loan__r"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "attributes": attributes?.toJson(),
//         "peer__Credit_Band_Allocation__c": peerCreditBandAllocationC,
//         "Id": id,
//         "Name": name,
//         "loan__Investor_Start_Date__c":
//             "${loanInvestorStartDateC?.year.toString().padLeft(4, '0')}-${loanInvestorStartDateC?.month.toString().padLeft(2, '0')}-${loanInvestorStartDateC?.day.toString().padLeft(2, '0')}",
//         "loan__Investment_Amount__c": loanInvestmentAmountC,
//         "Borrower_Name__c": borrowerNameC,
//         "loan__Remaining_Investment_Amount__c": loanRemainingInvestmentAmountC,
//         "loan__Loan__c": loanLoanC,
//         "loan__Status__c": loanStatusC,
//         "loan__Certificate_Rate__c": loanCertificateRateC,
//         "loan__Loan__r": loanLoanR?.toJson(),
//       };
// }
//
// class Attributes {
//   Attributes({
//     this.type,
//     this.url,
//   });
//
//   String? type;
//   String? url;
//
//   factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
//         type: json["type"],
//         url: json["url"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "type": type,
//         "url": url,
//       };
// }
//
// class LoanLoanR {
//   LoanLoanR({
//     this.attributes,
//     this.id,
//     this.loanNumberOfInstallmentsC,
//     this.loanNumberOfDaysOverdueC,
//     this.slXirrC,
//     this.remainingEmiC,
//   });
//
//   Attributes? attributes;
//   String? id;
//   int? loanNumberOfInstallmentsC;
//   int? loanNumberOfDaysOverdueC;
//   double? slXirrC;
//   int? remainingEmiC;
//
//   factory LoanLoanR.fromJson(Map<String, dynamic> json) => LoanLoanR(
//         attributes: Attributes.fromJson(json["attributes"]),
//         id: json["Id"],
//         loanNumberOfInstallmentsC: json["loan__Number_of_Installments__c"],
//         loanNumberOfDaysOverdueC: json["loan__Number_of_Days_Overdue__c"],
//         slXirrC: json["SL_XIRR__c"].toDouble(),
//         remainingEmiC: json["Remaining_EMI__c"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "attributes": attributes?.toJson(),
//         "Id": id,
//         "loan__Number_of_Installments__c": loanNumberOfInstallmentsC,
//         "loan__Number_of_Days_Overdue__c": loanNumberOfDaysOverdueC,
//         "SL_XIRR__c": slXirrC,
//         "Remaining_EMI__c": remainingEmiC,
//       };
// }
