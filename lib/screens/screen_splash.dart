import 'package:firebase_second/screens/screen_home.dart';
import 'package:firebase_second/screens/screen_login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  checkLogin() async {
    final _shrp = await  SharedPreferences.getInstance();
    var data = _shrp.getBool("Login");
    print(data);
    if (data == null) {
      Future.delayed(
        Duration(seconds: 3),
        () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenLogin(),
              ));
        },
      );
    } else {
      Future.delayed(
        Duration(seconds: 5),
        () {
          
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenHome(),
              ));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 197, 142, 142),
        body: Center(
            child: Lottie.asset("images/Animation - 1726729461094.json",
                repeat: false)));
  }
}
