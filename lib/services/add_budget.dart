import 'package:budgetapps/pages/create_budge_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as https;
import 'auth.dart';
import 'cred_screat.dart';

class AddBudget{
  static String Iurl = Auth.Ipurl;
  static Future add(String budgetname,String budgetprice,String catno) async{
    var email = await Cred_store.getUserName() ;
    String a = DateFormat.yMEd().add_jm().format(DateTime.now());
    final b = a.split(" ");
    print(b[2]);//time
    print(b[3]); // time line am/pm
    final c = a.split("/");
    final day = c[0];
    final days = day.split(",");
    print(days[1]);//day like 13,14
    print(days[0]);//week name
    print(c[1]); //month
    var url = Uri.http(Iurl, '/flutter/addbud.php');
    print(url);
    var response = await https.post(url, body: {
      "budgetName":budgetname,
      "budgetPrice":budgetprice,
      "catno": catno,
      "date": a,
      "time": b[2],
      "timeline":b[3],
      "day": c[1],
      "week": days[0],
      "month": days[1],
      "email": email,

    });
    var data = response.body;
    print(data);
    if (data.toString() == "Success") {
      Fluttertoast.showToast(
          msg: "Saved successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT);

    } else if(data.toString() == "Exists"){
      Fluttertoast.showToast(
          msg: 'User already Exists',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
    else{
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }
}