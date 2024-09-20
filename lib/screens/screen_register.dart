import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_second/model/usermodel.dart';
import 'package:firebase_second/screens/screen_login.dart';
import 'package:firebase_second/services/user_services.dart';
import 'package:firebase_second/widgets/form_field.dart';
import 'package:firebase_second/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({super.key});

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _registerKey = GlobalKey<FormState>();
  bool isLoading = false;
  UserModel _user = UserModel();
  UserServices _services = UserServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 177, 195, 210),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 177, 195, 210),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Stack(
          children: [
            Form(
              key: _registerKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const   Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.black54,
                  ),
                  CustomFormField(expandOrNot: false,
                      controller: _emailController,
                      error: "Please Enter Email",
                      hintText: "Email"),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    expandOrNot: false,
                      controller: _passWordController,
                      error: "Please Enter PassWord",
                      hintText: "PassWord"),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    expandOrNot: false,
                      controller: _phoneController,
                      error: "Please Enter PhoneNumber",
                      hintText: "PhoneNumber"),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    expandOrNot: false,
                      controller: _nameController,
                      error: "Please Enter Name",
                      hintText: "Name"),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    splashColor: Colors.grey,
                    onTap: () async {
                      if (_registerKey.currentState!.validate()) {
                        checkRegistration();
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
                        data: "Create",
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
                      MyText(data: "You  Have An Account?    ", textSize: 20),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: MyText(
                          data: "Login",
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

  checkRegistration() {
    setState(() {
      isLoading = true;
      Future.delayed(
        Duration(seconds: 3),
        () async {
          setState(() {
            isLoading = false;
          });
          try {
            _user = UserModel(
                name: _nameController.text,
                passWord: _passWordController.text,
                email: _emailController.text,
                phoneNumber: _phoneController.text);
            await _services.registerUser(_user).then(
                  (value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ScreenLogin()),
                    (route) => false,
                  ),
                );
          } on FirebaseAuthException catch (e) {
            List err=e.toString().split(']');
            print(err);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(err[1].toString())));
          }
        },
      );
    });
  }
}
