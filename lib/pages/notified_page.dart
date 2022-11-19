import 'package:budgetapps/widget/textWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class NotifiedPage extends StatelessWidget {
  final String? label;
  NotifiedPage( {Key? key,required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("the label is");
    print(label);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
        ),
        title: TextWidget(title: label.toString().split("|")[0],color: Colors.black,fontweight: 20,),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[300]
          ),
          child: Center(child: TextWidget(title: label.toString().split("|")[1],color: Colors.black,fontweight: 20,)),
        ),
      ),
    );
  }
}
