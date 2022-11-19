import 'package:budgetapps/Controller/TaskController.dart';
import 'package:budgetapps/Theme/theme.dart';
import 'package:budgetapps/model/Task.dart';
import 'package:budgetapps/pages/AddTask.dart';
import 'package:budgetapps/services/Notification_service.dart';
import 'package:budgetapps/services/add_taskService.dart';
import 'package:budgetapps/widget/TaskTile.dart';
import 'package:budgetapps/widget/button.dart';
import 'package:budgetapps/widget/textWidget.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:get/get.dart';
class StatsPage extends StatefulWidget {
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
  }
  final TaskController _taskController = Get.put(TaskController());
  DateTime _seletedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addAppbar(),
      body: Column(
        children: [
          _addTask(),
          _addDatePicer(),
          _showTask(),
        ],
      ),
    );
  }
  _addTask(){
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20,top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(title: DateFormat.yMMMd().format(DateTime.now()), color: Colors.grey, fontweight: 18,),
              SizedBox(height: 5,),
              TextWidget(title: "Today", color: black, fontweight: 22,istitle: true,),

            ],

          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 10,top: 10),
          child: ButtonWidget(onTap: ()async{
            await Get.to(AddTask());
            setState(() {
              _showTask();
            });
            },label: "+ add task",),
        ),
      ],
    );
  }
  _showTask(){
    return Expanded(
        child: FutureBuilder(
              future: addTaskService().getTask(),
              builder: (context,snapshot){
                print(snapshot.data);
                print("working");
                 if(snapshot.hasData){
                   var data =
                   (snapshot.data as List<Task>).toList();
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_,index){
                        print("the values of stats");
                        print(data.length);
                       var task = data[index];
                       if(task.repeat == "Daily"){
                         DateTime date = DateFormat.jm().parse(task.startTime.toString());

                         var time = DateFormat("HH:mm").format(date);
                         print("date time is"+ date.toString());
                         print("the time is" + time);
                         NotificationService().scheduledNotification(int.parse(time.split(":")[1]), int.parse(time.split(":")[0]), task);
                        return AnimationConfiguration.staggeredList(position: index,
                             child: SlideAnimation(
                               child: FadeInAnimation(
                                 child: Row(
                                   children: [
                                     GestureDetector(
                                       onTap: (){
                                         _bottomBar(context, task);
                                       },
                                       child: TaskTile(task),
                                     )
                                   ],
                                 ),
                               ),
                             ));
                       }
                       else if(task.date == DateFormat.yMd().format(_seletedTime)){
                         DateTime date = DateFormat.jm().parse(task.startTime.toString());

                         var time = DateFormat("HH:mm").format(date);
                         print("date time is"+ date.toString());
                         print("the time is" + time);
                         NotificationService().scheduledNotification(int.parse(time.split(":")[1]), int.parse(time.split(":")[0]), task);
                         return AnimationConfiguration.staggeredList(position: index,
                             child: SlideAnimation(
                               child: FadeInAnimation(
                                 child: Row(
                                   children: [
                                     GestureDetector(
                                       onTap: (){
                                         _bottomBar(context, task);
                                       },
                                       child: TaskTile(task),
                                     )
                                   ],
                                 ),
                               ),
                             ));
                       }
                       else{
                         return Container();
                       }
                      });
                }
                  return Center(
                    child: Container(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator()),
                  );
              }),

    );
  }
  _bottomBar(BuildContext context,Task task){
    return Get.bottomSheet(
      Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 10),
        height: task.isCompleted == '1'? MediaQuery.of(context).size.height * 0.24 :
        MediaQuery.of(context).size.height *0.32,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
              ),
            ),
            Spacer(),
            task.isCompleted == "0" ? _bottomButton(context: context, title: "completed", onTap: ()async{
              await addTaskService().updateMark(task.id);
              setState(() {
                _showTask();
              });
              Get.back();
            }, clr: primary) : Container(),
            _bottomButton(context: context, title: "Delete Task", onTap: ()async{
              print("clicked");
             await addTaskService().deleteTask(task.id);
             setState(() {
               _showTask();
             });
              Get.back();
            }, clr: Colors.red[300]!),
            SizedBox(
              height: 20,
            ),
            _bottomButton(context: context, title: "close", onTap: (){
              Get.back();
            },
                isClose: true,clr: primary),
            SizedBox(height: 15,)
          ],
        ),
      )
    );
  }
  _bottomButton({required BuildContext context,required String title,required Function onTap, required Color clr,bool isClose = false,  }){
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 55,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isClose ? Colors.grey[300] : clr,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isClose ? Colors.transparent : clr,
          width: 2)
        ),
        child: isClose ? Center(
          child: TextWidget(title: title, color: Colors.red, fontweight: 20),
        ): Center(child: TextWidget(title: title, color: Colors.white, fontweight: 20))
      ),
    );
  }
  _addAppbar(){
    return AppBar(
      title: Text("Budget app", style:  TextStyle(color: Colors.black,fontSize: 24),),
      leading: null,
      leadingWidth: 0,
      elevation: 0.1,
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.notifications_paused_rounded,color: Colors.black,size: 28,),
        )
      ],
    );
  }
  _addDatePicer(){
   return Container(
       margin: const EdgeInsets.only(left: 20,top: 10),
        child: DatePicker(
          DateTime.now(),
          height: 100,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: primary,
          dateTextStyle: TextStyle(
            fontSize: 20,fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          dayTextStyle: TextStyle(
            fontSize: 18,fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          monthTextStyle: TextStyle(
            fontSize: 14,fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
          onDateChange: (date){
            setState(() {
              _seletedTime = date;
            });
          },
        )
    );
  }
}
