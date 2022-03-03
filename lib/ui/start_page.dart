import 'package:final_project/ui/home_page.dart';
import 'package:final_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Startpage extends StatefulWidget {
  const Startpage({Key? key}) : super(key: key);
  static const String routeName = "/start";

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Stack will stack image and button
      home: Stack(children: [
        // Stretching image all over the screen
        Image.asset(
          'image/startPage.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
        // Centering the button
        Center(
          // Column is used to align the button at right position
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 320,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.pinkAccent.shade100,
                  minimumSize: const Size(130, 41),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                onPressed: () {
                  Constants.prefs?.setBool("loggedIn", true);
                  Navigator.pushReplacementNamed(context, HomePage.routeName);
                },
                child: const Text(
                  "Let's go!",
                  style: TextStyle(fontSize: 20),
                )),
          ]),
        )
      ]),
    );
  }
}
