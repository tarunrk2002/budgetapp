import 'package:budgetapps/Screens/dashboard.dart';
import 'package:budgetapps/services/Notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/login_page.dart';
import 'Screens/splashScreen.dart';
void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Budget App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: splash(),
    );
  }
}

