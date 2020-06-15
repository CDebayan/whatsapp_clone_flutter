
class ContactListModel {
  String id;
  String name;
  String mobile;

  ContactListModel({this.id,this.name, this.mobile});

  ContactListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    return data;
  }
}