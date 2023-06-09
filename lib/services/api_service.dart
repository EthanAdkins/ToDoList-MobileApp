import 'dart:convert';

import 'package:fridge_app/config.dart';
import 'package:fridge_app/models/addTask_request_model.dart';
import 'package:fridge_app/models/addTask_response_model.dart';
import 'package:fridge_app/models/delTask_request_model.dart';
import 'package:fridge_app/models/delTask_response_model.dart';
import 'package:fridge_app/models/editTask_request_model.dart';
import 'package:fridge_app/models/editTask_response_model.dart';
import 'package:fridge_app/models/emailVerification_request_model.dart';
import 'package:fridge_app/models/emailVerification_response_model.dart';
import 'package:fridge_app/models/login_request_model.dart';
import 'package:fridge_app/models/login_response_model.dart';
import 'package:fridge_app/models/register_request_model.dart';
import 'package:fridge_app/models/register_response_model.dart';
import 'package:fridge_app/models/resetPassword_request_model.dart';
import 'package:fridge_app/models/resetPassword_response_model.dart';
import 'package:fridge_app/models/searchTask_request_model.dart';
import 'package:fridge_app/models/searchTask_response_model.dart';

import 'package:fridge_app/models/sendEmail_request_model.dart';
import 'package:fridge_app/models/sendEmail_response_model.dart';
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
      GlobalData.verified = test['verified'];
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

  static Future<AddTaskResponseModel> addTask(AddTaskRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.addTaskAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return addTaskResponseModel(response.body);
  }

  static Future<SendEmailResponseModel> sendEmail(
      SendEmailRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.sendEmailAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return sendEmailResponseModel(response.body);
  }

  static Future<ResetPasswordResponseModel> resetPassword(
      ResetPasswordRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.resetPasswordAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return resetPasswordResponseModel(response.body);
  }

  static Future<SearchTaskResponseModel> searchTask(
      SearchTaskRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(Config.apiURL, Config.searchTaskAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return searchTaskResponseModel(response.body);
  }

  static Future<DelTaskResponseModel> delTask(DelTaskRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.delTaskAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return delTaskResponseModel(response.body);
  }

  static Future<EditTaskResponseModel> editTask(
      EditTaskRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.editTaskAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return editTaskResponseModel(response.body);
  }

  static Future<EmailVerificationResponseModel> emailVerification(
      EmailVerificationRequestModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.emailVerificationAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return emailVerificationResponseModel(response.body);
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
  static String? id = "";
  static String? firstName = "";
  static String? lastName = "";
  static String? userName = "";
  static String? password = "";
  static String? email = "";
  static bool? verified = null;
}
