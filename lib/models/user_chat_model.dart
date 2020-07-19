class UserChatModel {
  String status;
  String message;
  List<UserChatList> chatList;

  UserChatModel({this.status, this.message, this.chatList});

  UserChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'] ?? "";
    if (json['chatList'] != null) {
      chatList = new List<UserChatList>();
      json['chatList'].forEach((v) {
        chatList.add(new UserChatList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.chatList != null) {
      data['chatList'] = this.chatList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserChatList {
  int chatId;
  String message;
  String receipt;
  String updatedAt;
  User user;

  UserChatList(
      {this.chatId, this.message, this.receipt, this.updatedAt, this.user});

  UserChatList.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    message = json['message'] ?? "";
    receipt = json['receipt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatId'] = this.chatId;
    data['message'] = this.message;
    data['receipt'] = this.receipt;
    data['updatedAt'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int userId;
  String name;
  String imageUrl;

  User({this.userId, this.name, this.imageUrl});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'] ?? "";
    imageUrl = json['imageUrl'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}