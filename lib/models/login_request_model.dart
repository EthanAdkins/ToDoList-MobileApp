class LoginRequestModel {
  LoginRequestModel({
    required this.user,
    required this.password,
  });
  late final String user;
  late final String password;

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user;
    _data['password'] = password;
    return _data;
  }
}
