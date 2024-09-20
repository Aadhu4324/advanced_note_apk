import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_second/model/note_model.dart';
import 'package:firebase_second/screens/note%20_add_page.dart';
import 'package:firebase_second/screens/screen_drawer.dart';
import 'package:firebase_second/screens/screen_view.dart';
import 'package:firebase_second/services/task_sevices.dart';
import 'package:firebase_second/services/user_services.dart';
import 'package:firebase_second/widgets/custom_richtext.dart';
import 'package:firebase_second/widgets/custom_text.dart';
import 'package:firebase_second/widgets/my_text.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<NoteModel> notes = [];
  String? userID;
  UserServices _services = UserServices();
  NoteServices _noteservices = NoteServices();
  @override
  void initState() {
    super.initState();
    userID = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Color.fromARGB(215, 255, 255, 255),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 43, 178, 208),
          title: Text("HomePage"),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: _services.getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomRichtext(
                            data1: "Welcome  ",
                            data2: snapshot.data!.name.toString())
                      ],
                    );
                  } else {
                    return Text("Error");
                  }
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
                child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Notes").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircleAvatar(),
                  );
                } else {
                  if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                    var notedata = snapshot.data!.docs
                        .map(
                          (e) => NoteModel.fromJson(e),
                        )
                        .toList();

                    notes = notedata.where(
                      (element) {
                        return element.currentUserId == userID;
                      },
                    ).toList();
                    if (notes.isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 10,
                            child: ListTile(
                              trailing: IconButton(
                                  onPressed: () {
                                    _noteservices.deleteNote(notes[index].id.toString());
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ScreenView(note: notes[index],userId: userID.toString(),),
                                  )),
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              title: MyText(
                                data: notes[index].tittle.toString(),
                                textSize: 20,
                                textColor: Colors.black,
                                textWeight: FontWeight.w700,
                              ),
                              subtitle: MyText(
                                data: notes[index].description.toString(),
                                textSize: 18,
                              ),
                            ),
                          );
                        },
                        itemCount: notes.length,
                      );
                    } else {
                      return Center(
                          child: CustomText(data: "No Notes Available"));
                    }
                  } else {
                    return const Center(child: Text(" Error"));
                  }
                }
              },
            ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NoteAddPage(
                    userId: userID,
                  ),
                ));
          },
          child: const Icon(Icons.add),
        ),
        drawer: ScreenDrawer());
  }
}
