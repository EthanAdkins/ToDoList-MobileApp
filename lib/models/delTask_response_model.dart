import 'dart:convert';

DelTaskResponseModel delTaskResponseModel(String str) =>
    DelTaskResponseModel.fromJson(json.decode(str));

class DelTaskResponseModel {
  DelTaskResponseModel({
    required this.error,
  });
  late final String error;

  DelTaskResponseModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    return _data;
  }
}
