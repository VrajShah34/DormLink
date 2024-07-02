import 'dart:convert';

class Ticket {
  String id;
  String enrollmentNo;
  String name;
  String title;
  String description;
  String roomNo;
  int status;
  int v;
  String category;

  Ticket({
    required this.id,
    required this.enrollmentNo,
    required this.name,
    required this.title,
    required this.description,
    required this.roomNo,
    required this.status,
    required this.v,
    required this.category,
  });

  factory Ticket.fromRawJson(String str) => Ticket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["_id"],
        enrollmentNo: json["enrollmentNo"],
        name: json["name"],
        title: json["title"],
        description: json["description"],
        roomNo: json["roomNo"],
        status: json["status"],
        v: json["__v"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "enrollmentNo": enrollmentNo,
        "name": name,
        "title": title,
        "description": description,
        "roomNo": roomNo,
        "status": status,
        "__v": v,
        "category": category,
      };
}
