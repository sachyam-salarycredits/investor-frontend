class FilterDetails {
  static final MAX_AMOUNT = 1000000.0;
  static final MIN_AMOUNT = 1000.0;

  double minAmount;
  double maxAmount;
  double tenure;
  int pageNo = 0;
  List<String> grade;
  List<String> products;

  FilterDetails({
    this.minAmount = 0,
    this.pageNo = 0,
    this.maxAmount = 0,
    this.tenure = 0,
    this.grade = const [],
    this.products = const [],
  }) {
    if (products.isEmpty) {
      products = List.empty(growable: true);
    }
    if (grade.isEmpty) {
      grade = List.empty(growable: true);
    }
  }

  int getFilterCount() {
    var data = 0;
    if (minAmount > 0 || maxAmount > 0) {
      data++;
    }
    if (tenure > 0) {
      data++;
    }
    if (grade.isNotEmpty) {
      data++;
    }
    if (products.isNotEmpty) {
      data++;
    }
    return data;
  }

  String getFilterCountStr() {
    var count = getFilterCount();
    if (count > 0) {
      return '($count)';
    }
    return '';
  }
}
