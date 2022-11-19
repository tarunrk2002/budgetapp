import 'package:budgetapps/model/Task.dart';
import 'package:http/http.dart' as https;

import 'auth.dart';
import 'cred_screat.dart';
class addTaskService{
  static String Iurl = Auth.Ipurl;
  static Future addTask(Task? task) async{
    var email = await Cred_store.getUserName() ;
    var url = Uri.http(Iurl, '/flutter/addTask.php');
    print(url);

    var response = await https.post(url, body:{
   "title": task!.title,
   "note": task.note,
   "date": task.date,
    "startTime" : task.startTime,
    "endTime": task.endTime,
    "remaind": task.remaind.toString(),
    "repeat": task.repeat,
    "color":task.color.toString(),
    "isCompleted": task.isCompleted.toString(),
    "email": email.toString(),
    });
    print(response.body);
  }
  Future getTask() async{
    var email = await Cred_store.getUserName() ;
    var url = Uri.http(Iurl, '/flutter/FetchTask.php');
    var response = await https.post(url, body: {
      "email": email,
    });
    print(response.body);
    return taskFromJson(response.body);
  }
  Future deleteTask(String id) async{
    print("delte the task" + id);
    var url = Uri.http(Iurl, '/flutter/deletetask.php');
    var response = await https.post(url, body: {
      "id": id,
    });
    print(response.body);
  }
  Future updateMark(String id) async{
    print("id updated "+ id);
    var url = Uri.http(Iurl, '/flutter/updatetask.php');
    var response = await https.post(url, body: {
      "id": id,
    });
    print(response.body);
  }
}