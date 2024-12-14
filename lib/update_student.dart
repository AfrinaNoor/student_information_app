import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_registration_app_firebase/model/student.dart';
import 'package:student_registration_app_firebase/service/student_service.dart';

class UpdateNotes extends StatefulWidget {
  final Note? note;

  const UpdateNotes({super.key, this.note});

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  // Declare controllers
  var nameController = TextEditingController();
  var studentidController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var locationController = TextEditingController();

  // Declare form key variable
  final GlobalKey<FormState> noteFormKey = GlobalKey();

  // Declare services
  final NoteService noteService = NoteService();

  // Update note function
  Future updateNote() async {
    final newNote = Note(
      id: widget.note!.id,
      name: nameController.text,
      studentid: studentidController.text,
      phone: phoneController.text,
      email: emailController.text,
      location: locationController.text,
    );

    await noteService.updateNote(newNote);
    Get.back();
  }

  @override
  void initState() {
    super.initState();

    // Initialize the text controllers with existing note data
    nameController.text = widget.note!.name.toString();
    studentidController.text = widget.note!.studentid.toString();
    phoneController.text = widget.note!.phone.toString();
    emailController.text = widget.note!.email.toString();
    locationController.text = widget.note!.location.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.green[700],
        title: const Text(
          "Update Student",
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
            colors: [Colors.green[100]!, Colors.green[300]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: noteFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Edit Student Details",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: nameController,
                  label: "Name",
                  hint: "Enter Name",
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: studentidController,
                  label: "Student ID",
                  hint: "Enter ID",
                  icon: Icons.numbers,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the student ID";
                    } else if (value.length > 7) {
                      return "Student ID must be no more than 7 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: phoneController,
                  label: "Phone",
                  hint: "Enter Phone Number",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the phone number";
                    } else if (!RegExp(r'^\d{11}$').hasMatch(value)) {
                      return "Phone number must be exactly 11 digits.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: emailController,
                  label: "Email",
                  hint: "example@email.com",
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the email";
                    } else if (!RegExp(
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return "Enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: locationController,
                  label: "Location",
                  hint: "Enter Location",
                  icon: Icons.location_on,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the location";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      if (noteFormKey.currentState!.validate()) {
                        noteFormKey.currentState!.save();
                        updateNote();
                      }
                    },
                    child: const Text(
                      "Update Student",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.green),
        filled: true,
        fillColor: Colors.green[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green[300]!),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      validator: validator,
    );
  }
}
