import 'dart:convert';

SearchTaskResponseModel searchTaskResponseModel(String str) =>
    SearchTaskResponseModel.fromJson(json.decode(str));

class SearchTaskResponseModel {
  SearchTaskResponseModel({
    required this.results,
    required this.error,
  });
  late final List<dynamic> results;
  late final String? error;

  SearchTaskResponseModel.fromJson(Map<String, dynamic> json)
      : results = json['results'] as List,
        error = json['error'] as String?;

  Map<String, dynamic> toJson() => {'results': results, 'error': error};
}
