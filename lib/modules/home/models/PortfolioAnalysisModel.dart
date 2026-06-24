/// data : {"statusCode":200,"risk_No_of_Loans":{"Total":187,"Medium":72,"High":33,"conservative":82},"risk_Amount":{"unInvestedAmount":111587,"Total":228913,"Medium":78715,"High":30339,"conservative":119858},"message":"Success. CID found","interest_Earned":{"interest_Earned_6":{"unInvestedAmount":9916.5,"total_Investement":5000.0,"Statement_Month":"Nov 2021","percent_interest_Earned":11.88},"interest_Earned_5":{"unInvestedAmount":10988.44,"total_Investement":6000.0,"Statement_Month":"Dec 2021","percent_interest_Earned":10.75},"interest_Earned_4":{"unInvestedAmount":7988.11,"total_Investement":7000.0,"Statement_Month":"Jan 2023","percent_interest_Earned":10.33},"interest_Earned_3":{"unInvestedAmount":8674.43,"total_Investement":7000.0,"Statement_Month":"Feb 2022","percent_interest_Earned":12.65},"interest_Earned_2":{"unInvestedAmount":111587.36,"total_Investement":0.0,"Statement_Month":"Sep 2022","percent_interest_Earned":0.0},"interest_Earned_1":{"unInvestedAmount":111587.36,"total_Investement":0.0,"Statement_Month":"Oct 2022","percent_interest_Earned":0.0}}}
/// sfLogs : null

class PortfolioAnalysisModel {
  PortfolioAnalysisModel({
    PortfolioAnalysisData? data,
    dynamic sfLogs,
  }) {
    _data = data;
    _sfLogs = sfLogs;
  }

  PortfolioAnalysisModel.fromJson(dynamic json) {
    _data = json['data'] != null
        ? PortfolioAnalysisData.fromJson(json['data'])
        : null;
    _sfLogs = json['sfLogs'];
  }
  PortfolioAnalysisData? _data;
  dynamic _sfLogs;
  PortfolioAnalysisModel copyWith({
    PortfolioAnalysisData? data,
    dynamic sfLogs,
  }) =>
      PortfolioAnalysisModel(
        data: data ?? _data,
        sfLogs: sfLogs ?? _sfLogs,
      );
  PortfolioAnalysisData? get data => _data;
  dynamic get sfLogs => _sfLogs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['sfLogs'] = _sfLogs;
    return map;
  }
}

/// statusCode : 200
/// risk_No_of_Loans : {"Total":187,"Medium":72,"High":33,"conservative":82}
/// risk_Amount : {"unInvestedAmount":111587,"Total":228913,"Medium":78715,"High":30339,"conservative":119858}
/// message : "Success. CID found"
/// interest_Earned : {"interest_Earned_6":{"unInvestedAmount":9916.5,"total_Investement":5000.0,"Statement_Month":"Nov 2021","percent_interest_Earned":11.88},"interest_Earned_5":{"unInvestedAmount":10988.44,"total_Investement":6000.0,"Statement_Month":"Dec 2021","percent_interest_Earned":10.75},"interest_Earned_4":{"unInvestedAmount":7988.11,"total_Investement":7000.0,"Statement_Month":"Jan 2023","percent_interest_Earned":10.33},"interest_Earned_3":{"unInvestedAmount":8674.43,"total_Investement":7000.0,"Statement_Month":"Feb 2022","percent_interest_Earned":12.65},"interest_Earned_2":{"unInvestedAmount":111587.36,"total_Investement":0.0,"Statement_Month":"Sep 2022","percent_interest_Earned":0.0},"interest_Earned_1":{"unInvestedAmount":111587.36,"total_Investement":0.0,"Statement_Month":"Oct 2022","percent_interest_Earned":0.0}}

class PortfolioAnalysisData {
  PortfolioAnalysisData({
    int? statusCode,
    RiskNoOfLoans? riskNoOfLoans,
    RiskAmount? riskAmount,
    String? message,
    InterestEarned? interestEarned,
    LoanTenureNoOfLoans? loanTenureNoOfLoans,
    LoanTenureAmount? loanTenureAmount,
    LoanTenureNoOfLoansRemaining? loanTenureNoOfLoansRemaining,
    LoanTenureAmountRemaining? loanTenureAmountRemaining,
    InterestNoOfLoan? interestNoOfLoan,
    InterestAmount? interestAmount,
    DeliquencyCount? deliquencyCount,
    DeliquencyAmount? deliquencyAmount,
  }) {
    _statusCode = statusCode;
    _riskNoOfLoans = riskNoOfLoans;
    _riskAmount = riskAmount;
    _message = message;
    _interestEarned = interestEarned;
    _loanTenureNoOfLoans = loanTenureNoOfLoans;
    _loanTenureAmount = loanTenureAmount;
    _loanTenureNoOfLoansRemaining = loanTenureNoOfLoansRemaining;
    _loanTenureAmountRemaining = loanTenureAmountRemaining;
    _interestNoOfLoan = interestNoOfLoan;
    _interestAmount = interestAmount;
    _deliquencyCount = deliquencyCount;
    _deliquencyAmount = deliquencyAmount;
  }

  PortfolioAnalysisData.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _riskNoOfLoans = json['risk_No_of_Loans'] != null
        ? RiskNoOfLoans.fromJson(json['risk_No_of_Loans'])
        : null;
    _riskAmount = json['risk_Amount'] != null
        ? RiskAmount.fromJson(json['risk_Amount'])
        : null;
    _message = json['message'];
    _interestEarned = json['interest_Earned'] != null
        ? InterestEarned.fromJson(json['interest_Earned'])
        : null;
    _loanTenureNoOfLoans = json['loanTenure_No_of_Loans'] != null
        ? LoanTenureNoOfLoans.fromJson(json['loanTenure_No_of_Loans'])
        : null;
    _loanTenureAmount = json['loanTenure_Amount'] != null
        ? LoanTenureAmount.fromJson(json['loanTenure_Amount'])
        : null;
    _loanTenureNoOfLoansRemaining =
        json['loanTenure_No_of_Loans_remaining'] != null
            ? LoanTenureNoOfLoansRemaining.fromJson(
                json['loanTenure_No_of_Loans_remaining'])
            : null;
    _loanTenureAmountRemaining = json['loanTenure_Amount_remaining'] != null
        ? LoanTenureAmountRemaining.fromJson(
            json['loanTenure_Amount_remaining'])
        : null;
    _interestNoOfLoan = json['interst_No_of_Loans'] != null
        ? InterestNoOfLoan.fromJson(json['interst_No_of_Loans'])
        : null;
    _interestAmount = json['interst_Amount'] != null
        ? InterestAmount.fromJson(json['interst_Amount'])
        : null;
    _deliquencyCount = json['deliquency_Count'] != null
        ? DeliquencyCount.fromJson(json['deliquency_Count'])
        : null;
    _deliquencyAmount = json['deliquency_Amount'] != null
        ? DeliquencyAmount.fromJson(json['deliquency_Amount'])
        : null;
  }
  int? _statusCode;
  RiskNoOfLoans? _riskNoOfLoans;
  RiskAmount? _riskAmount;
  String? _message;
  InterestEarned? _interestEarned;
  LoanTenureNoOfLoans? _loanTenureNoOfLoans;
  LoanTenureAmount? _loanTenureAmount;
  LoanTenureNoOfLoansRemaining? _loanTenureNoOfLoansRemaining;
  LoanTenureAmountRemaining? _loanTenureAmountRemaining;
  InterestNoOfLoan? _interestNoOfLoan;
  InterestAmount? _interestAmount;
  DeliquencyCount? _deliquencyCount;
  DeliquencyAmount? _deliquencyAmount;
  PortfolioAnalysisData copyWith({
    int? statusCode,
    RiskNoOfLoans? riskNoOfLoans,
    RiskAmount? riskAmount,
    String? message,
    InterestEarned? interestEarned,
    LoanTenureNoOfLoans? loanTenureNoOfLoans,
    LoanTenureAmount? loanTenureAmount,
    LoanTenureNoOfLoansRemaining? loanTenureNoOfLoansRemaining,
    LoanTenureAmountRemaining? loanTenureAmountRemaining,
    InterestNoOfLoan? interestNoOfLoan,
    InterestAmount? interestAmount,
    DeliquencyCount? deliquencyCount,
    DeliquencyAmount? deliquencyAmount,
  }) =>
      PortfolioAnalysisData(
        statusCode: statusCode ?? _statusCode,
        riskNoOfLoans: riskNoOfLoans ?? _riskNoOfLoans,
        riskAmount: riskAmount ?? _riskAmount,
        message: message ?? _message,
        interestEarned: interestEarned ?? _interestEarned,
        loanTenureNoOfLoans: loanTenureNoOfLoans ?? _loanTenureNoOfLoans,
        loanTenureAmount: loanTenureAmount ?? _loanTenureAmount,
        loanTenureNoOfLoansRemaining:
            loanTenureNoOfLoansRemaining ?? _loanTenureNoOfLoansRemaining,
        loanTenureAmountRemaining:
            loanTenureAmountRemaining ?? _loanTenureAmountRemaining,
        interestNoOfLoan: interestNoOfLoan ?? _interestNoOfLoan,
        interestAmount: interestAmount ?? _interestAmount,
        deliquencyCount: deliquencyCount ?? _deliquencyCount,
        deliquencyAmount: deliquencyAmount ?? _deliquencyAmount,
      );
  int? get statusCode => _statusCode;
  RiskNoOfLoans? get riskNoOfLoans => _riskNoOfLoans;
  RiskAmount? get riskAmount => _riskAmount;
  String? get message => _message;
  InterestEarned? get interestEarned => _interestEarned;
  LoanTenureNoOfLoans? get loanTenureNoOfLoans => _loanTenureNoOfLoans;
  LoanTenureAmount? get loanTenureAmount => _loanTenureAmount;
  LoanTenureNoOfLoansRemaining? get loanTenureNoOfLoansRemaining =>
      _loanTenureNoOfLoansRemaining;
  LoanTenureAmountRemaining? get loanTenureAmountRemaining =>
      _loanTenureAmountRemaining;
  InterestNoOfLoan? get interestNoOfLoan => _interestNoOfLoan;
  InterestAmount? get interestAmount => _interestAmount;
  DeliquencyCount? get deliquencyCount => _deliquencyCount;
  DeliquencyAmount? get deliquencyAmount => _deliquencyAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_riskNoOfLoans != null) {
      map['risk_No_of_Loans'] = _riskNoOfLoans?.toJson();
    }
    if (_riskAmount != null) {
      map['risk_Amount'] = _riskAmount?.toJson();
    }
    map['message'] = _message;
    if (_interestEarned != null) {
      map['interest_Earned'] = _interestEarned?.toJson();
    }
    if (_loanTenureNoOfLoans != null) {
      map['loanTenure_No_of_Loans'] = _loanTenureNoOfLoans?.toJson();
    }
    if (_loanTenureAmount != null) {
      map['loanTenure_Amount'] = _loanTenureAmount?.toJson();
    }
    if (_loanTenureNoOfLoansRemaining != null) {
      map['loanTenure_No_of_Loans_remaining'] =
          _loanTenureNoOfLoansRemaining?.toJson();
    }
    if (_loanTenureAmountRemaining != null) {
      map['loanTenure_Amount_remaining'] = _loanTenureAmountRemaining?.toJson();
    }
    if (_interestNoOfLoan != null) {
      map['interst_No_of_Loans'] = _interestNoOfLoan?.toJson();
    }
    if (_interestAmount != null) {
      map['interst_Amount'] = _interestAmount?.toJson();
    }
    if (_deliquencyCount != null) {
      map['deliquency_Count'] = _deliquencyCount?.toJson();
    }
    if (_deliquencyAmount != null) {
      map['deliquency_Amount'] = _deliquencyAmount?.toJson();
    }
    return map;
  }
}

/// interest_Earned_6 : {"unInvestedAmount":9916.5,"total_Investement":5000.0,"Statement_Month":"Nov 2021","percent_interest_Earned":11.88}
/// interest_Earned_5 : {"unInvestedAmount":10988.44,"total_Investement":6000.0,"Statement_Month":"Dec 2021","percent_interest_Earned":10.75}
/// interest_Earned_4 : {"unInvestedAmount":7988.11,"total_Investement":7000.0,"Statement_Month":"Jan 2023","percent_interest_Earned":10.33}
/// interest_Earned_3 : {"unInvestedAmount":8674.43,"total_Investement":7000.0,"Statement_Month":"Feb 2022","percent_interest_Earned":12.65}
/// interest_Earned_2 : {"unInvestedAmount":111587.36,"total_Investement":0.0,"Statement_Month":"Sep 2022","percent_interest_Earned":0.0}
/// interest_Earned_1 : {"unInvestedAmount":111587.36,"total_Investement":0.0,"Statement_Month":"Oct 2022","percent_interest_Earned":0.0}

class InterestEarned {
  InterestEarned({
    InterestEarned6? interestEarned6,
    InterestEarned5? interestEarned5,
    InterestEarned4? interestEarned4,
    InterestEarned3? interestEarned3,
    InterestEarned2? interestEarned2,
    InterestEarned1? interestEarned1,
  }) {
    _interestEarned6 = interestEarned6;
    _interestEarned5 = interestEarned5;
    _interestEarned4 = interestEarned4;
    _interestEarned3 = interestEarned3;
    _interestEarned2 = interestEarned2;
    _interestEarned1 = interestEarned1;
  }

  InterestEarned.fromJson(dynamic json) {
    _interestEarned6 = json['interest_Earned_6'] != null
        ? InterestEarned6.fromJson(json['interest_Earned_6'])
        : null;
    _interestEarned5 = json['interest_Earned_5'] != null
        ? InterestEarned5.fromJson(json['interest_Earned_5'])
        : null;
    _interestEarned4 = json['interest_Earned_4'] != null
        ? InterestEarned4.fromJson(json['interest_Earned_4'])
        : null;
    _interestEarned3 = json['interest_Earned_3'] != null
        ? InterestEarned3.fromJson(json['interest_Earned_3'])
        : null;
    _interestEarned2 = json['interest_Earned_2'] != null
        ? InterestEarned2.fromJson(json['interest_Earned_2'])
        : null;
    _interestEarned1 = json['interest_Earned_1'] != null
        ? InterestEarned1.fromJson(json['interest_Earned_1'])
        : null;
  }
  InterestEarned6? _interestEarned6;
  InterestEarned5? _interestEarned5;
  InterestEarned4? _interestEarned4;
  InterestEarned3? _interestEarned3;
  InterestEarned2? _interestEarned2;
  InterestEarned1? _interestEarned1;
  InterestEarned copyWith({
    InterestEarned6? interestEarned6,
    InterestEarned5? interestEarned5,
    InterestEarned4? interestEarned4,
    InterestEarned3? interestEarned3,
    InterestEarned2? interestEarned2,
    InterestEarned1? interestEarned1,
  }) =>
      InterestEarned(
        interestEarned6: interestEarned6 ?? _interestEarned6,
        interestEarned5: interestEarned5 ?? _interestEarned5,
        interestEarned4: interestEarned4 ?? _interestEarned4,
        interestEarned3: interestEarned3 ?? _interestEarned3,
        interestEarned2: interestEarned2 ?? _interestEarned2,
        interestEarned1: interestEarned1 ?? _interestEarned1,
      );
  InterestEarned6? get interestEarned6 => _interestEarned6;
  InterestEarned5? get interestEarned5 => _interestEarned5;
  InterestEarned4? get interestEarned4 => _interestEarned4;
  InterestEarned3? get interestEarned3 => _interestEarned3;
  InterestEarned2? get interestEarned2 => _interestEarned2;
  InterestEarned1? get interestEarned1 => _interestEarned1;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_interestEarned6 != null) {
      map['interest_Earned_6'] = _interestEarned6?.toJson();
    }
    if (_interestEarned5 != null) {
      map['interest_Earned_5'] = _interestEarned5?.toJson();
    }
    if (_interestEarned4 != null) {
      map['interest_Earned_4'] = _interestEarned4?.toJson();
    }
    if (_interestEarned3 != null) {
      map['interest_Earned_3'] = _interestEarned3?.toJson();
    }
    if (_interestEarned2 != null) {
      map['interest_Earned_2'] = _interestEarned2?.toJson();
    }
    if (_interestEarned1 != null) {
      map['interest_Earned_1'] = _interestEarned1?.toJson();
    }
    return map;
  }
}

/// unInvestedAmount : 111587.36
/// total_Investement : 0.0
/// Statement_Month : "Oct 2022"
/// percent_interest_Earned : 0.0

class InterestEarned1 {
  InterestEarned1({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) {
    _unInvestedAmount = unInvestedAmount;
    _totalInvestement = totalInvestement;
    _statementMonth = statementMonth;
    _percentInterestEarned = percentInterestEarned;
  }

  InterestEarned1.fromJson(dynamic json) {
    _unInvestedAmount = json['unInvestedAmount'];
    _totalInvestement = json['total_Investement'];
    _statementMonth = json['Statement_Month'];
    _percentInterestEarned = json['percent_interest_Earned'];
  }
  double? _unInvestedAmount;
  double? _totalInvestement;
  String? _statementMonth;
  double? _percentInterestEarned;
  InterestEarned1 copyWith({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) =>
      InterestEarned1(
        unInvestedAmount: unInvestedAmount ?? _unInvestedAmount,
        totalInvestement: totalInvestement ?? _totalInvestement,
        statementMonth: statementMonth ?? _statementMonth,
        percentInterestEarned: percentInterestEarned ?? _percentInterestEarned,
      );
  double? get unInvestedAmount => _unInvestedAmount;
  double? get totalInvestement => _totalInvestement;
  String? get statementMonth => _statementMonth;
  double? get percentInterestEarned => _percentInterestEarned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unInvestedAmount'] = _unInvestedAmount;
    map['total_Investement'] = _totalInvestement;
    map['Statement_Month'] = _statementMonth;
    map['percent_interest_Earned'] = _percentInterestEarned;
    return map;
  }
}

/// unInvestedAmount : 111587.36
/// total_Investement : 0.0
/// Statement_Month : "Sep 2022"
/// percent_interest_Earned : 0.0

class InterestEarned2 {
  InterestEarned2({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) {
    _unInvestedAmount = unInvestedAmount;
    _totalInvestement = totalInvestement;
    _statementMonth = statementMonth;
    _percentInterestEarned = percentInterestEarned;
  }

  InterestEarned2.fromJson(dynamic json) {
    _unInvestedAmount = json['unInvestedAmount'];
    _totalInvestement = json['total_Investement'];
    _statementMonth = json['Statement_Month'];
    _percentInterestEarned = json['percent_interest_Earned'];
  }
  double? _unInvestedAmount;
  double? _totalInvestement;
  String? _statementMonth;
  double? _percentInterestEarned;
  InterestEarned2 copyWith({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) =>
      InterestEarned2(
        unInvestedAmount: unInvestedAmount ?? _unInvestedAmount,
        totalInvestement: totalInvestement ?? _totalInvestement,
        statementMonth: statementMonth ?? _statementMonth,
        percentInterestEarned: percentInterestEarned ?? _percentInterestEarned,
      );
  double? get unInvestedAmount => _unInvestedAmount;
  double? get totalInvestement => _totalInvestement;
  String? get statementMonth => _statementMonth;
  double? get percentInterestEarned => _percentInterestEarned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unInvestedAmount'] = _unInvestedAmount;
    map['total_Investement'] = _totalInvestement;
    map['Statement_Month'] = _statementMonth;
    map['percent_interest_Earned'] = _percentInterestEarned;
    return map;
  }
}

/// unInvestedAmount : 8674.43
/// total_Investement : 7000.0
/// Statement_Month : "Feb 2022"
/// percent_interest_Earned : 12.65

class InterestEarned3 {
  InterestEarned3({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) {
    _unInvestedAmount = unInvestedAmount;
    _totalInvestement = totalInvestement;
    _statementMonth = statementMonth;
    _percentInterestEarned = percentInterestEarned;
  }

  InterestEarned3.fromJson(dynamic json) {
    _unInvestedAmount = json['unInvestedAmount'];
    _totalInvestement = json['total_Investement'];
    _statementMonth = json['Statement_Month'];
    _percentInterestEarned = json['percent_interest_Earned'];
  }
  double? _unInvestedAmount;
  double? _totalInvestement;
  String? _statementMonth;
  double? _percentInterestEarned;
  InterestEarned3 copyWith({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) =>
      InterestEarned3(
        unInvestedAmount: unInvestedAmount ?? _unInvestedAmount,
        totalInvestement: totalInvestement ?? _totalInvestement,
        statementMonth: statementMonth ?? _statementMonth,
        percentInterestEarned: percentInterestEarned ?? _percentInterestEarned,
      );
  double? get unInvestedAmount => _unInvestedAmount;
  double? get totalInvestement => _totalInvestement;
  String? get statementMonth => _statementMonth;
  double? get percentInterestEarned => _percentInterestEarned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unInvestedAmount'] = _unInvestedAmount;
    map['total_Investement'] = _totalInvestement;
    map['Statement_Month'] = _statementMonth;
    map['percent_interest_Earned'] = _percentInterestEarned;
    return map;
  }
}

/// unInvestedAmount : 7988.11
/// total_Investement : 7000.0
/// Statement_Month : "Jan 2023"
/// percent_interest_Earned : 10.33

class InterestEarned4 {
  InterestEarned4({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) {
    _unInvestedAmount = unInvestedAmount;
    _totalInvestement = totalInvestement;
    _statementMonth = statementMonth;
    _percentInterestEarned = percentInterestEarned;
  }

  InterestEarned4.fromJson(dynamic json) {
    _unInvestedAmount = json['unInvestedAmount'];
    _totalInvestement = json['total_Investement'];
    _statementMonth = json['Statement_Month'];
    _percentInterestEarned = json['percent_interest_Earned'];
  }
  double? _unInvestedAmount;
  double? _totalInvestement;
  String? _statementMonth;
  double? _percentInterestEarned;
  InterestEarned4 copyWith({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) =>
      InterestEarned4(
        unInvestedAmount: unInvestedAmount ?? _unInvestedAmount,
        totalInvestement: totalInvestement ?? _totalInvestement,
        statementMonth: statementMonth ?? _statementMonth,
        percentInterestEarned: percentInterestEarned ?? _percentInterestEarned,
      );
  double? get unInvestedAmount => _unInvestedAmount;
  double? get totalInvestement => _totalInvestement;
  String? get statementMonth => _statementMonth;
  double? get percentInterestEarned => _percentInterestEarned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unInvestedAmount'] = _unInvestedAmount;
    map['total_Investement'] = _totalInvestement;
    map['Statement_Month'] = _statementMonth;
    map['percent_interest_Earned'] = _percentInterestEarned;
    return map;
  }
}

/// unInvestedAmount : 10988.44
/// total_Investement : 6000.0
/// Statement_Month : "Dec 2021"
/// percent_interest_Earned : 10.75

class InterestEarned5 {
  InterestEarned5({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) {
    _unInvestedAmount = unInvestedAmount;
    _totalInvestement = totalInvestement;
    _statementMonth = statementMonth;
    _percentInterestEarned = percentInterestEarned;
  }

  InterestEarned5.fromJson(dynamic json) {
    _unInvestedAmount = json['unInvestedAmount'];
    _totalInvestement = json['total_Investement'];
    _statementMonth = json['Statement_Month'];
    _percentInterestEarned = json['percent_interest_Earned'];
  }
  double? _unInvestedAmount;
  double? _totalInvestement;
  String? _statementMonth;
  double? _percentInterestEarned;
  InterestEarned5 copyWith({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) =>
      InterestEarned5(
        unInvestedAmount: unInvestedAmount ?? _unInvestedAmount,
        totalInvestement: totalInvestement ?? _totalInvestement,
        statementMonth: statementMonth ?? _statementMonth,
        percentInterestEarned: percentInterestEarned ?? _percentInterestEarned,
      );
  double? get unInvestedAmount => _unInvestedAmount;
  double? get totalInvestement => _totalInvestement;
  String? get statementMonth => _statementMonth;
  double? get percentInterestEarned => _percentInterestEarned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unInvestedAmount'] = _unInvestedAmount;
    map['total_Investement'] = _totalInvestement;
    map['Statement_Month'] = _statementMonth;
    map['percent_interest_Earned'] = _percentInterestEarned;
    return map;
  }
}

/// unInvestedAmount : 9916.5
/// total_Investement : 5000.0
/// Statement_Month : "Nov 2021"
/// percent_interest_Earned : 11.88

class InterestEarned6 {
  InterestEarned6({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) {
    _unInvestedAmount = unInvestedAmount;
    _totalInvestement = totalInvestement;
    _statementMonth = statementMonth;
    _percentInterestEarned = percentInterestEarned;
  }

  InterestEarned6.fromJson(dynamic json) {
    _unInvestedAmount = json['unInvestedAmount'];
    _totalInvestement = json['total_Investement'];
    _statementMonth = json['Statement_Month'];
    _percentInterestEarned = json['percent_interest_Earned'];
  }
  double? _unInvestedAmount;
  double? _totalInvestement;
  String? _statementMonth;
  double? _percentInterestEarned;
  InterestEarned6 copyWith({
    double? unInvestedAmount,
    double? totalInvestement,
    String? statementMonth,
    double? percentInterestEarned,
  }) =>
      InterestEarned6(
        unInvestedAmount: unInvestedAmount ?? _unInvestedAmount,
        totalInvestement: totalInvestement ?? _totalInvestement,
        statementMonth: statementMonth ?? _statementMonth,
        percentInterestEarned: percentInterestEarned ?? _percentInterestEarned,
      );
  double? get unInvestedAmount => _unInvestedAmount;
  double? get totalInvestement => _totalInvestement;
  String? get statementMonth => _statementMonth;
  double? get percentInterestEarned => _percentInterestEarned;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unInvestedAmount'] = _unInvestedAmount;
    map['total_Investement'] = _totalInvestement;
    map['Statement_Month'] = _statementMonth;
    map['percent_interest_Earned'] = _percentInterestEarned;
    return map;
  }
}

/// unInvestedAmount : 111587
/// Total : 228913
/// Medium : 78715
/// High : 30339
/// conservative : 119858

class RiskAmount {
  RiskAmount({
    int? unInvestedAmount,
    int? total,
    int? medium,
    int? high,
    int? conservative,
    int? closedLoanAmount,
  }) {
    _unInvestedAmount = unInvestedAmount;
    _total = total;
    _medium = medium;
    _high = high;
    _conservative = conservative;
    _closedLoanAmount = closedLoanAmount;
  }

  RiskAmount.fromJson(dynamic json) {
    _unInvestedAmount = json['unInvestedAmount'];
    _total = json['Total'];
    _medium = json['Medium'];
    _high = json['High'];
    _conservative = json['conservative'];
    _closedLoanAmount = json['ClosedLoanAmount'];
  }
  int? _unInvestedAmount;
  int? _total;
  int? _medium;
  int? _high;
  int? _conservative;
  int? _closedLoanAmount;
  RiskAmount copyWith({
    int? unInvestedAmount,
    int? total,
    int? medium,
    int? high,
    int? conservative,
    int? closedLoanAmount,
  }) =>
      RiskAmount(
        unInvestedAmount: unInvestedAmount ?? _unInvestedAmount,
        total: total ?? _total,
        medium: medium ?? _medium,
        high: high ?? _high,
        conservative: conservative ?? _conservative,
        closedLoanAmount: closedLoanAmount ?? _closedLoanAmount,
      );
  int? get unInvestedAmount => _unInvestedAmount;
  int? get total => _total;
  int? get medium => _medium;
  int? get high => _high;
  int? get conservative => _conservative;
  int? get closedLoanAmount => _closedLoanAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unInvestedAmount'] = _unInvestedAmount;
    map['Total'] = _total;
    map['Medium'] = _medium;
    map['High'] = _high;
    map['conservative'] = _conservative;
    map['ClosedLoanAmount'] = _closedLoanAmount;
    return map;
  }
}

/// Total : 187
/// Medium : 72
/// High : 33
/// conservative : 82

class RiskNoOfLoans {
  RiskNoOfLoans({
    int? total,
    int? medium,
    int? high,
    int? conservative,
    int? closedLoans,
  }) {
    _total = total;
    _medium = medium;
    _high = high;
    _conservative = conservative;
    _closedLoans = closedLoans;
  }

  RiskNoOfLoans.fromJson(dynamic json) {
    _total = json['Total'];
    _medium = json['Medium'];
    _high = json['High'];
    _conservative = json['conservative'];
    _closedLoans = json["closedLoans"];
  }
  int? _total;
  int? _medium;
  int? _high;
  int? _conservative;
  int? _closedLoans;
  RiskNoOfLoans copyWith({
    int? total,
    int? medium,
    int? high,
    int? conservative,
    int? closedLoans,
  }) =>
      RiskNoOfLoans(
        total: total ?? _total,
        medium: medium ?? _medium,
        high: high ?? _high,
        conservative: conservative ?? _conservative,
        closedLoans: closedLoans ?? _closedLoans,
      );
  int? get total => _total;
  int? get medium => _medium;
  int? get high => _high;
  int? get conservative => _conservative;
  int? get closedLoans => _closedLoans;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Total'] = _total;
    map['Medium'] = _medium;
    map['High'] = _high;
    map['conservative'] = _conservative;
    map['closedLoans'] = _closedLoans;
    return map;
  }
}

class LoanTenureNoOfLoans {
  LoanTenureNoOfLoans({
    int? less_3M,
    int? total,
    int? bwt_6M_12M,
    int? bwt_3M_6M,
    int? bwt_12M_24M,
    int? above_24M,
    int? closed,
  }) {
    _total = total;
    _less_3M = less_3M;
    _bwt_6M_12M = bwt_6M_12M;
    _bwt_3M_6M = bwt_3M_6M;
    _bwt_12M_24M = bwt_12M_24M;
    _above_24M = above_24M;
    _closed = closed;
  }

  LoanTenureNoOfLoans.fromJson(dynamic json) {
    _total = json['total'];
    _less_3M = json['less_3M'];
    _bwt_6M_12M = json['bwt_6M_12M'];
    _bwt_3M_6M = json['bwt_3M_6M'];
    _bwt_12M_24M = json['bwt_12M_24M'];
    _above_24M = json["above_24M"];
    _closed = json["closed"];
  }
  int? _total;
  int? _less_3M;
  int? _bwt_6M_12M;
  int? _bwt_3M_6M;
  int? _bwt_12M_24M;
  int? _above_24M;
  int? _closed;
  LoanTenureNoOfLoans copyWith({
    int? total,
    int? less_3M,
    int? bwt_6M_12M,
    int? bwt_3M_6M,
    int? bwt_12M_24M,
    int? above_24M,
    int? closed,
  }) =>
      LoanTenureNoOfLoans(
        total: total ?? _total,
        less_3M: less_3M ?? _less_3M,
        bwt_6M_12M: bwt_6M_12M ?? _bwt_6M_12M,
        bwt_3M_6M: bwt_3M_6M ?? _bwt_3M_6M,
        bwt_12M_24M: bwt_12M_24M ?? _bwt_12M_24M,
        above_24M: above_24M ?? _above_24M,
        closed: closed ?? _closed,
      );
  int? get total => _total;
  int? get less_3M => _less_3M;
  int? get bwt_6M_12M => _bwt_6M_12M;
  int? get bwt_3M_6M => _bwt_3M_6M;
  int? get bwt_12M_24M => _bwt_12M_24M;
  int? get above_24M => _above_24M;
  int? get closed => _closed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['less_3M'] = _less_3M;
    map['bwt_6M_12M'] = _bwt_6M_12M;
    map['bwt_3M_6M'] = _bwt_3M_6M;
    map['bwt_12M_24M'] = _bwt_12M_24M;
    map['above_24M'] = _above_24M;
    map['closed'] = _closed;
    return map;
  }
}

class LoanTenureAmount {
  LoanTenureAmount({
    int? total,
    int? less_3M,
    int? bwt_6M_12M,
    int? bwt_3M_6M,
    int? bwt_12M_24M,
    int? above_24M,
    int? closed,
  }) {
    _total = total;
    _less_3M = less_3M;
    _bwt_6M_12M = bwt_6M_12M;
    _bwt_3M_6M = bwt_3M_6M;
    _bwt_12M_24M = bwt_12M_24M;
    _above_24M = above_24M;
    _closed = closed;
  }

  LoanTenureAmount.fromJson(dynamic json) {
    _total = json['total'];
    _less_3M = json['less_3M'];
    _bwt_6M_12M = json['bwt_6M_12M'];
    _bwt_3M_6M = json['bwt_3M_6M'];
    _bwt_12M_24M = json['bwt_12M_24M'];
    _above_24M = json["above_24M"];
    _closed = json["closed"];
  }
  int? _total;
  int? _less_3M;
  int? _bwt_6M_12M;
  int? _bwt_3M_6M;
  int? _bwt_12M_24M;
  int? _above_24M;
  int? _closed;
  LoanTenureAmount copyWith({
    int? total,
    int? less_3M,
    int? bwt_6M_12M,
    int? bwt_3M_6M,
    int? bwt_12M_24M,
    int? above_24M,
    int? closed,
  }) =>
      LoanTenureAmount(
        total: total ?? _total,
        less_3M: less_3M ?? _less_3M,
        bwt_6M_12M: bwt_6M_12M ?? _bwt_6M_12M,
        bwt_3M_6M: bwt_3M_6M ?? _bwt_3M_6M,
        bwt_12M_24M: bwt_12M_24M ?? _bwt_12M_24M,
        above_24M: above_24M ?? _above_24M,
        closed: closed ?? _closed,
      );
  int? get total => _total;
  int? get less_3M => _less_3M;
  int? get bwt_6M_12M => _bwt_6M_12M;
  int? get bwt_3M_6M => _bwt_3M_6M;
  int? get bwt_12M_24M => _bwt_12M_24M;
  int? get above_24M => _above_24M;
  int? get closed => _closed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['less_3M'] = _less_3M;
    map['bwt_6M_12M'] = _bwt_6M_12M;
    map['bwt_3M_6M'] = _bwt_3M_6M;
    map['bwt_12M_24M'] = _bwt_12M_24M;
    map['above_24M'] = _above_24M;
    map['closed'] = _closed;
    return map;
  }
}

class LoanTenureNoOfLoansRemaining {
  LoanTenureNoOfLoansRemaining({
    int? less_3M,
    int? total,
    int? bwt_6M_12M,
    int? bwt_3M_6M,
    int? bwt_12M_24M,
    int? above_24M,
    int? closed,
  }) {
    _total = total;
    _less_3M = less_3M;
    _bwt_6M_12M = bwt_6M_12M;
    _bwt_3M_6M = bwt_3M_6M;
    _bwt_12M_24M = bwt_12M_24M;
    _above_24M = above_24M;
    _closed = closed;
  }

  LoanTenureNoOfLoansRemaining.fromJson(dynamic json) {
    _total = json['total'];
    _less_3M = json['less_3M'];
    _bwt_6M_12M = json['bwt_6M_12M'];
    _bwt_3M_6M = json['bwt_3M_6M'];
    _bwt_12M_24M = json['bwt_12M_24M'];
    _above_24M = json["above_24M"];
    _closed = json["closed"];
  }
  int? _total;
  int? _less_3M;
  int? _bwt_6M_12M;
  int? _bwt_3M_6M;
  int? _bwt_12M_24M;
  int? _above_24M;
  int? _closed;
  LoanTenureNoOfLoansRemaining copyWith({
    int? total,
    int? less_3M,
    int? bwt_6M_12M,
    int? bwt_3M_6M,
    int? bwt_12M_24M,
    int? above_24M,
    int? closed,
  }) =>
      LoanTenureNoOfLoansRemaining(
        total: total ?? _total,
        less_3M: less_3M ?? _less_3M,
        bwt_6M_12M: bwt_6M_12M ?? _bwt_6M_12M,
        bwt_3M_6M: bwt_3M_6M ?? _bwt_3M_6M,
        bwt_12M_24M: bwt_12M_24M ?? _bwt_12M_24M,
        above_24M: above_24M ?? _above_24M,
        closed: closed ?? _closed,
      );
  int? get total => _total;
  int? get less_3M => _less_3M;
  int? get bwt_6M_12M => _bwt_6M_12M;
  int? get bwt_3M_6M => _bwt_3M_6M;
  int? get bwt_12M_24M => _bwt_12M_24M;
  int? get above_24M => _above_24M;
  int? get closed => _closed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['less_3M'] = _less_3M;
    map['bwt_6M_12M'] = _bwt_6M_12M;
    map['bwt_3M_6M'] = _bwt_3M_6M;
    map['bwt_12M_24M'] = _bwt_12M_24M;
    map['above_24M'] = _above_24M;
    map['closed'] = _closed;
    return map;
  }
}

class LoanTenureAmountRemaining {
  LoanTenureAmountRemaining({
    int? less_3M,
    int? total,
    int? bwt_6M_12M,
    int? bwt_3M_6M,
    int? bwt_12M_24M,
    int? above_24M,
    int? closed,
  }) {
    _total = total;
    _less_3M = less_3M;
    _bwt_6M_12M = bwt_6M_12M;
    _bwt_3M_6M = bwt_3M_6M;
    _bwt_12M_24M = bwt_12M_24M;
    _above_24M = above_24M;
    _closed = closed;
  }

  LoanTenureAmountRemaining.fromJson(dynamic json) {
    _total = json['total'];
    _less_3M = json['less_3M'];
    _bwt_6M_12M = json['bwt_6M_12M'];
    _bwt_3M_6M = json['bwt_3M_6M'];
    _bwt_12M_24M = json['bwt_12M_24M'];
    _above_24M = json["above_24M"];
    _closed = json["closed"];
  }
  int? _total;
  int? _less_3M;
  int? _bwt_6M_12M;
  int? _bwt_3M_6M;
  int? _bwt_12M_24M;
  int? _above_24M;
  int? _closed;
  LoanTenureAmountRemaining copyWith({
    int? total,
    int? less_3M,
    int? bwt_6M_12M,
    int? bwt_3M_6M,
    int? bwt_12M_24M,
    int? above_24M,
    int? closed,
  }) =>
      LoanTenureAmountRemaining(
        total: total ?? _total,
        less_3M: less_3M ?? _less_3M,
        bwt_6M_12M: bwt_6M_12M ?? _bwt_6M_12M,
        bwt_3M_6M: bwt_3M_6M ?? _bwt_3M_6M,
        bwt_12M_24M: bwt_12M_24M ?? _bwt_12M_24M,
        above_24M: above_24M ?? _above_24M,
        closed: closed ?? _closed,
      );
  int? get total => _total;
  int? get less_3M => _less_3M;
  int? get bwt_6M_12M => _bwt_6M_12M;
  int? get bwt_3M_6M => _bwt_3M_6M;
  int? get bwt_12M_24M => _bwt_12M_24M;
  int? get above_24M => _above_24M;
  int? get closed => _closed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['less_3M'] = _less_3M;
    map['bwt_6M_12M'] = _bwt_6M_12M;
    map['bwt_3M_6M'] = _bwt_3M_6M;
    map['bwt_12M_24M'] = _bwt_12M_24M;
    map['above_24M'] = _above_24M;
    map['closed'] = _closed;
    return map;
  }
}

class InterestNoOfLoan {
  InterestNoOfLoan({
    double? upto149,
    double? total,
    double? from15to17,
    double? above171,
    double? closedAbove171,
    double? closedFrom15to17,
    double? closedUpto149,
  }) {
    _total = total;
    _upto149 = upto149;
    _from15to17 = from15to17;
    _above171 = above171;
    _closedAbove171 = closedAbove171;
    _closedFrom15to17 = closedFrom15to17;
    _closedUpto149 = closedUpto149;
  }

  InterestNoOfLoan.fromJson(dynamic json) {
    _total = json['total'];
    _upto149 = json['upto149'];
    _from15to17 = json['from15to17'];
    _above171 = json['above171'];
    _closedAbove171 = json['closed_above171'];
    _closedFrom15to17 = json['closed_from15to17'];
    _closedUpto149 = json['closed_upto149'];
  }
  double? _total;
  double? _upto149;
  double? _from15to17;
  double? _above171;
  double? _closedAbove171;
  double? _closedFrom15to17;
  double? _closedUpto149;

  InterestNoOfLoan copyWith({
    double? total,
    double? upto149,
    double? from15to17,
    double? above171,
    double? closedAbove171,
    double? closedFrom15to17,
    double? closedUpto149,
  }) =>
      InterestNoOfLoan(
        total: total ?? _total,
        upto149: upto149 ?? _upto149,
        from15to17: from15to17 ?? _from15to17,
        above171: above171 ?? _above171,
        closedAbove171: closedAbove171 ?? _closedAbove171,
        closedFrom15to17: closedFrom15to17 ?? _closedFrom15to17,
        closedUpto149: closedUpto149 ?? _closedUpto149,
      );
  double? get total => _total;
  double? get upto149 => _upto149;
  double? get from15to17 => _from15to17;
  double? get above171 => _above171;
  double? get closedAbove171 => _closedAbove171;
  double? get closedFrom15to17 => _closedFrom15to17;
  double? get closedUpto149 => _closedUpto149;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['upto149'] = _upto149;
    map['from15to17'] = _from15to17;
    map['above171'] = _above171;
    map['closed_above171'] = _closedAbove171;
    map['closed_from15to17'] = _closedFrom15to17;
    map['closed_upto149'] = _closedUpto149;

    return map;
  }
}

class InterestAmount {
  InterestAmount({
    double? upto149,
    double? total,
    double? from15to17,
    double? above171,
    double? closedAbove171,
    double? closedFrom15to17,
    double? closedUpto149,
  }) {
    _total = total;
    _upto149 = upto149;
    _from15to17 = from15to17;
    _above171 = above171;
    _closedAbove171 = closedAbove171;
    _closedFrom15to17 = closedFrom15to17;
    _closedUpto149 = closedUpto149;
  }

  InterestAmount.fromJson(dynamic json) {
    _total = json['total'];
    _upto149 = json['upto149'];
    _from15to17 = json['from15to17'];
    _above171 = json['above171'];
    _closedAbove171 = json['closed_above171'];
    _closedFrom15to17 = json['closed_from15to17'];
    _closedUpto149 = json['closed_upto149'];
  }
  double? _total;
  double? _upto149;
  double? _from15to17;
  double? _above171;
  double? _closedAbove171;
  double? _closedFrom15to17;
  double? _closedUpto149;

  InterestAmount copyWith({
    double? total,
    double? upto149,
    double? from15to17,
    double? above171,
    double? closedAbove171,
    double? closedFrom15to17,
    double? closedUpto149,
  }) =>
      InterestAmount(
        total: total ?? _total,
        upto149: upto149 ?? _upto149,
        from15to17: from15to17 ?? _from15to17,
        above171: above171 ?? _above171,
        closedAbove171: closedAbove171 ?? _closedAbove171,
        closedFrom15to17: closedFrom15to17 ?? _closedFrom15to17,
        closedUpto149: closedUpto149 ?? _closedUpto149,
      );
  double? get total => _total;
  double? get upto149 => _upto149;
  double? get from15to17 => _from15to17;
  double? get above171 => _above171;
  double? get closedAbove171 => _closedAbove171;
  double? get closedFrom15to17 => _closedFrom15to17;
  double? get closedUpto149 => _closedUpto149;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['upto149'] = _upto149;
    map['from15to17'] = _from15to17;
    map['above171'] = _above171;
    map['closed_above171'] = _closedAbove171;
    map['closed_from15to17'] = _closedFrom15to17;
    map['closed_upto149'] = _closedUpto149;

    return map;
  }
}

class DeliquencyCount {
  DeliquencyCount({
    double? less_3M,
    double? total,
    double? bwt_6M_12M,
    double? bwt_3M_6M,
    double? bwt_12M_24M,
    double? above_24M,
    double? above_6M,
    double? uninvestedAmount,
    double? goodStanding,
  }) {
    _total = total;
    _less_3M = less_3M;
    _bwt_6M_12M = bwt_6M_12M;
    _bwt_3M_6M = bwt_3M_6M;
    _bwt_12M_24M = bwt_12M_24M;
    _above_24M = above_24M;
    _above_6M = above_6M;
    _uninvestedAmount = uninvestedAmount;
    _goodStanding = goodStanding;
  }

  DeliquencyCount.fromJson(dynamic json) {
    _total = json['total'];
    _less_3M = json['less_3M'];
    _bwt_6M_12M = json['bwt_6M_12M'];
    _bwt_3M_6M = json['bwt_3M_6M'];
    _bwt_12M_24M = json['bwt_12M_24M'];
    _above_24M = json["above_24M"];
    _above_6M = json["above_6M"];
    _uninvestedAmount = json["uninvestedAmount"];
    _goodStanding = json["goodStanding"];
  }
  double? _total;
  double? _less_3M;
  double? _bwt_6M_12M;
  double? _bwt_3M_6M;
  double? _bwt_12M_24M;
  double? _above_24M;
  double? _above_6M;
  double? _uninvestedAmount;
  double? _goodStanding;
  DeliquencyCount copyWith({
    double? total,
    double? less_3M,
    double? bwt_6M_12M,
    double? bwt_3M_6M,
    double? bwt_12M_24M,
    double? above_24M,
    double? above_6M,
    double? uninvestedAmount,
    double? goodStanding,
  }) =>
      DeliquencyCount(
        total: total ?? _total,
        less_3M: less_3M ?? _less_3M,
        bwt_6M_12M: bwt_6M_12M ?? _bwt_6M_12M,
        bwt_3M_6M: bwt_3M_6M ?? _bwt_3M_6M,
        bwt_12M_24M: bwt_12M_24M ?? _bwt_12M_24M,
        above_24M: above_24M ?? _above_24M,
        above_6M: above_6M ?? _above_6M,
        uninvestedAmount: uninvestedAmount ?? _uninvestedAmount,
        goodStanding: goodStanding ?? _goodStanding,
      );
  double? get total => _total;
  double? get less_3M => _less_3M;
  double? get bwt_6M_12M => _bwt_6M_12M;
  double? get bwt_3M_6M => _bwt_3M_6M;
  double? get bwt_12M_24M => _bwt_12M_24M;
  double? get above_24M => _above_24M;
  double? get above_6M => _above_6M;
  double? get uninvestedAmount => _uninvestedAmount;
  double? get goodStanding => _goodStanding;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['less_3M'] = _less_3M;
    map['bwt_6M_12M'] = _bwt_6M_12M;
    map['bwt_3M_6M'] = _bwt_3M_6M;
    map['bwt_12M_24M'] = _bwt_12M_24M;
    map['above_24M'] = _above_24M;
    map['above_6M'] = _above_6M;
    map['uninvestedAmount'] = _uninvestedAmount;
    map['goodStanding'] = _goodStanding;
    return map;
  }
}

class DeliquencyAmount {
  DeliquencyAmount({
    double? less_3M,
    double? total,
    double? bwt_6M_12M,
    double? bwt_3M_6M,
    double? bwt_12M_24M,
    double? above_24M,
    double? above_6M,
    double? uninvestedAmount,
    double? goodStanding,
  }) {
    _total = total;
    _less_3M = less_3M;
    _bwt_6M_12M = bwt_6M_12M;
    _bwt_3M_6M = bwt_3M_6M;
    _bwt_12M_24M = bwt_12M_24M;
    _above_24M = above_24M;
    _above_6M = above_6M;
    _uninvestedAmount = uninvestedAmount;
    _goodStanding = goodStanding;
  }

  DeliquencyAmount.fromJson(dynamic json) {
    _total = json['total'];
    _less_3M = json['less_3M'];
    _bwt_6M_12M = json['bwt_6M_12M'];
    _bwt_3M_6M = json['bwt_3M_6M'];
    _bwt_12M_24M = json['bwt_12M_24M'];
    _above_24M = json["above_24M"];
    _above_6M = json["above_6M"];
    _uninvestedAmount = json["uninvestedAmount"];
    _goodStanding = json["goodStanding"];
  }
  double? _total;
  double? _less_3M;
  double? _bwt_6M_12M;
  double? _bwt_3M_6M;
  double? _bwt_12M_24M;
  double? _above_24M;
  double? _above_6M;
  double? _uninvestedAmount;
  double? _goodStanding;
  DeliquencyAmount copyWith({
    double? total,
    double? less_3M,
    double? bwt_6M_12M,
    double? bwt_3M_6M,
    double? bwt_12M_24M,
    double? above_24M,
    double? above_6M,
    double? uninvestedAmount,
    double? goodStanding,
  }) =>
      DeliquencyAmount(
        total: total ?? _total,
        less_3M: less_3M ?? _less_3M,
        bwt_6M_12M: bwt_6M_12M ?? _bwt_6M_12M,
        bwt_3M_6M: bwt_3M_6M ?? _bwt_3M_6M,
        bwt_12M_24M: bwt_12M_24M ?? _bwt_12M_24M,
        above_24M: above_24M ?? _above_24M,
        above_6M: above_6M ?? _above_6M,
        uninvestedAmount: uninvestedAmount ?? _uninvestedAmount,
        goodStanding: goodStanding ?? _goodStanding,
      );
  double? get total => _total;
  double? get less_3M => _less_3M;
  double? get bwt_6M_12M => _bwt_6M_12M;
  double? get bwt_3M_6M => _bwt_3M_6M;
  double? get bwt_12M_24M => _bwt_12M_24M;
  double? get above_24M => _above_24M;
  double? get above_6M => _above_6M;
  double? get uninvestedAmount => _uninvestedAmount;
  double? get goodStanding => _goodStanding;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['less_3M'] = _less_3M;
    map['bwt_6M_12M'] = _bwt_6M_12M;
    map['bwt_3M_6M'] = _bwt_3M_6M;
    map['bwt_12M_24M'] = _bwt_12M_24M;
    map['above_24M'] = _above_24M;
    map['above_6M'] = _above_6M;
    map['uninvestedAmount'] = _uninvestedAmount;
    map['goodStanding'] = _goodStanding;
    return map;
  }
}
