import 'dart:convert';
import 'package:budgetapps/Screens/dashboard.dart';
import 'package:budgetapps/Screens/login_page.dart';
import 'package:budgetapps/Screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as https;
import 'package:email_validator/email_validator.dart';

import 'cred_screat.dart';


class Auth {
  static const Ipurl = "35.174.155.153";
  // Create storage

//for getting username from the flutter secreat cred
//   Future init(){
//   //final name = await Cred_store.getUsername() ?? "";
//   }
  static  String LoggedInUser = '';
  static Future CurrentUser() async{
   LoggedInUser = await Cred_store.getUserName() ?? '';
    return LoggedInUser;
  }
  String validateEmail (String Email){

      if(Email.isEmpty){
         return  "Email cannot be empty";
      }
      else if(!EmailValidator.validate(Email)){
        return "invalid email";
      }
      else{
        return "";
      }
  }
  Future signin(BuildContext context,String email,String password,) async {
    var url = Uri.http(Ipurl, '/flutter/signup.php');
    print(url);
    var response = await https.post(url, body: {
      "username":email,
      "password":password
    });
    var data = response.body;
    print(data);
    if (data.toString() == "Success") {
      Fluttertoast.showToast(
          msg: "signin successful",
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
  Future Login(BuildContext context,String email, password) async {
    var url = Uri.http(Ipurl, '/flutter/login.php');
    print(url);
    var response = await https.post(url,
        body: {
          "username":email,
          "password":password
        }
    );
    var data = response.body;
    print(data);
    if(data.toString() == "valid"){
      await Cred_store.setUserName(email);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Dashbord(),
      )
      );
    }
    else if(data.toString() == "invalid"){
      Fluttertoast.showToast(
          msg: 'Invalid credentials',
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

  static Future Logout(BuildContext context) async{
    print("loggin out..");
    var abc = await Cred_store.getUserName() ;
    await Cred_store.LogoutUser();
    if(abc == "") {
      print("logout out successfully");
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
       return LoginPage();
      }));
    }
    else{
      print(abc);
    }
  }
}
