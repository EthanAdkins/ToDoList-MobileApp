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

class resetPasswordPage extends StatefulWidget {
  const resetPasswordPage({super.key});

  @override
  State<resetPasswordPage> createState() => _resetPasswordPageState();
}

class _resetPasswordPageState extends State<resetPasswordPage> {
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? username;
  String? email;
  String? confirmEmail;
  String? newPass;

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
            'username',
            'UserName',
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Username can\'t be empty.";
              }
              return null;
            },
            (onSavedVal) {
              username = onSavedVal;
            },
            prefixIcon: const Icon(Icons.person),
            showPrefixIcon: true,
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              'email',
              'Email',
              (onValidateVal) {
                confirmEmail = onValidateVal;
                if (onValidateVal.isEmpty) {
                  return "Email can\'t be empty.";
                }
                return null;
              },
              (onSavedVal) {
                email = onSavedVal;
              },
              prefixIcon: const Icon(Icons.mail),
              showPrefixIcon: true,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FormHelper.inputFieldWidget(
              context,
              'email',
              'Confirm Email',
              (onValidateVal) {
                if (onValidateVal != confirmEmail) {
                  return "Emails must match";
                }
                return null;
              },
              (onSavedVal) {
                email = onSavedVal;
              },
              prefixIcon: const Icon(Icons.mail),
              showPrefixIcon: true,
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
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
                  SendEmailRequestModel model = SendEmailRequestModel(
                    user: username!,
                    email: email!,
                  );
                  APIService.sendEmail(model).then((response) {
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    if (response.newPassword != "") {
                      newPass = response.newPassword;
                      ResetPasswordRequestModel model =
                          ResetPasswordRequestModel(
                        user: username!,
                        password: response.password,
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
                            "Email has been sent",
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
                            "Email or User Not Found",
                            "OK",
                            () {
                              Navigator.pop(context);
                            },
                          );
                        }
                      });
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "ERROR!!!",
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
