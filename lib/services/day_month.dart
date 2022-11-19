import 'dart:convert';

import 'package:budgetapps/model/day.dart';
import 'package:budgetapps/services/auth.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as https;

import 'cred_screat.dart';
class DayFetch
{

  List days = [];
  static const Ipurl = Auth.Ipurl;
    Future<List<Welcome>> Fetchday() async{
      var email = await Cred_store.getUserName() ;
    String a = DateFormat.yMEd().add_jm().format(DateTime.now());
    final b = a.split(" ");
    // print(b[2]);//time
    // print(b[3]); // time line am/pm
    final c = a.split("/");
    final day = c[0];
    final dys = day.split(",");
    // print(dys[1]);//day like 13,14
    // print(dys[0]);//week name
    print(c[1]); //month
    var url = Uri.http(Ipurl, '/flutter/fetchdate.php');
    print(url);
    String month = (int.parse(c[1]) -1).toString();
    final response = await https.post(url, body: {
      "email" : email,
      "currentmonth": month,
    });
    print(response.body);
    return welcomeFromJson(response.body);
     // return json.decode(response.body);

  }
}