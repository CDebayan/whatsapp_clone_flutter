class LoginModel {
  String status;
  String message;
  String accessToken;

  LoginModel({this.status, this.message, this.accessToken});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'].toString(),
      message: json['message'].toString(),
      accessToken: json['accessToken'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
