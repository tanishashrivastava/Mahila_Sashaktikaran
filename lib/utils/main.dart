import 'package:final_project/ui/home_page.dart';
import 'package:final_project/ui/start_page.dart';
import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Constants.prefs?.getBool("loggedIn") == true
            ? const HomePage()
            : const Startpage(),
        routes: {
          Startpage.routeName: (context) => const Startpage(),
          HomePage.routeName: (context) => const HomePage(),
        });
  }
}
