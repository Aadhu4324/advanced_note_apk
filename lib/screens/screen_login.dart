import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_second/model/usermodel.dart';
import 'package:firebase_second/screens/screen_home.dart';
import 'package:firebase_second/screens/screen_register.dart';
import 'package:firebase_second/services/user_services.dart';
import 'package:firebase_second/widgets/form_field.dart';
import 'package:firebase_second/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  bool isLoading = false;

  UserServices _services = UserServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 177, 195, 210),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Stack(
          children: [
            Form(
              key: _loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const   Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.black54,
                  ),
                  CustomFormField(
                      expandOrNot: false,
                      controller: _emailController,
                      error: "Please Enter Email",
                      hintText: "Email"),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomFormField(
                      expandOrNot: false,
                      controller: _passWordController,
                      error: "Please Enter PassWord",
                      hintText: "PassWord"),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    splashColor: Colors.grey,
                    onTap: () async {
                      if (_loginKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        Future.delayed(
                          Duration(seconds: 3),
                          () async {
                            setState(() {
                              isLoading = false;
                            });
                            try {
                              UserModel user = UserModel(
                                  email: _emailController.text,
                                  passWord: _passWordController.text);
                              final data = await _services.login(user);
                              if (data != null) {
                                var _shrp =
                                    await SharedPreferences.getInstance();
                                _shrp.setBool("Login", true);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScreenHome(),
                                    ));
                              }
                            } on FirebaseAuthException catch (e) {
                              List err = e.toString().split(']');

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(err[1].toString())));
                            }
                          },
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: MyText(
                        data: "Login",
                        textSize: 20,
                        textWeight: FontWeight.bold,
                        textColor: Colors.white,
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(data: "Don't Have An Account?    ", textSize: 20),
                      InkWell(
                        onTap: () => Navigator.push(context, customRoute()),
                        child: MyText(
                          data: "Create",
                          textSize: 30,
                          textWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: Visibility(
                  visible: isLoading,
                  child: const CircularProgressIndicator(),
                ))
          ],
        ),
      ),
    );
  }

  Route<Object?> customRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ScreenRegister(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var tween = Tween(begin: begin, end: end);
        var offset = animation.drive(tween);
        return SlideTransition(
          position: offset,
          child: child,
        );
      },
    );
  }
}
