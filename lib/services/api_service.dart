import 'dart:convert';

import 'package:fridge_app/config.dart';
import 'package:fridge_app/models/login_request_model.dart';
import 'package:fridge_app/models/login_response_model.dart';
import 'package:fridge_app/models/register_request_model.dart';
import 'package:fridge_app/models/register_response_model.dart';
import 'package:fridge_app/services/shared_service.dart';

import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();
  var idCheck;
  static Future<bool> login(LoginRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    var test = json.decode(response.body);
    if (response.statusCode == 200 && test['_id'] != -1) {
      GlobalData.id = test['_id'];
      GlobalData.firstName = test['firstName'];
      GlobalData.lastName = test['lastName'];
      GlobalData.userName = test['user'];
      GlobalData.password = test['password'];
      GlobalData.email = test['email'];
      // Shared
      // This is sketchy but it works
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
      RegisterRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return registerResponseModel(response.body);
  }

/*
  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
    );
    var testID = json.decode(response.body);
    if (response.statusCode == 200 && testID['_id'] != -1) {
      // Shared
      // This is sketchy but it works
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return response.body;
    } else {
      return "";
    }
  }*/
}

class GlobalData {
  static String? id;
  static String? firstName;
  static String? lastName;
  static String? userName;
  static String? password;
  static String? email;
}
