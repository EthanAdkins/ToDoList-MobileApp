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

class WorkPage extends StatefulWidget {
  const WorkPage({super.key});

  @override
  State<WorkPage> createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xfff2f1e8),
      drawer: new DrawerCodeOnly(),
      appBar: new AppBar(
          title: new Text("Work Page"),
          backgroundColor: Color(0xffa5b2df),
          iconTheme: IconThemeData(color: Color(0xff5a4fcf))),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 6,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/ToDoIcon.png",
              width: 300,
              fit: BoxFit.contain,
            ),
          )
        ]),
      ),
    );
  }
}
