class Task
{
  int id;
  int idUser;
  String date;
  String heure;
  String entreprise;
  String message;
  String type;
  String etat;
  bool opened;
  Task({
    required this.id,
    required this.idUser,
    required this.date,
    required this.heure,
    required this.entreprise,
    required this.message,
    required this.type,
    required this.etat,
    required this.opened
  });
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json["id"],
        idUser: json["isUser"],
        date: json["name"],
        heure: json["description"],
        entreprise: json["idEntre"],
        message: json["message"],
        type: json["idType"],
        etat: json["isDone"],
        opened: json["opened"]);
  }
}