import 'package:budgetapps/Controller/TaskController.dart';
import 'package:budgetapps/model/Task.dart';
import 'package:budgetapps/widget/InputText.dart';
import 'package:budgetapps/widget/button.dart';
import 'package:budgetapps/widget/textWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}
final TaskController _taskController = Get.put(TaskController());
final TextEditingController _titleController = TextEditingController();
final TextEditingController _noteController = TextEditingController();
DateTime _selectedDate = DateTime.now();
String _endtime = "9:30 PM";
String _starttime = DateFormat("hh:mm a").format(DateTime.now()).toString();
int _selectedRemaind = 5;
int _seletedColor = 0;
List<int> Remainder = [
  5,10,15,20
];
String _selectedRepeat = "none";
List<String> RemainderRepeat = [
  "none",
  "Daily",
  "Monthly",
  "Yearly"
];
List<Color> colors = [
  Colors.blueAccent,
  Colors.pinkAccent,
  Colors.yellowAccent
];
class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addAppbar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InputTextFeild(
                title: "Title",
                Hinttext: "Enter the title",
                controller: _titleController,
              ),
              InputTextFeild(
                title: "Note",
                Hinttext: "Enter the note",
                controller: _noteController,
              ),
              InputTextFeild(
                title: "Date",
                Hinttext: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: Icon(Icons.calendar_today_outlined,color: Colors.grey,),
                ),
              ),
              Row(
                children: [
                  Expanded(child: InputTextFeild(
                    title: "Start time",
                    Hinttext :_starttime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFromUser(true);
                      },
                      icon: Icon(Icons.access_time_rounded,color: Colors.grey,),
                    ),
                  )),
                  SizedBox(width: 5,),
                  Expanded(child: InputTextFeild(
                    title: "End Time",
                    Hinttext :_endtime,
                    widget: IconButton(
                      onPressed: (){
                        _getTimeFromUser(false);
                      },
                      icon: Icon(Icons.access_time_rounded,color: Colors.grey,),
                    ),
                  )),
                ],
              ),
               InputTextFeild(title: "Remaind", Hinttext: "$_selectedRemaind minutes early",
                widget: DropdownButton(
                  underline: Container(height: 0,),
                  onChanged: (String? newValue){
                    setState(() {
                      _selectedRemaind = int.parse(newValue!);
                    });
                  },
                  items: Remainder.map<DropdownMenuItem<String>>((int value){
                  return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: TextWidget(title: value.toString(),color: Colors.grey,fontweight: 20,)
                  );
                  }).toList(),
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                  style: TextStyle(color: Colors.grey),
                  elevation: 3,
                  iconSize: 32,
                ),
                ),
              InputTextFeild(title: "Repeat", Hinttext: "$_selectedRepeat",
                widget: DropdownButton(
                  underline: Container(height: 0,),
                  onChanged: (String? newValue){
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items: RemainderRepeat.map<DropdownMenuItem<String>>((String value){
                    return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: TextWidget(title: value.toString(),color: Colors.grey,fontweight: 20,)
                    );
                  }).toList(),
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                  style: TextStyle(color: Colors.grey),
                  elevation: 3,
                  iconSize: 32,
                ),
              ),
              SizedBox(height: 8,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 _colorPallete(),
                 ButtonWidget(label: "Create Task",onTap: (){
                   _validateData();
                 },)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  _validateData(){
    if(_titleController.text.isNotEmpty && _noteController.text.isNotEmpty){
      //add to database
      _AddToDb();
      Get.back();
    }
    else if(_titleController.text.isEmpty || _noteController.text.isEmpty ){
      Get.snackbar(
        "Required",
        "all feilds required",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        icon: Icon(Icons.warning_amber_outlined)
      );
    }
  }
  _AddToDb() async {
  await _taskController.AddTask(task:  Task(
    id: 0.toString(),
     note: _noteController.text,
     title: _titleController.text,
     date: DateFormat.yMd().format(_selectedDate),
     startTime: _starttime,
     endTime: _endtime,
     remaind: _selectedRemaind.toString(),
     repeat: _selectedRepeat,
     color: _seletedColor.toString(),
     isCompleted: 0.toString(),
   ));
  }
  _colorPallete(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(title: "Color", color: Colors.black, fontweight: 20,),
        SizedBox(height: 8,),
        Wrap(
          children: List<Widget>.generate(
              3,
                  (int index){
                return InkWell(
                  onTap: (){
                    setState(() {
                      _seletedColor = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundColor: colors[index],
                      radius: 14,
                      child: _seletedColor == index ? Icon(Icons.done,color: Colors.white,size: 16,) : Container(),
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }
  _addAppbar() {
    return AppBar(
      title: Text(
        "Add Task",
        style: TextStyle(color: Colors.black, fontSize: 24),
      ),
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          )),
      elevation: 0.1,
      backgroundColor: Colors.white,
    );
  }
  _getDateFromUser() async{
    DateTime? _picker = await showDatePicker(context: context,
        initialDate: DateTime.now(), firstDate: DateTime(2015), lastDate: DateTime(2121));
    if(_picker != null){
      setState(() {
        _selectedDate = _picker;
      });
      print(_selectedDate);
    }
    else{
      print("something went worng in the date picker");
    }
  }
  _getTimeFromUser(bool starttime) async{
    var _pickedTime = await _showTimePicker();
    String Time = _pickedTime.format(context);
    if(Time == null){
      print("time canceled");
    }
    else if(starttime == true){
      setState(() {
        _starttime = Time;
      });
    }
    else if(starttime == false){
      setState(() {
        _endtime = Time;
      });
    }
  }
  _showTimePicker(){
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_starttime.split(":")[0]), minute: int.parse(_starttime.split(":")[1].split(" ")[0]))
    );
  }
}
