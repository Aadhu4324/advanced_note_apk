import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? passWord;
  String? name;
  String? phoneNumber;
  String? uid;
  UserModel({this.email, this.name, this.passWord, this.phoneNumber, this.uid});
  factory UserModel.fromJson(DocumentSnapshot json) {
    print(json['phoneNumber']);
    return UserModel(
      
      email: json["email"],
      name: json["name"],
      phoneNumber: json["phoneNumber"] as String,
      uid: json["uid"],
    );
  }
}
