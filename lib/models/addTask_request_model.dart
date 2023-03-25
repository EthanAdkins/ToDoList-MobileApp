class AddTaskRequestModel {
  AddTaskRequestModel({
    required this.taskContent,
    required this.time,
    required this.category,
  });
  late final String taskContent;
  late final String time;
  late final String category;

  AddTaskRequestModel.fromJson(Map<String, dynamic> json) {
    taskContent = json['taskContent'];
    time = json['time'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['taskContent'] = taskContent;
    _data['time'] = time;
    _data['category'] = category;
    return _data;
  }
}
