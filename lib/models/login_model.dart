class LoginModel {
  String status;
  String message;
  String token;

  LoginModel({this.status, this.message, this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'].toString(),
      message: json['message'].toString(),
      token: json['token'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    return data;
  }
}
