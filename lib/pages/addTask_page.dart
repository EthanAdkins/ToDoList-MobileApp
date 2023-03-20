import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class addTaskPage extends StatefulWidget {
  const addTaskPage({super.key});

  @override
  State<addTaskPage> createState() => _addTaskPageState();
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Personal"), value: "Personal"),
    DropdownMenuItem(child: Text("School"), value: "School"),
    DropdownMenuItem(child: Text("Work"), value: "Work"),
  ];
  return menuItems;
}

class _addTaskPageState extends State<addTaskPage> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? task;
  List<String> possibleLists = <String>['Personal', 'School', 'Work'];
  String curList = "Personal";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: HexColor("#A5B2DF"),
            body: ProgressHUD(
              child: Form(
                key: globalFormKey,
                child: _registerUI(context),
              ),
              inAsyncCall: isAPIcallProcess,
              opacity: 0.3,
              key: UniqueKey(),
            )));
  }

  Widget _registerUI(BuildContext context) {
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
            child: Text('Add New Task:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white,
                )),
          ),
          FormHelper.inputFieldWidget(
            context,
            'task',
            'Task Name',
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
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 20),
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
                print(curList);
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
}
