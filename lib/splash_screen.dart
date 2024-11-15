import "dart:async";

import "package:euphoria/DoctorsModule/Views/doctormainpage.dart";
import "package:euphoria/mainpage.dart";
import "package:euphoria/questionPage.dart";
import "package:euphoria/userselectionpage.dart";
import "package:flutter/material.dart";
import "package:hive/hive.dart";
//import "package:google_fonts/google_fonts.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3;
  late Box box1;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    return Timer(duration, checkFirstSeen);
  }

  Future checkFirstSeen() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const UserSelectionPage(),
    ));
    box1= await Hive.openBox("logindata");
    bool introSeen = box1.get("isLogged",defaultValue: false);
    bool user =box1.get("userlogin",defaultValue: false);
    Navigator.pop(context);
    if (introSeen) {
      if(user)
      {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  DoctorsMainPage(),));
      }
      else
      {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const  QuestionPage(),));
      }

    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserSelectionPage(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: const Color.fromRGBO(155, 81, 98, 1),
      child: const Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.monitor_heart,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text("Euphoria",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }
}
