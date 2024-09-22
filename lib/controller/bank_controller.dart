import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled2/pages/app.dart';
class BankController extends GetxController{
  TextEditingController loginusername=TextEditingController();
  TextEditingController loginpass=TextEditingController();
  TextEditingController registerusername=TextEditingController();
  TextEditingController registerpass=TextEditingController();
  TextEditingController depositcontroller=TextEditingController();
  TextEditingController withdrawcontroller=TextEditingController();
  RxList<dynamic>trans=[].obs;
  RxList<dynamic>sums=[].obs;
  RxString l1="0".obs;
  RxString l2="0".obs;
  RxString sum="".obs;
  String token="";
  void _delete_fields()
  {
    loginusername.clear();
    loginpass.clear();
    registerusername.clear();
    registerpass.clear();
    depositcontroller.clear();
    withdrawcontroller.clear();
  }
  String getCurrentTimeAndDate() {
    DateTime now = DateTime.now();
    String formattedTimeDate = DateFormat('hh:mm a dd/MM/yyyy').format(now);
    return formattedTimeDate;
  }
  Future<void> REGISTER() async {
    var dat = {
      "username": registerusername.text,
      "password": registerpass.text,
      "time": getCurrentTimeAndDate()
    };
    var url = Uri.parse("https://banking-management-api.vercel.app/register");
    var res = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: json.encode(dat));
    if (res.statusCode == 200) {
      Get.snackbar("Success", "User Created Successfully", dismissDirection: DismissDirection.vertical);
      _delete_fields();
    } else if (res.statusCode == 401) {
      Get.snackbar("Warning", "User Already Exists", dismissDirection: DismissDirection.vertical);
      _delete_fields();
    } else {
      Get.snackbar("Error", "Something went wrong", dismissDirection: DismissDirection.vertical);
      _delete_fields();
    }
  }
  Future<void> LOGIN() async
  {
    var dat = {
      "username": loginusername.text,
      "password": loginpass.text,
    };
    var url = Uri.parse("https://banking-management-api.vercel.app/login");
    var res=await http.post(url,headers: {'Content-Type':'application/json'},body: json.encode(dat));
    var data=jsonDecode(res.body);
    if(res.statusCode==200)
      {
        Get.snackbar("Successs", "Login Successful");
        token=data['token'];
        Get.to(App());
        _delete_fields();
      }
    else{
      Get.snackbar("Warning", "Login Unsuccessful");
      _delete_fields();
    }
  }
  Future<void> DEPOSIT()
  async{
    var dat={
      "time": getCurrentTimeAndDate(),
      "add": true,
      "money_transfer": depositcontroller.text,
    };
    var url=Uri.parse("https://banking-management-api.vercel.app/insert");
    var res=await http.post(url,headers:{
      'Content-Type':'application/json',
      'Authorization':'Bearer $token'
    },body: json.encode(dat));
    if(res.statusCode==200)
      {
        Get.snackbar("Success", "Added Successfully");
        l1.value=depositcontroller.text;
        _delete_fields();
      }
  }
  Future<void> WITHDRAW()
  async{
    var dat={
      "time": getCurrentTimeAndDate(),
      "add": false,
      "money_transfer": withdrawcontroller.text,
    };
    var url=Uri.parse("https://banking-management-api.vercel.app/insert");
    var res=await http.post(url,headers:{
      'Content-Type':'application/json',
      'Authorization':'Bearer $token'
    },body: json.encode(dat));
    if(res.statusCode==200)
    {
      Get.snackbar("Success", "Withdraw Successfully");
      l2.value=withdrawcontroller.text;
      _delete_fields();
    }
  }
}