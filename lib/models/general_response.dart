class GeneralResponse {
  String status;
  String message;

  GeneralResponse({this.status, this.message});

  GeneralResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}