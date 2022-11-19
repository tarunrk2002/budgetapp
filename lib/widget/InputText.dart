import 'package:budgetapps/widget/textWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputTextFeild extends StatelessWidget {
  final String title;
  final String Hinttext;
  final TextEditingController? controller;
  final Widget? widget;
  const InputTextFeild({Key? key, required this.title, required this.Hinttext, this.controller, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(title: title, color: Colors.black, fontweight: 24,),
          Container(
            margin: EdgeInsets.only(top: 12),
              padding: EdgeInsets.only(top: 8,left: 8),
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(12)
              ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    readOnly: widget == null? false: true ,
                    autofocus: false,
                    autocorrect: true,
                    style: TextStyle(color: Colors.grey,fontSize: 20),
                    decoration: InputDecoration(
                        hintText: Hinttext,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,width: 0 ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white,width: 0 ),
                        )
                    ),
                  ),
                ),
                widget == null ? Container() : Container(child: widget,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
