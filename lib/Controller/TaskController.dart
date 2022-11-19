import 'package:budgetapps/model/Task.dart';
import 'package:get/get.dart';
import 'package:budgetapps/services/add_taskService.dart';
class TaskController extends GetxController{
  Future AddTask({Task? task}) async{
    await addTaskService.addTask(task);
  }


}