class Task
{
  int id;
  int? idUser;
  String date;
  String heure;
  String entreprise;
  String? message;
  String type;
  String etat;
  bool opened;
  String? username;
  Task({
    required this.id,
    required this.idUser,
    required this.date,
    required this.heure,
    required this.entreprise,
    required this.message,
    required this.type,
    required this.etat,
    required this.opened,
    required this.username
  });
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json["id"],
        idUser: json["idUser"],
        date: json["date"],
        heure: json["time"],
        entreprise: json["idEntre"].toString(),
        message: json["message"],
        type: json["typetask"],
        etat: json["isDone"].toString(),
        opened: json["isOpen"],
        username: json["userAM"]
    );

  }
}