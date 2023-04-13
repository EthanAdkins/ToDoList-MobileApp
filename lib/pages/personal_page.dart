import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C'
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xfff2f1e8),
      drawer: new DrawerCodeOnly(),
      appBar: new AppBar(
          title: new Text("Personal Page"),
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
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 70,
                      color: Color(0xff9736c5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                                child: Text(
                              'Entry ${entries[index]}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 115, 41, 150),
                                    textStyle: TextStyle(fontSize: 15),
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (await confirm(
                                      context,
                                      content: const Text(
                                          'Would you like to be reminded when your task is due?'),
                                    )) {
                                      DateTime dateTimeTEST = dateFormat
                                          .parse("2023-04-11 01:07:00");
                                      debugPrint('Notification Scheduled for ');
                                      NotificationService()
                                          .scheduleNotification(
                                              title: 'Wow',
                                              body: 'That worked',
                                              scheduledNotificationDateTime:
                                                  dateTimeTEST);
                                    } else {
                                      return print("not confirm");
                                    }
                                  },
                                  child: const Icon(Icons.access_time_outlined,
                                      size: 20)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              width: 55,
                              height: 40,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 115, 41, 150),
                                    textStyle: TextStyle(fontSize: 15),
                                  ),
                                  onPressed: () async {
                                    if (await confirm(
                                      context,
                                      content:
                                          const Text('Confirm delete task?'),
                                      textOK: const Text('Delete'),
                                    )) {
                                      return print("confirm");
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
            ),
          ],
        ),
      ),
    );
  }
}
