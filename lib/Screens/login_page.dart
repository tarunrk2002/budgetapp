import 'package:budgetapps/Screens/signup_page.dart';
import 'package:budgetapps/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Auth auth = Auth();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _Emailvalidator = false;
  bool _Passwordvalidator = false;
  @override
  Widget build(BuildContext context) {
    double width =
        MediaQuery.of(context).size.width; // to get the current width of screen
    double height = MediaQuery.of(context)
        .size
        .height; // to get the current height of screen

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height * 0.3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/loginimg.png"),
                      fit: BoxFit.cover)),
            ),
            Container(
              width: width,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 70),
                    ),
                    Text(
                      "sign into your account",
                      style: TextStyle(fontSize: 20, color: Colors.grey[500]),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              blurRadius:
                                  10, // assigning the width for the blur radius for the container
                              spreadRadius:
                                  7, //used to spread the blur over the radius
                              offset: Offset(1,
                                  1), // offset is used to say the distance between x and y
                              color: Colors.grey.withOpacity(
                                  0.2), // color property is used to set the color
                            )
                          ]),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value){
                          setState(() {
                            if(auth.validateEmail(emailController.text) == ""){
                              _Emailvalidator = false;
                            }
                          });
                        },
                        decoration: InputDecoration(
                            // input feild
                          errorText: _Emailvalidator? auth.validateEmail(emailController.text) : null,
                            hintText: "  Email",
                            enabledBorder: OutlineInputBorder(
                                // for enabled or current outline border
                                borderRadius: BorderRadius.circular(
                                    30), // for outline border radius
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.email,
                                color: Colors.orangeAccent,
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              blurRadius:
                                  10, // assigning the width for the blur radius for the container
                              spreadRadius:
                                  7, //used to spread the blur over the radius
                              offset: Offset(1,
                                  1), // offset is used to say the distance between x and y
                              color: Colors.grey.withOpacity(
                                  0.2), // color property is used to set the color
                            )
                          ]),
                      child: TextField(
                        controller: passwordController,
                        onChanged: (value){
                          setState(() {
                            _Passwordvalidator = false;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            // input feild
                            errorText: _Passwordvalidator ? "enter the password":null,
                            hintText: " Password",
                            enabledBorder: OutlineInputBorder(
                                // for enabled or current outline border
                                borderRadius: BorderRadius.circular(
                                    30), // for outline border radius
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                    color: Colors.white, width: 1.0)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Icon(
                                Icons.password_outlined,
                                color: Colors.orangeAccent,
                              ),
                            )),
                      ),
                    ),

                    SizedBox(
                      height: 70,
                    ),
                    Center(
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            if(auth.validateEmail(emailController.text) != ""){
                              _Emailvalidator = true;
                            }
                            else if (passwordController.text == "") {
                              _Passwordvalidator = true;
                            }
                            else {
                              auth.Login(context, emailController.text.trim(),
                                  passwordController.text.trim());
                            }
                          });
                        },
                        child: Container(
                          width: width * 0.5,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              image: DecorationImage(
                                  image: AssetImage("images/loginbtn.png"),
                                  fit: BoxFit.cover)),
                          child: Center(
                              child: Text(
                            "Sign in",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 36,
                                color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: height * .08,
            ),
            RichText(
              text: TextSpan(
                  text: "you don\'t have account? ",
                  style: TextStyle(color: Colors.grey[500], fontSize: 20),
                  children: [
                    TextSpan(
                        text: "Create",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(() => SignupPage())),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
