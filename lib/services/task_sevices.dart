import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_second/model/note_model.dart';

class NoteServices {
  //create
  final CollectionReference _taskServices =
      FirebaseFirestore.instance.collection("Notes");
  String? userId = FirebaseAuth.instance.currentUser!.uid;

  Future<NoteModel?> createNote(NoteModel note) async {
    final noteMap = note.toMap();

    _taskServices.doc(note.id).set(noteMap);
    return note;
  }

  // Stream<List<NoteModel>> getAllUserNotes() {
  //   return _taskServices.snapshots().map(
  //     (event) {
  //       return event.docs.map(
  //         (e) {
  //           return NoteModel.fromJson(e);
  //         },
  //       ).toList();
  //     },
  //   );
  // }

  //update
  Future<void> updateNote(NoteModel note) async {
    final noteMap = note.toMap();
    print(noteMap);
    await _taskServices.doc(note.id).update(noteMap);
  }

  //delete
  Future<void> deleteNote(String id) async {
    await _taskServices.doc(id).delete();
  }
}
