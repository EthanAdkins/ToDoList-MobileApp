class SearchTaskRequestModel {
  String? user;
  String? search;

  SearchTaskRequestModel({this.user, this.search});

  SearchTaskRequestModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user'] = user;
    data['search'] = search;
    return data;
  }
}
