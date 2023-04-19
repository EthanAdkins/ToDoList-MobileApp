import 'dart:convert';

EditTaskResponseModel editTaskResponseModel(String str) =>
    EditTaskResponseModel.fromJson(json.decode(str));

class EditTaskResponseModel {
  EditTaskResponseModel({
    required this.error,
  });
  late final String error;

  EditTaskResponseModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    return _data;
  }
}
