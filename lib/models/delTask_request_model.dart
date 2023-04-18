class DelTaskRequestModel {
  DelTaskRequestModel({
    required this.taskContent,
    required this.time,
    required this.category,
    required this.user,
  });
  late final String taskContent;
  late final String time;
  late final String category;
  late final String user;

  DelTaskRequestModel.fromJson(Map<String, dynamic> json) {
    taskContent = json['taskContent'];
    time = json['time'];
    category = json['category'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['taskContent'] = taskContent;
    _data['time'] = time;
    _data['category'] = category;
    _data['user'] = user;
    return _data;
  }
}
