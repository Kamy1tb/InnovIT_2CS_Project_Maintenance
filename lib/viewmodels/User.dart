class User{
  int id;
  String name;
  String email;
  String phone;
  String image;
  String location;
  String password;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.location,
    required this.password
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["nom"]+json["prenom"],
        email: json["mail"],
        phone: json["tel"],
        image: json[""],
        location: json[""],
        password: json["mdp"]);
  }
}