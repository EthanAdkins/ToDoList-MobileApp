import 'dart:convert';

SendEmailResponseModel sendEmailResponseModel(String str) =>
    SendEmailResponseModel.fromJson(json.decode(str));

class SendEmailResponseModel {
  SendEmailResponseModel({
    required this.user,
    required this.password,
    required this.newPassword,
  });
  late final String user;
  late final String password;
  late final String newPassword;

  SendEmailResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    password = json['password'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user;
    _data['password'] = password;
    _data['newPassword'] = newPassword;
    return _data;
  }
}
