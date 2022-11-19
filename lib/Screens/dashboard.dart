import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:budgetapps/Theme/theme.dart';
import 'package:budgetapps/pages/budget_page.dart';
import 'package:budgetapps/pages/create_budge_page.dart';
import 'package:budgetapps/pages/daily_page.dart';
import 'package:budgetapps/pages/profile_page.dart';
import 'package:budgetapps/pages/stats_page.dart';
import 'package:budgetapps/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
class Dashbord extends StatefulWidget {
  const Dashbord({Key? key}) : super(key: key);

  @override
  State<Dashbord> createState() => _DashbordState();
}

class _DashbordState extends State<Dashbord> {
  int pageIndex = 1;
  @override

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:  getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            SetTabs(4);
          },
          child: Icon(Icons.add,size: 25, ),
          backgroundColor: primary,

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked  ,
      ),
    );
  }
  Widget getBody(){
    return IndexedStack(
      index: pageIndex,
      children: [
        DailyPage(),
        StatsPage(),

        BudgetPage(),
        ProfilePage(),
        CreatBudgetPage(),
      ],
    );
  }
  Widget getFooter(){
    List<IconData> iconitems = [
      Ionicons.calendar,
      Ionicons.alarm_outline,
      Ionicons.wallet,
      Ionicons.person
    ];
    return AnimatedBottomNavigationBar(icons: iconitems, activeIndex: pageIndex,
        activeColor: primary,
        splashColor: secondary,
        inactiveColor: Colors.black.withOpacity(0.5),
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        leftCornerRadius: 10,
        rightCornerRadius: 10,
        iconSize: 25,
        onTap: (index){
      SetTabs(index);
    });
  }
  SetTabs(index){
    setState(() {
      pageIndex = index;
    });
  }
}
