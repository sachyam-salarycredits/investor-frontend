class StatementData {
  String year;
  String? statementUrl;

  StatementData({
    this.year = '',
    this.statementUrl = '',
  });

  factory StatementData.fromJson(Map<String, dynamic> json) => StatementData(
        year: json["year"] == null ? "" : json["year"].toString(),
        statementUrl:
            json["statementUrl"] == null ? null : json["statementUrl"],
      );

  Map<String, dynamic> toJson() => {
        "year": year,
        "statementUrl": statementUrl,
      };
}
