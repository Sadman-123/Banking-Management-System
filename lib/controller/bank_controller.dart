import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class BankController extends GetxController{
  TextEditingController usercontroller=TextEditingController();
  TextEditingController depositcontroller=TextEditingController();
  TextEditingController withdrawcontroller=TextEditingController();
  RxList<dynamic>trans=[].obs;
  String getCurrentTimeAndDate() {
    DateTime now = DateTime.now();
    String formattedTimeDate = DateFormat('hh:mm a dd/MM/yyyy').format(now);
    return formattedTimeDate;
  }
  @override
  void onInit() {
    super.onInit();
    getTrans();
  }
  Future<void> depo_to_trans()
  async{
    var dat={
      "money_transfer": int.parse(depositcontroller.text),
      "add": true,
      "time": getCurrentTimeAndDate(),
      "name": usercontroller.text
    };
    var url=Uri.parse("https://banking-management-api.vercel.app/insert");
    var res=await http.post(url,headers: {'Content-Type': 'application/json; charset=UTF-8',},body: json.encode(dat));
    if(res.statusCode==200)
      {
        Get.showSnackbar(GetSnackBar(
          title: "Added Successfully",
        ));
        depositcontroller.clear();
      }
    
  }
  Future<void> withdraw_to_trans()
  async{
    var dat={
      "money_transfer": int.parse(withdrawcontroller.text),
      "add": false,
      "time": getCurrentTimeAndDate(),
      "name": usercontroller.text
    };
    var url=Uri.parse("https://banking-management-api.vercel.app/insert");
    var res=await http.post(url,headers: {'Content-Type': 'application/json; charset=UTF-8',},body: json.encode(dat));
    if(res.statusCode==200)
    {
      Get.showSnackbar(GetSnackBar(
        title: "Added Successfully",
      ));
      withdrawcontroller.clear();
    }

  }
  Future<void>getTrans()
  async{
    var url=Uri.parse("https://banking-management-api.vercel.app/api/${usercontroller.text}");
    var res=await http.get(url);
    if(res.statusCode==200)
      {
        trans.assignAll(jsonDecode(res.body));
      }
    else{
      print("Error");
    }
  }
}