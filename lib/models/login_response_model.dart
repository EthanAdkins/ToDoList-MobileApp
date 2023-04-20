import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.error,
    required this.verified,
  });
  late final String id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String error;
  late final bool verified;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['_id'] != -1) {
      id = json['_id'];
    } else {
      id = "";
    }
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    error = json['error'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['email'] = email;
    _data['error'] = error;
    _data['verified'] = verified;
    return _data;
  }
}
