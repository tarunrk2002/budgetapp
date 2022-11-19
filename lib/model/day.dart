import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    required this.label,
    required this.day,
  });

  String label;
  String day;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    label: json["label"],
    day: json["day"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "day": day,
  };
}
