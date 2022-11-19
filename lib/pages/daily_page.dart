import 'package:budgetapps/Theme/theme.dart';
import 'package:budgetapps/json/daily_json.dart';
import 'package:budgetapps/json/day_month.dart';
import 'package:budgetapps/model/budget.dart';
import 'package:budgetapps/model/day.dart';
import 'package:budgetapps/pages/budget_page.dart';
import 'package:budgetapps/services/FetchbudgetList.dart';
import 'package:budgetapps/services/auth.dart';
import 'package:budgetapps/services/day_month.dart';
import 'package:flutter/material.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  int activeDay = -1;
  int currentdate = 0;
  int total = 0;
  bool _load = false;
  @override
  void initState() {
    // TODO: implement initState
    DayFetch().Fetchday();
    _load = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, right: 20, left: 20, bottom: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Daily Transaction",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            setState(() async {
                            await  DayFetch().Fetchday();
                             await FetchBudgetList().getBudgetList(currentdate.toString());
                            });

                          },
                          child: Icon(Icons.refresh, size: 24,),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 80,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: FutureBuilder(
                              future: DayFetch().Fetchday(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data =
                                      (snapshot.data as List<Welcome>).toList();
                                  // Welcome days = data;
                                  //       print(data);
                                  //       print(days.day);
                                  //       print(days.label);
                                  // return Text("hello world");
                                  return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        Welcome days = data[index];
                                        if (activeDay == -1)
                                          activeDay = data.length - 1;
                                        if(currentdate == 0)
                                          currentdate = int.parse(data[index].day);
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              activeDay = index;
                                              currentdate = int.parse(data[index].day);
                                              _load = true;
                                            });
                                          },
                                          child: Container(
                                            width: (MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    40) /
                                                7,
                                            height: 60,
                                            child: Column(
                                              children: [
                                                Text(
                                                  days.label,
                                                  style:
                                                      TextStyle(fontSize: 10),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      color: activeDay == index
                                                          ? primary
                                                          : Colors.transparent,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: activeDay ==
                                                                  index
                                                              ? primary
                                                              : black
                                                                  .withOpacity(
                                                                      0.1))),
                                                  child: Center(
                                                    child: Text(
                                                      days.day,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              activeDay == index
                                                                  ? white
                                                                  : black),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                }
                                return CircularProgressIndicator();
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(

              child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: FutureBuilder(future: FetchBudgetList().getBudgetList(currentdate.toString()),builder: (context,snapshot)
                      {
                          if (snapshot.hasData) {
                            var datas =
                            (snapshot.data as List<Budget>).toList();

                             return ListView.builder(itemCount: datas.length,
                                itemBuilder: (context, index) {
                                  Budget budget = datas[index];



                                  return Container(
                                    width: double.infinity,
                                    height: 80,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              width: (size.width - 40) * 0.7,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: grey.withOpacity(0.1),
                                                    ),
                                                    child: Center(
                                                      child: Image.asset(
                                                        daily[int.parse(budget.catId)]['icon'],
                                                        width: 30,
                                                        height: 30,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Container(
                                                    width: (size.width - 90) * 0.5,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
// daily[index]['name'],
                                                          budget.budgetName,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              color: black,
                                                              fontWeight: FontWeight
                                                                  .w500),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
// daily[index]['date'],
                                                          budget.time + budget.timeline  ,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: black
                                                                  .withOpacity(0.5),
                                                              fontWeight: FontWeight
                                                                  .w400),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: (size.width - 40) * 0.3,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .end,
                                                children: [
                                                  Text(
// daily[index]['price'],
                                                    budget.budgetPrice,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 15,
                                                        color: Colors.green),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 65, top: 8),
                                          child: Divider(
                                            thickness: 0.8,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          }

                        return Container(
                          width: 20,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      }
                      )
                    )
                  ]
              ),
            ),
          ),

        ],
      ),
    );
  }
}
