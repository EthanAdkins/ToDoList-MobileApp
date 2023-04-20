import 'dart:convert';

EmailVerificationResponseModel emailVerificationResponseModel(String str) =>
    EmailVerificationResponseModel.fromJson(json.decode(str));

class EmailVerificationResponseModel {
  EmailVerificationResponseModel({
    required this.user,
    required this.verified,
  });
  late final String user;
  late final bool verified;

  EmailVerificationResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user;
    _data['verified'] = verified;
    return _data;
  }
}
