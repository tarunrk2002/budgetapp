import 'dart:convert';

List<Task> taskFromJson(String str) => List<Task>.from(json.decode(str).map((x) => Task.fromJson(x)));

String taskToJson(List<Task> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Task {
  Task({
    required this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.remaind,
    required this.repeat,
    required this.color,
    required this.isCompleted,
  });

   String title;
   String note;
   String date;
   String startTime;
   String endTime;
   String remaind;
   String repeat;
   String isCompleted;
   String id;
   String color;
  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json["title"],
    note: json["note"],
    date: json["date"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    remaind: json["remaind"],
    repeat: json["repeat"],
    color: json["color"],
    isCompleted: json["isCompleted"],
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "note": note,
    "date": date,
    "startTime": startTime,
    "endTime": endTime,
    "remaind": remaind,
    "repeat": repeat,
    "color": color,
    "isCompleted": isCompleted,
    "id": id,
  };
}