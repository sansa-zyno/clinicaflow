class StaffModel {
  List<Staff>? data;
  int? totalCount;

  StaffModel({this.data, this.totalCount});

  StaffModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Staff>[];
      json['data'].forEach((v) {
        data!.add(Staff.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    return data;
  }
}

class Staff {
  String? sId;
  String? staffId;
  String? firstName;
  String? lastName;
  bool? isDoctor;
  String? mobile;
  String? role;

  Staff(
      {this.sId,
      this.staffId,
      this.firstName,
      this.lastName,
      this.isDoctor,
      this.mobile,
      this.role});

  Staff.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    staffId = json['staffId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    isDoctor = json['isDoctor'];
    mobile = json['mobile'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['staffId'] = this.staffId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['isDoctor'] = this.isDoctor;
    data['mobile'] = this.mobile;
    data['role'] = this.role;
    return data;
  }
}
