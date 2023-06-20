class User{
  int id;
  String nom;
  String prenom;
  String? email;
  String phone;
  String image;
  String password;
  String token;
  String entreprise;
  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.phone,
    required this.image,
    required this.password,
    required this.token,
    required this.entreprise
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        nom: json["nom"],
        prenom: json["prenom"],
        email: json["mail"],
        phone: json["tel"],
        image:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSNiMV_OdBzb4xVwekrBop0crXIP3Rszoa2d363aMNi_iRUrsGiYUcnV2D79bXKx_G56pY&usqp=CAU",
        password: json["mdp"],
        token:"",
        entreprise: json["entreprise"]
    );
  }
}