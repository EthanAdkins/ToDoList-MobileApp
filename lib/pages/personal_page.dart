import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fridge_app/models/delTask_request_model.dart';
import 'package:fridge_app/models/searchTask_request_model.dart';
import 'package:fridge_app/pages/addTask_page.dart';
import 'package:fridge_app/pages/work_page.dart';
import 'package:fridge_app/services/api_service.dart';
import 'package:fridge_app/services/notifi_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:fridge_app/main.dart';
import 'dart:convert';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:intl/intl.dart';
import 'package:fridge_app/config.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  List<dynamic> entries = [];
  List<dynamic> changeableList = [];

  @override
  void initState() {
    setState(() {
      isAPIcallProcess = true;
    });
    SearchTaskRequestModel model = SearchTaskRequestModel(
      user: GlobalData.userName,
      search: "Personal",
    );
    print(GlobalData.userName);

    APIService.searchTask(model).then((response) {
      setState(() {
        isAPIcallProcess = false;
      });
      if (response.error == '' && response.results != null) {
        entries = response.results;
        changeableList = entries;
      } else {
        print("error");
      }
    });
  }

  int count = 5;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String searchValue = '';

  bool isAPIcallProcess = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: HexColor("#A5B2DF"),
            body: ProgressHUD(
              child: Form(
                key: globalFormKey,
                child: _personalUI(context),
              ),
              inAsyncCall: isAPIcallProcess,
              opacity: 0.3,
              key: UniqueKey(),
            )));
  }

  Widget _personalUI(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff2f1e8),
      drawer: DrawerCodeOnly(),
      appBar: AppBar(
          title: Text("Personal Page"),
          backgroundColor: Color(0xffa5b2df),
          iconTheme: IconThemeData(color: Color(0xff5a4fcf))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/ToDoIcon.png",
                      width: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff9736c5),
                  textStyle: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/addTask");
                },
                child: const Text('Create New Task'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: FormHelper.inputFieldWidget(
                      context,
                      'search',
                      'Search',
                      (onValidateVal) {
                        return null;
                      },
                      (onSavedVal) {
                        searchValue = onSavedVal;
                      },
                      paddingRight: 0,
                      prefixIcon: const Icon(Icons.search),
                      showPrefixIcon: true,
                      borderFocusColor: Color(0xff9736c5),
                      prefixIconColor: Color(0xff9736c5),
                      borderColor: Color(0xff9736c5),
                      textColor: Color(0xff9736c5),
                      hintColor: Color(0xff9736c5).withOpacity(0.7),
                      borderRadius: 10,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: FormHelper.submitButton(
                      "SEARCH",
                      () {
                        if (validateAndSave()) {
                          List<dynamic> matchQuery = entries
                              .where((row) => row[0]
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase()))
                              .toList();

                          changeableList = matchQuery;
                          setState(() {
                            count++;
                          });
                          PersonalPage(key: ValueKey(count));
                        } else {
                          print('huh');
                        }
                      },
                      btnColor: HexColor("#9736C5"),
                      borderColor: Colors.white,
                      txtColor: Colors.white,
                      borderRadius: 10,
                      width: 80,
                    ),
                  ),
                ],
              ),
            ),
            _displayUI(context)
          ],
        ),
      ),
    );
  }

  Widget _displayUI(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(240, 245, 249, 255),
        border: Border.all(
          width: 1,
          color: Color.fromARGB(255, 71, 71, 71),
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      /*child: LimitedBox(
                maxHeight: 300,
                maxWidth: 355,
                child: Column(
                  children: [],
                ),
              ),*/

      /*
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 50, minWidth: 355),
                child: Column(
                  children: [
                    
                  ],
              */

      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 50, minWidth: 355),
        child: ListView.separated(
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          itemCount: changeableList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 70,
              color: Color(0xff9736c5),
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                        child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 3,
                            left: 15,
                          ),
                          child: AutoSizeText(
                            '${changeableList[index][0]}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            maxLines: 3,
                            minFontSize: 8,
                            maxFontSize: 30,
                          ),
                        ),
                        AutoSizeText(
                          'Due Date: ${changeableList[index][1]}',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 115, 41, 150),
                            textStyle: TextStyle(fontSize: 15),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            Navigator.pushNamed(context, "/editTask",
                                arguments: {
                                  'Argument': changeableList[index],
                                  'Category': "Personal"
                                });
                          },
                          child: const Icon(Icons.edit, size: 20)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 115, 41, 150),
                            textStyle: TextStyle(fontSize: 15),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () async {
                            // Check here if the date is in the future. Message if now
                            //if (date > or whatever DateTime now = new DateTime.now(); )
                            if (await confirm(
                              context,
                              content: const Text(
                                  'Would you like to be reminded when your task is due?'),
                            )) {
                              DateTime dateTimeTEST =
                                  dateFormat.parse(changeableList[index][1]);

                              NotificationService().scheduleNotification(
                                  title: 'The Fridge List',
                                  body:
                                      'Your task: "${changeableList[index][0]}" is due!',
                                  scheduledNotificationDateTime: dateTimeTEST);
                            } else {
                              return print("not confirm");
                            }
                          },
                          child:
                              const Icon(Icons.access_time_outlined, size: 20)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: SizedBox(
                      width: 55,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 115, 41, 150),
                            textStyle: TextStyle(fontSize: 15),
                          ),
                          onPressed: () async {
                            if (await confirm(
                              context,
                              content: const Text('Confirm delete task?'),
                              textOK: const Text('Delete'),
                            )) {
                              if (validateAndSave()) {
                                setState(() {
                                  isAPIcallProcess = true;
                                });

                                DelTaskRequestModel model = DelTaskRequestModel(
                                  taskContent: entries[index][0],
                                  time: entries[index][1],
                                  category: "Personal",
                                  user: GlobalData.userName!,
                                );
                                APIService.delTask(model).then((response) {
                                  setState(() {
                                    isAPIcallProcess = false;
                                  });
                                  if (response.error == "") {
                                    FormHelper.showSimpleAlertDialog(
                                      context,
                                      Config.appName,
                                      "Task deleted Successfully!",
                                      "OK",
                                      () {
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/personal',
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
                              return;
                            }
                            return print("not confirm");
                          },
                          child: const Icon(Icons.delete, size: 20)),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
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
