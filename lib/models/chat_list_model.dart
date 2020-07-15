class ChatListModel {
  String status;
  String message;
  List<ChatList> chatList;

  ChatListModel({this.status, this.message});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    if (json['message'] != null) {
      chatList = new List<ChatList>();
      json['message'].forEach((v) {
        chatList.add(new ChatList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.chatList != null) {
      data['chatList'] = this.chatList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatList {
  int chatId;
  String message;
  String receipt;
  String updatedAt;
  User user;

  ChatList({this.chatId, this.message, this.receipt, this.updatedAt, this.user});

  ChatList.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    message = json['message'];
    receipt = json['receipt'];
    updatedAt = json['updatedAt'];
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
  String imageUrl;
  String name;

  User({this.userId, this.imageUrl, this.name});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    imageUrl = json['imageUrl'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    return data;
  }
}