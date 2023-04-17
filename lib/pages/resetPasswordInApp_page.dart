import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fridge_app/models/register_request_model.dart';
import 'package:fridge_app/models/resetPassword_request_model.dart';
import 'package:fridge_app/models/resetPassword_response_model.dart';
import 'package:fridge_app/models/sendEmail_request_model.dart';
import 'package:fridge_app/models/sendEmail_response_model.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../config.dart';
import '../models/login_request_model.dart';
import '../services/api_service.dart';

class resetPasswordInAppPage extends StatefulWidget {
  const resetPasswordInAppPage({super.key});

  @override
  State<resetPasswordInAppPage> createState() => _resetPasswordInAppPageState();
}

class _resetPasswordInAppPageState extends State<resetPasswordInAppPage> {
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? password;
  String? newPass;
  String? confirmNewPass;
  RegExp newPasswordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{2,20}$');
  bool hidePassword = true;
  bool hidePassword2 = true;

  bool hidePassword3 = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: HexColor("#A5B2DF"),
            body: ProgressHUD(
              child: Form(
                key: globalFormKey,
                child: _resetPassword(context),
              ),
              inAsyncCall: isAPIcallProcess,
              opacity: 0.3,
              key: UniqueKey(),
            )));
  }

  Widget _resetPassword(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff9736c5),
                  Color(0xff9736c5),
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/WingedEmail.png",
                  width: 280,
                  fit: BoxFit.contain,
                ),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 30,
              top: 50,
            ),
            child: Text('RESET PASSWORD',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                )),
          ),
          FormHelper.inputFieldWidget(
            context,
            'password',
            'Current Password',
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Current Password can\'t be empty.";
              }
              return null;
            },
            (onSavedVal) {
              password = onSavedVal;
            },
            prefixIcon: const Icon(Icons.lock),
            showPrefixIcon: true,
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 10,
            obscureText: hidePassword,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  hidePassword = !hidePassword;
                });
              },
              color: Colors.white.withOpacity(0.7),
              icon: Icon(
                hidePassword ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              'newPass',
              'New Password',
              (onValidateVal) {
                confirmNewPass = onValidateVal;
                if (onValidateVal.isEmpty) {
                  return "New Password can\'t be empty.";
                }
                if (!newPasswordRegex.hasMatch(onValidateVal)) {
                  return "Password must meet the requirements";
                }
                return null;
              },
              (onSavedVal) {
                newPass = onSavedVal;
              },
              prefixIcon: const Icon(Icons.lock_outline),
              showPrefixIcon: true,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              obscureText: hidePassword2,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword2 = !hidePassword2;
                  });
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword2 ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              'newPass',
              'Confirm New Password',
              (onValidateVal) {
                if (onValidateVal != confirmNewPass) {
                  return "Passwords must match";
                }
                return null;
              },
              (onSavedVal) {
                newPass = onSavedVal;
              },
              prefixIcon: const Icon(Icons.lock_outline),
              showPrefixIcon: true,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              obscureText: hidePassword3,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword3 = !hidePassword3;
                  });
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword3 ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: FormHelper.submitButton(
              "RESET PASSWORD",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });
                  ResetPasswordRequestModel model = ResetPasswordRequestModel(
                    user: GlobalData.userName!,
                    password: password!,
                    newPassword: newPass!,
                  );
                  APIService.resetPassword(model).then((response) {
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    if (response.error == '') {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "Password has been changed",
                        "OK",
                        () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        },
                      );
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        response.error,
                        "OK",
                        () {
                          Navigator.pop(context);
                        },
                      );
                    }
                  });
                }
              },
              width: 190,
              btnColor: HexColor("#9736C5"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
