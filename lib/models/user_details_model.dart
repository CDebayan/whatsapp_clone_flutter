class UserDetailsModel {
  String status;
  String message;
  UserDetails data;

  UserDetailsModel({this.status, this.message, this.data});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    data = json['data'] != null ? new UserDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class UserDetails {
  String countryCode;
  String mobileNo;
  String name;
  String imageUrl;
  String about;

  UserDetails({this.countryCode, this.mobileNo, this.name, this.imageUrl, this.about});

  UserDetails.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'].toString();
    mobileNo = json['mobileNo'].toString();
    name = json['name'].toString();
    imageUrl = json['imageUrl'].toString();
    about = json['about'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryCode'] = this.countryCode;
    data['mobileNo'] = this.mobileNo;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['about'] = this.about;
    return data;
  }
}