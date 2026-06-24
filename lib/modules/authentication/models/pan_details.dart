class PanDetails {
  String pan;
  String firstName;
  String middleName;
  String lastName;
  String fullName;
  String gender;
  bool aadharLinked;
  String aadharMatch;
  String aadharNumber;
  String dob;
  String buildingName;
  String locality;
  String streetName;
  String pinCode;
  String city;
  String state;
  String country;
  String mobile;
  String email;
  String otp;

  PanDetails({
    this.pan = '',
    this.firstName = '',
    this.middleName = '',
    this.lastName = '',
    this.fullName = '',
    this.gender = '',
    this.aadharLinked = false,
    this.aadharMatch = '',
    this.aadharNumber = '',
    this.dob = "",
    this.buildingName = '',
    this.locality = '',
    this.streetName = '',
    this.pinCode = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.mobile = '',
    this.email = '',
    this.otp = '',
  });

  factory PanDetails.fromJson(Map<String, dynamic> json) => PanDetails(
        pan: json["pan"] ?? '',
        firstName: json["firstName"] ?? '',
        middleName: json["middleName"] ?? '',
        lastName: json["lastName"] ?? '',
        fullName: json["fullName"] ?? '',
        gender: json["gender"] ?? '',
        aadharLinked: json["aadharLinked"] ?? false,
        aadharMatch: json["aadharMatch"] ?? '',
        aadharNumber: json["aadharNumber"] ?? '',
        dob: json["dob"] ?? "",
        buildingName: json["buildingName"] ?? '',
        locality: json["locality"] ?? '',
        streetName: json["streetName"] ?? '',
        pinCode: json["pinCode"] ?? '',
        city: json["city"] ?? '',
        state: json["state"] ?? '',
        country: json["country"] ?? '',
        mobile: json["mobile"] ?? '',
        email: json["email"] ?? '',
        otp: json["otp"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "pan": pan,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "fullName": fullName,
        "gender": gender,
        "aadharLinked": aadharLinked,
        "aadharMatch": aadharMatch,
        "aadharNumber": aadharNumber,
        "dob": dob,
        "buildingName": buildingName,
        "locality": locality,
        "streetName": streetName,
        "pinCode": pinCode,
        "city": city,
        "state": state,
        "country": country,
        "mobile": mobile,
        "email": email,
        "otp": otp,
      };
}
