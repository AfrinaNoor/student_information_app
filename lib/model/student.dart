class Note {
  String? id;
  String name;
  String studentid;
  String phone;
  String email;
  String location;


  Note({
    this.id,
    required this.name,
    required this.studentid,
    required this.phone,
    required this.email,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'studentid': studentid,
      'phone': phone,
      'email': email,
      'location': location,
    };
  }

  static Note fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      name: json['name'],
      studentid: json['studentid'],
      phone: json['phone'],
      email: json['email'],
      location: json['location'],
    );
  }
}