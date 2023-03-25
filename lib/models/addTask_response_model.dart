import 'dart:convert';

AddTaskResponseModel addTaskResponseModel(String str) =>
    AddTaskResponseModel.fromJson(json.decode(str));

class AddTaskResponseModel {
  AddTaskResponseModel({
    required this.error,
  });
  late final String error;

  AddTaskResponseModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    return _data;
  }
}
