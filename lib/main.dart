import 'package:flutter/material.dart';
import 'package:fridge_app/pages/login_page.dart';
import 'package:fridge_app/pages/register_page.dart';
import 'package:fridge_app/pages/personal_page.dart';
import 'package:fridge_app/pages/school_page.dart';
import 'package:fridge_app/pages/work_page.dart';
import 'package:fridge_app/pages/addTask_page.dart';
import 'package:fridge_app/services/api_service.dart';
import 'package:fridge_app/services/shared_service.dart';

Widget _defaultHome = const LoginPage();
void main() async {
  /*
  WidgetsFlutterBinding.ensureInitialized();

  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = const PersonalPage();
  }*/

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => _defaultHome,
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/personal': (context) => const PersonalPage(),
        '/work': (context) => const WorkPage(),
        '/school': (context) => const SchoolPage(),
        '/addTask': (context) => const addTaskPage(),
      },
    );
  }
}

class DrawerCodeOnly extends StatelessWidget {
  const DrawerCodeOnly({super.key});

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      backgroundColor: Color(0xfff2f1e8),
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xffa5b2df),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/pfp.png"),
                ),
                SizedBox(height: 7),
                Text(GlobalData.firstName! + " " + GlobalData.lastName!,
                    style: TextStyle(fontSize: 18, color: Colors.white))
              ],
            ),
          ),
          ListTile(
            title: const Text('Personal'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              // We are already here so do nothing
              Navigator.pop(context);
              Navigator.pushNamed(context, "/personal");
            },
          ),
          ListTile(
            title: const Text('Work'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer

              Navigator.pop(context);
              Navigator.pushNamed(context, "/work");
            },
          ),
          ListTile(
            title: const Text('School'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.pushNamed(context, "/school");
            },
          ),
          const Divider(color: Colors.black54),
          ListTile(
            title: const Text('LOG OUT'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer

              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
