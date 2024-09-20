import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  String? tittle;
  String? description;
  String? id;
  DateTime? createdAt;
  bool? read;
  String? currentUserId;
  NoteModel(
      {this.tittle,
      this.description,
      this.id,
      this.createdAt,
      this.read,
      this.currentUserId});
  factory NoteModel.fromJson(DocumentSnapshot json) {
    return NoteModel(
        tittle: json["tittle"],
        description: json["description"],
        id: json["id"],
        createdAt: (json["createdAt"] as Timestamp).toDate(),
        read: json["read"],
        currentUserId: json["currentUserId"]);
  }
  Map<String, dynamic> toMap() {
    return {
      "tittle": tittle,
      "description": description,
      "id": id,
      "createdAt": createdAt,
      "read": read,
      "currentUserId": currentUserId
    };
  }
}
