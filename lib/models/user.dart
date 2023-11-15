class User {
  int? id;
  String? name;
  String? email;
  String? profilePicture;

  User({this.id, this.name, this.email, this.profilePicture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['firstName'],
      email: json['email'],
      profilePicture: json['image'],
    );
  }
}
