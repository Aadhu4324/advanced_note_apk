import 'package:firebase_second/model/note_model.dart';
import 'package:firebase_second/screens/screen_home.dart';
import 'package:firebase_second/services/task_sevices.dart';
import 'package:firebase_second/widgets/form_field.dart';
import 'package:firebase_second/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NoteAddPage extends StatefulWidget {
  NoteAddPage({super.key, required this.userId, this.note});
  final String? userId;
  final NoteModel? note;

  @override
  State<NoteAddPage> createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  TextEditingController _tittleController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  final _adadKey = GlobalKey<FormState>();
  bool check = true;

  checkupdateorcreate() {
    if (widget.note != null) {
      setState(() {
        check = false;
      });
      _tittleController.text = widget.note!.tittle.toString();
      _descriptionController.text = widget.note!.description.toString();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkupdateorcreate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _adadKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomFormField(
                  expandOrNot: false,
                  controller: _tittleController,
                  error: "Field is Mandatory",
                  hintText: "NoteTittle"),
              const SizedBox(
                height: 20,
              ),
              CustomFormField(
                  expandOrNot: true,
                  controller: _descriptionController,
                  error: "Field is Mandatory",
                  hintText: "NoteDescription"),
              const SizedBox(
                height: 40,
              ),
              check
                  ? InkWell(
                      onTap: () async {
                        if (_adadKey.currentState!.validate()) {
                          final uid = Uuid().v1();
                          NoteModel note = NoteModel(
                              tittle: _tittleController.text,
                              description: _descriptionController.text,
                              createdAt: DateTime.now(),
                              id: uid,
                              currentUserId: widget.userId,
                              read: false);
                          NoteServices _servies = NoteServices();
                          final data = await _servies.createNote(note);
                          if (data != null) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                          child: MyText(
                            data: "Create",
                            textSize: 20,
                            textColor: Colors.white,
                            textWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () async {
                        if (_adadKey.currentState!.validate()) {
                          NoteModel note = NoteModel(
                              tittle: _tittleController.text,
                              description: _descriptionController.text,
                              createdAt: DateTime.now(),
                              id: widget.note!.id,
                              currentUserId: widget.note!.currentUserId,
                              read: false);
                          NoteServices _servies = NoteServices();
                          _servies.updateNote(note);
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ScreenHome(),),(route) => false,);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                          child: MyText(
                            data: "Update",
                            textSize: 20,
                            textColor: Colors.white,
                            textWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
