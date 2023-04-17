class SendEmailRequestModel {
  SendEmailRequestModel({
    required this.user,
    required this.email,
  });
  late final String user;
  late final String email;

  SendEmailRequestModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user;
    _data['email'] = email;
    return _data;
  }
}
