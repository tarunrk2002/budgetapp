import 'package:budgetapps/model/budget.dart';
import 'package:budgetapps/model/day.dart';
import 'package:budgetapps/services/auth.dart';
import 'package:http/http.dart' as https;

import 'cred_screat.dart';
class FetchBudgetList{
  String ipUrl = Auth.Ipurl;
  Future<List<Budget>> getBudgetList(String index) async{
    var email = await Cred_store.getUserName() ;
    var url = Uri.http(ipUrl, '/flutter/fetchBudget.php');
    print(url);
    var response = await https.post(url, body: {
      "email":email,
      "day":index
    });
    print("printing response");
    print(response.body);
    return budgetFromJson(response.body);
  }
}