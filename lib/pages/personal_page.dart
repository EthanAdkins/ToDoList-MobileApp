import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fridge_app/pages/work_page.dart';
import 'package:fridge_app/services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:fridge_app/main.dart';
import 'dart:convert';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xfff2f1e8),
      drawer: new DrawerCodeOnly(),
      appBar: new AppBar(
          title: new Text("Personal Page"),
          backgroundColor: Color(0xffa5b2df),
          iconTheme: IconThemeData(color: Color(0xff5a4fcf))),
      body: Column(
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
            padding: const EdgeInsets.only(bottom: 25),
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
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(240, 245, 249, 255),
              border: Border.all(
                width: 1,
                color: Color.fromARGB(255, 71, 71, 71),
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 50, minWidth: 355),
              child: Column(
                children: [],
              ),
            ),
          )
        ],
      ),
    );
  }
}
