import 'dart:async';

import 'package:budgetapps/services/auth.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'login_page.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  bool onload = false;
  Future check() async{
  final  String user = await Auth.CurrentUser();
  if(user.isEmpty)
    return true;
  return user;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      body:  FutureBuilder(
        future: check(),
        builder: (context,snapshot){
          if(snapshot.hasError) {
            throw "error";
          }
          if(!snapshot.hasData) return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Budget App",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 40),),
                SizedBox(height: 70,),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              ],
            ),
          );
          var userdata = snapshot.data;
          return userdata == true? LoginPage() : Dashbord();
        },
      )
    );
  }
}



