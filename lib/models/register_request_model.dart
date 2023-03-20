class RegisterRequestModel {
  RegisterRequestModel({
    required this.firstName,
    required this.lastName,
    required this.user,
    required this.password,
    required this.email,
  });
  late final String firstName;
  late final String lastName;
  late final String user;
  late final String password;
  late final String email;

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    user = json['user'];
    password = json['password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['user'] = user;
    _data['password'] = password;
    _data['email'] = email;
    return _data;
  }
}
