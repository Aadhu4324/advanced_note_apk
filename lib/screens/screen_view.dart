import 'package:firebase_second/model/note_model.dart';
import 'package:firebase_second/screens/note%20_add_page.dart';
import 'package:firebase_second/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ScreenView extends StatelessWidget {
  final String userId;
  final NoteModel note;
  const ScreenView({super.key, required this.note, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            
            children: [
              Card(
                child: ListTile(
                  title: MyText(data: note.tittle.toString(), textSize: 20),
                  subtitle: MyText(data: note.createdAt.toString(), textSize: 20),
                
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(child: MyText(data: note.description.toString(), textSize: 18))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () =>
        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteAddPage(userId: userId,note: note,),))
      ,child: Icon(Icons.edit),),
    );
  }
}
