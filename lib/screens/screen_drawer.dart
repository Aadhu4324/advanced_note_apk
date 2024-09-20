import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_second/screens/screen_login.dart';
import 'package:firebase_second/services/user_services.dart';
import 'package:firebase_second/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenDrawer extends StatefulWidget {
  const ScreenDrawer({super.key});

  @override
  State<ScreenDrawer> createState() => _ScreenDrawerState();
}

class _ScreenDrawerState extends State<ScreenDrawer> {
  UserServices _services = UserServices();
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: FutureBuilder(
      future: _services.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            return Column(
              children: [
                UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      child: MyText(
                        data: snapshot.data!.name![0].toUpperCase(),
                        textSize: 40,
                        textWeight: FontWeight.bold,
                      ),
                    ),
                    accountName: Text(snapshot.data!.name.toString()),
                    accountEmail: Text(snapshot.data!.email.toString())),
                const SizedBox(
                  height: 50,
                ),
                Card(
                  elevation: 10,
                  child: ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      final _shrp = await SharedPreferences.getInstance();
                      _shrp.clear();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => ScreenLogin(),
                        ),
                        (route) => false,
                      );
                    },
                    title: MyText(data: "SignOut", textSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
               
              ],
            );
          } else {
            return Center(
              child: Text("Error"),
            );
          }
        }
      },
    ));
  }
}
