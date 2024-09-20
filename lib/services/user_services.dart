import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_second/model/usermodel.dart';

class UserServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _store = FirebaseFirestore.instance.collection("users");
  
 

  Future<void> registerUser(UserModel user) async {
    final userData = await _auth.createUserWithEmailAndPassword(
        email: user.email.toString(), password: user.passWord.toString());

    _store.doc(userData.user!.uid).set({
      "name": user.name,
      "email": userData.user!.email,
      "phoneNumber": user.phoneNumber,
      "uid": userData.user!.uid,
      "createdAt": DateTime.now()
    });
  }


  Future<UserCredential?> login(UserModel user) async {
    UserCredential data = await _auth.signInWithEmailAndPassword(
        email: user.email.toString(), password: user.passWord.toString());
    return data;
  }

 

  Future<UserModel> getCurrentUser() async {
    String? email =FirebaseAuth.instance.currentUser!.email;
    final snap= await  _store.get();
    final users = await snap.docs.map(
      (e) {
        
        return UserModel.fromJson(e);
      },
    ).toList();
    final user = users.singleWhere(
      (element) => element.email == email,
    );

    return user;
  }
  
}
