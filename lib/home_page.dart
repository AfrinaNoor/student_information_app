import 'package:student_registration_app_firebase/model/student.dart';
import 'package:student_registration_app_firebase/service/student_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'add_student.dart';
import 'update_student.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoteService noteService = NoteService();

  // Function to launch the phone call
  _makingPhoneCall(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber); // Create a tel URI
    if (await canLaunchUrl(url)) {
      await launchUrl(url); // Launch the phone dialer
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text(
          "Students Information App",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green[100]!,
              Colors.green[300]!,
              Colors.green[500]!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<List<Note>>(
          stream: noteService.getNotes(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final notes = snapshot.data!;

            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(15),
                      title: Text(
                        note.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(note.studentid, style: TextStyle(color: Colors.grey[700])),
                      leading: CircleAvatar(
                        backgroundColor: Colors.green[300],
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        Get.to(UpdateNotes(note: note));
                      },
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.call,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                _makingPhoneCall(note.phone);
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                noteService.deleteNote(note.id!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[700],
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.to(const AddNotes());
        },
      ),
    );
  }
}
