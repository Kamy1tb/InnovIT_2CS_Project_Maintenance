class User{
  int id;
  String name;
  String email;
  String phone;
  String image;
  String password;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.password
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["nom"]+json["prenom"],
        email: json["mail"],
        phone: json["tel"],
        image:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNiMV_OdBzb4xVwekrBop0crXIP3Rszoa2d363aMNi_iRUrsGiYUcnV2D79bXKx_G56pY&usqp=CAU",
        password: json["mdp"]);
  }
}