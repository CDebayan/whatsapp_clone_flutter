class CountryListModel {
  String status;
  String message;
  List<CountryModel> countryList;

  CountryListModel({this.status, this.message,this.countryList});

  CountryListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['countryList'] != null) {
      countryList = List<CountryModel>();
      json['countryList'].forEach((v) {
        countryList.add(CountryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.countryList != null) {
      data['countryList'] = this.countryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

////////////////////////////////////////////////////////////////////////////////////////

class CountryModel {
  String flag;
  String name;
  List<String> callingCodes;
  bool selected;

  CountryModel({this.flag, this.name, this.callingCodes,this.selected = false});

  CountryModel.fromJson(Map<String, dynamic> json) {
    flag = json['flag'];
    name = json['name'];
    callingCodes = json['callingCodes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['flag'] = this.flag;
    data['name'] = this.name;
    data['callingCodes'] = this.callingCodes;
    return data;
  }
}