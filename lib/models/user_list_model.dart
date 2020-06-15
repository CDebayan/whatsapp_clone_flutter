class UserListModel {
  String status;
  String message;
  List<UserModel> userModel;

  UserListModel({this.status, this.message,this.userModel});

  UserListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    if (json['userList'] != null) {
      userModel = new List<UserModel>();
      json['userList'].forEach((v) {
        userModel.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.userModel != null) {
      data['userList'] = this.userModel.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserModel {
  int id;
  String name;
  String profileImage;
  String about;

  UserModel({this.id, this.name, this.profileImage, this.about});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profileImage'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profileImage'] = this.profileImage;
    data['about'] = this.about;
    return data;
  }
}