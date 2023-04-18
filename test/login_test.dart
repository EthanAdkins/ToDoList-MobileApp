import 'package:fridge_app/models/login_request_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_app/services/api_service.dart';

import 'package:fridge_app/main.dart';

void main() {
  group('APIService', () {
    test('login should return true for valid credentials', () async {
      final username = 'UnitTester';
      final password = 'UnitTester@1';
      final model = LoginRequestModel(user: username, password: password);
      var result;
      await APIService.login(model).then((response) {
        result = response;
      });

      expect(result, isTrue);
    });

    test('login should return false for invalid credentials', () async {
      final username = 'invaliduser';
      final password = 'invalidpassword';
      final model = LoginRequestModel(user: username, password: password);

      final result = await APIService.login(model);

      expect(result, isFalse);
    });
  });
}
