import 'package:budgetapps/Theme/theme.dart';
import 'package:budgetapps/widget/textWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final Function onTap;
  const ButtonWidget({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primary,
        ),
        child: Center(
          child: TextWidget(
            title: label,
            color: white,
            fontweight: 18,
          ),
        ),
      ),
    );
  }
}
