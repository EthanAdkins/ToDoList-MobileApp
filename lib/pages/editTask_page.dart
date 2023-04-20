import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fridge_app/config.dart';

import 'package:fridge_app/models/editTask_request_model.dart';
import 'package:fridge_app/services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:intl/intl.dart';

DateTime now = new DateTime.now();
DateTime dateTime =
    new DateTime(now.year, now.month, now.day, now.hour, now.minute);

DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm");

class editTaskPage extends StatefulWidget {
  const editTaskPage({super.key});

  @override
  State<editTaskPage> createState() => _editTaskPageState();
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Personal"), value: "Personal"),
    DropdownMenuItem(child: Text("School"), value: "School"),
    DropdownMenuItem(child: Text("Work"), value: "Work"),
  ];
  return menuItems;
}

class _editTaskPageState extends State<editTaskPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? task;
  List<String> possibleLists = <String>['Personal', 'School', 'Work'];

  String curList = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: HexColor("#A5B2DF"),
            body: ProgressHUD(
              child: Form(
                key: globalFormKey,
                child: _editTaskUI(context),
              ),
              inAsyncCall: isAPIcallProcess,
              opacity: 0.3,
              key: UniqueKey(),
            )));
  }

  Widget _editTaskUI(BuildContext context) {
    final argument = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    if (curList.isEmpty) {
      curList = argument['Category'];
    }
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              bottom: 30,
              top: 50,
            ),
            child: Text('Edit Task:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                )),
          ),
          FormHelper.inputFieldWidget(
            context,
            'task',
            'New Task Name',
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "Task can\'t be empty.";
              }
              return null;
            },
            (onSavedVal) {
              task = onSavedVal;
            },
            prefixIcon: const Icon(Icons.calendar_month),
            showPrefixIcon: true,
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 10,
            initialValue: argument['Argument'][0],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Wrap(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 13, right: 5),
                child: Text('Date:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white,
                    )),
              ),
              ElevatedButton(
                child:
                    Text('${dateTime.month}/${dateTime.day}/${dateTime.year}'),
                onPressed: () async {
                  final date = await pickDate();
                  if (date == null) {
                    return;
                  } // pressed "CANCEL"

                  final newDateTime = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    dateTime.hour,
                    dateTime.minute,
                  );

                  setState(() => dateTime = newDateTime); // pressed "OK"
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("#9736C5"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 13, right: 5, left: 10),
                child: Text('Time:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white,
                    )),
              ),
              ElevatedButton(
                child: Text('$hours:$minutes'),
                onPressed: () async {
                  final time = await pickTime();
                  if (time == null) return; // pressed "CANCEL"

                  final newDateTime = DateTime(
                    dateTime.year,
                    dateTime.month,
                    dateTime.day,
                    time.hour,
                    time.minute,
                  );

                  setState(() => dateTime = newDateTime); // Pressed "OK"
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HexColor("#9736C5"),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 20),
            child: DropdownButton(
                value: curList,
                dropdownColor: Color(0xffa5b2df),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    curList = newValue!;
                  });
                },
                items: dropdownItems),
          ),
          Center(
            child: FormHelper.submitButton(
              "CONFIRM",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isAPIcallProcess = true;
                  });
                  String stringDate = dateFormat.format(dateTime);
                  EditTaskRequestModel model = EditTaskRequestModel(
                    taskContent: argument['Argument'][0],
                    time: argument['Argument'][1],
                    category: argument['Category'],
                    user: GlobalData.userName!,
                    newTaskContent: task!,
                    newTime: stringDate,
                    newCategory: curList,
                  );
                  APIService.editTask(model).then((response) {
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    if (response.error == "") {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        Config.appName,
                        "Task Edited Successfully!",
                        "OK",
                        () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/${curList.toLowerCase()}',
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
              btnColor: HexColor("#9736C5"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: now,
        lastDate: DateTime(2100),
      );
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));

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
