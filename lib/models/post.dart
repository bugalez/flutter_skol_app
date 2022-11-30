// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.id,
    required this.date,
    required this.sortie,
    required this.nbrSonneurs,
    required this.heure,
    required this.lieu,
    required this.description,
  });

  String id;
  DateTime date;
  String sortie;
  String nbrSonneurs;
  String heure;
  String lieu;
  String description;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    sortie: json["sortie"],
    nbrSonneurs: json["nbr_sonneurs"],
    heure: json["heure"],
    lieu: json["lieu"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "sortie": sortie,
    "nbr_sonneurs": nbrSonneurs,
    "heure": heure,
    "lieu": lieu,
    "description": description,
  };
}
