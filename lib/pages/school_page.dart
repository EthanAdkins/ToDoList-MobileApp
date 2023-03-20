import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fridge_app/pages/work_page.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:fridge_app/main.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({super.key});

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xfff2f1e8),
      drawer: new DrawerCodeOnly(),
      appBar: new AppBar(
          title: new Text("School Page"),
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
