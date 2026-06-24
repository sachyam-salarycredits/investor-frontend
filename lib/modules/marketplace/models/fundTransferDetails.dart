import 'dart:convert';

UserFundTransferDetails userFundTransferDetailsFromJson(String str) =>
    UserFundTransferDetails.fromJson(json.decode(str));

String userFundTransferDetailsToJson(UserFundTransferDetails data) =>
    json.encode(data.toJson());

class UserFundTransferDetails {
  UserFundTransferDetails({
    this.totalNetYeild,
    this.totalIncome,
    this.totalFundsWithdrawn,
    this.totalFundsTransferred,
    this.totalAvailableBalance,
    this.LoansFullyCompleted,
    this.liveLoans
  });

  TotalNetYeild? totalNetYeild;
  TotalIncome? totalIncome;
  TotalFunds? totalFundsWithdrawn;
  TotalFunds? totalFundsTransferred;
  TotalAvailableBalance? totalAvailableBalance;
  int? LoansFullyCompleted;
  int? liveLoans;

  factory UserFundTransferDetails.fromJson(Map<String, dynamic> json) =>
      UserFundTransferDetails(
        totalNetYeild: json["totalNetYeild"] == null
            ? TotalNetYeild()
            : TotalNetYeild.fromJson(json["totalNetYeild"]),
        totalIncome: json["totalIncome"] == null
            ? null
            : TotalIncome.fromJson(json["totalIncome"]),
        totalFundsWithdrawn: json["totalFundsWithdrawn"] == null
            ? null
            : TotalFunds.fromJson(json["totalFundsWithdrawn"]),
        totalFundsTransferred: json["totalFundsTransferred"] == null
            ? null
            : TotalFunds.fromJson(json["totalFundsTransferred"]),
        totalAvailableBalance: json["totalAvailableBalance"] == null
            ? null
            : TotalAvailableBalance.fromJson(json["totalAvailableBalance"]),
        LoansFullyCompleted:
        json["LoansFullyCompleted"] == null ? null : json["LoansFullyCompleted"],
        liveLoans:
        json["liveLoans"] == null ? null : json["liveLoans"],
      );

  Map<String, dynamic> toJson() => {
        "totalNetYeild": totalNetYeild == null ? null : totalNetYeild?.toJson(),
        "totalIncome": totalIncome == null ? null : totalIncome?.toJson(),
        "totalFundsWithdrawn":
            totalFundsWithdrawn == null ? null : totalFundsWithdrawn?.toJson(),
        "totalFundsTransferred": totalFundsTransferred == null
            ? null
            : totalFundsTransferred?.toJson(),
        "totalAvailableBalance": totalAvailableBalance == null
            ? null
            : totalAvailableBalance?.toJson(),
        "liveLoans": liveLoans == null ? null : liveLoans,
        "LoansFullyCompleted": LoansFullyCompleted == null ? null : LoansFullyCompleted,
      };
}

class TotalAvailableBalance {
  TotalAvailableBalance({
    this.statement = const [],
    this.availableBalance = 0,
  });

  List<FundsStatement> statement;
  double availableBalance;

  factory TotalAvailableBalance.fromJson(Map<String, dynamic> json) =>
      TotalAvailableBalance(
        statement: json["statement"] == null
            ? []
            : List<FundsStatement>.from(json["statement"].map((x) => x)),
        availableBalance: json["availableBalance"] == null
            ? 0
            : json["availableBalance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "statement": List<FundsStatement>.from(statement.map((x) => x)),
        "availableBalance": availableBalance,
      };
}

class TotalFunds {
  TotalFunds({
    this.transactionType = "",
    this.transactionDate = "",
    this.transactionAmount = 0,
    this.statement = const [],
  });

  String transactionType;
  dynamic transactionDate;
  double transactionAmount;
  List<FundsStatement> statement;

  factory TotalFunds.fromJson(Map<String, dynamic> json) => TotalFunds(
        transactionType:
            json["transactionType"] == null ? '' : json["transactionType"],
        transactionDate: json["transactionDate"],
        transactionAmount: json["transactionAmount"] == null
            ? 0.0
            : json["transactionAmount"].toDouble(),
        statement: json["statement"] == null
            ? []
            : List<FundsStatement>.from(
                json["statement"].map((x) => FundsStatement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transactionType": transactionType,
        "transactionDate": transactionDate,
        "transactionAmount": transactionAmount,
        "statement":
            List<FundsStatement>.from(statement.map((x) => x.toJson())),
      };
}

class FundsStatement {
  FundsStatement({
    this.tDate,
    this.amount = 0.0,
  });

  DateTime? tDate;
  double amount;

  factory FundsStatement.fromJson(Map<String, dynamic> json) => FundsStatement(
        tDate: json["t_Date"] == null ? null : DateTime.parse(json["t_Date"]),
        amount: json["amount"] == null ? 0.0 : json["amount"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "t_Date": tDate == null
            ? null
            : "${tDate!.year.toString().padLeft(4, '0')}-${tDate!.month.toString().padLeft(2, '0')}-${tDate!.day.toString().padLeft(2, '0')}",
        "amount": amount,
      };
}

class TotalIncome {
  TotalIncome({
    this.statement = const [],
    this.income = "0",
  });

  List<FundsStatement> statement;
  String income;

  factory TotalIncome.fromJson(Map<String, dynamic> json) => TotalIncome(
        statement: json["statement"] == null
            ? []
            : List<FundsStatement>.from(json["statement"].map((x) => x)),
        income: json["income"] == null ? '' : json["income"],
      );

  Map<String, dynamic> toJson() => {
        "statement": List<FundsStatement>.from(statement.map((x) => x)),
        "income": income,
      };
}

class TotalNetYeild {
  TotalNetYeild({
    this.statement = const [],
    this.netYeild = "0",
  });

  List<FundsStatement> statement;
  String netYeild;

  factory TotalNetYeild.fromJson(Map<String, dynamic> json) => TotalNetYeild(
        statement: json["statement"] == null
            ? []
            : List<FundsStatement>.from(json["statement"].map((x) => x)),
        netYeild: json["netYeild"] == null ? "0" : json["netYeild"],
      );

  Map<String, dynamic> toJson() => {
        "statement": List<FundsStatement>.from(statement.map((x) => x)),
        "netYeild": netYeild,
      };
}
