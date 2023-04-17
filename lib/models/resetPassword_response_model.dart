import 'dart:convert';

ResetPasswordResponseModel resetPasswordResponseModel(String str) =>
    ResetPasswordResponseModel.fromJson(json.decode(str));

class ResetPasswordResponseModel {
  ResetPasswordResponseModel({
    required this.error,
  });
  late final String error;

  ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    return _data;
  }
}
