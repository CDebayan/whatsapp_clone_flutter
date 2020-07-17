class ChatListModel {
  String status;
  String message;
  List<ChatList> chatList;

  ChatListModel({this.status, this.message, this.chatList});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'] ?? "";
    if (json['chatList'] != null) {
      chatList = new List<ChatList>();
      json['chatList'].forEach((v) {
        chatList.add(new ChatList.fromJson(v));
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

class ChatList {
  Chat chat;
  UserData userData;

  ChatList({this.chat, this.userData});

  ChatList.fromJson(Map<String, dynamic> json) {
    chat = json['chat'] != null ? new Chat.fromJson(json['chat']) : null;
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chat != null) {
      data['chat'] = this.chat.toJson();
    }
    if (this.userData != null) {
      data['userData'] = this.userData.toJson();
    }
    return data;
  }
}

class Chat {
  int chatId;
  String message;
  String receipt;
  String updatedAt;

  Chat({this.chatId, this.message, this.receipt, this.updatedAt});

  Chat.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'];
    message = json['message'] ?? "";
    receipt = json['receipt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatId'] = this.chatId;
    data['message'] = this.message;
    data['receipt'] = this.receipt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class UserData {
  String name;
  String imageUrl;

  UserData({this.name, this.imageUrl});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    imageUrl = json['imageUrl'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}