class AddressPatient {
  String? house;
  String? street;
  String? landmarks;
  String? city;
  String? pincode;

  AddressPatient({this.house, this.street, this.landmarks, this.city, this.pincode});

  AddressPatient.fromJson(Map<String, dynamic> json) {
    house = json['house'];
    street = json['street'];
    landmarks = json['landmarks'];
    city = json['city'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['house'] = house;
    data['street'] = street;
    data['landmarks'] = landmarks;
    data['city'] = city;
    data['pincode'] = pincode;
    return data;
  }
}