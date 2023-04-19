class EditTaskRequestModel {
  EditTaskRequestModel({
    required this.taskContent,
    required this.time,
    required this.category,
    required this.user,
    required this.newTaskContent,
    required this.newTime,
    required this.newCategory,
  });
  late final String taskContent;
  late final String time;
  late final String category;
  late final String user;
  late final String newTaskContent;
  late final String newTime;
  late final String newCategory;

  EditTaskRequestModel.fromJson(Map<String, dynamic> json) {
    taskContent = json['taskContent'];
    time = json['time'];
    category = json['category'];
    user = json['user'];
    newTaskContent = json['newTaskContent'];
    newTime = json['newTime'];
    newCategory = json['newCategory'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['taskContent'] = taskContent;
    _data['time'] = time;
    _data['category'] = category;
    _data['user'] = user;
    _data['newTaskContent'] = newTaskContent;
    _data['newTime'] = newTime;
    _data['newCategory'] = newCategory;
    return _data;
  }
}
