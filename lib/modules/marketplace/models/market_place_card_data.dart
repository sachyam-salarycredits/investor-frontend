class MarketPlaceCardData {
  bool isFunded = false;
  bool isAddedToCart = false;
  int fundedAmount = 1000;
  String id = "";
  String name = "";
  String tenure = "0";
  String intrest = "0";
  String totalAskingAmount = "0";
  MarketPlaceCardData({required this.id});

  @override
  String toString() {
    return id;
  }

  @override
  bool operator ==(Object other) {
    return this.id == other.toString();
  }
}
