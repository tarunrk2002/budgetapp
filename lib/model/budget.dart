import 'dart:convert';

List<Budget> budgetFromJson(String str) => List<Budget>.from(json.decode(str).map((x) => Budget.fromJson(x)));

String budgetToJson(List<Budget> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Budget {
  Budget({
    required this.catId,
    required this.time,
    required this.timeline,
    required this.budgetName,
    required this.budgetPrice,
  });

  String catId;
  String time;
  String timeline;
  String budgetName;
  String budgetPrice;

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
    catId: json["catId"],
    time: json["time"],
    timeline: json["timeline"],
    budgetName: json["budgetName"],
    budgetPrice: json["budgetPrice"],
  );

  Map<String, dynamic> toJson() => {
    "catId": catId,
    "time": time,
    "timeline": timeline,
    "budgetName": budgetName,
    "budgetPrice": budgetPrice,
  };
}