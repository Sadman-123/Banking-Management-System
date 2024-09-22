import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:untitled2/pages/app.dart';
import 'package:untitled2/pages/splash.dart';
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
  @override
  void onInit() {
    super.onInit();
    TRANSACTIONS();
    SUM();
  }
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
  Future<void> REGISTER()
  async {
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
  Future<void> LOGIN()
  async {
    var dat = {
      "username": loginusername.text,
      "password": loginpass.text,
    };
    var url = Uri.parse("https://banking-management-api.vercel.app/login");
    var res=await http.post(url,headers: {'Content-Type':'application/json'},body: json.encode(dat));
    var data=jsonDecode(res.body);
    if(res.statusCode==200)
      {
        // Get.snackbar("Successs", "Login Successful");
        token=data['token'];
        Get.to(()=>App());
        TRANSACTIONS();
        SUM();
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
        // Get.snackbar("Success", "Deposited Successfully");
        l1.value=depositcontroller.text;
        TRANSACTIONS();
        SUM();
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
      // Get.snackbar("Success", "Withdraw Successfully");
      l2.value=withdrawcontroller.text;
      TRANSACTIONS();
      SUM();
      _delete_fields();
    }
  }
  Future<void> TRANSACTIONS()
  async {
    var url=Uri.parse("https://banking-management-api.vercel.app/transactions");
    var res=await http.get(url,headers: {
      'Content-Type':'application/json',
      'Authorization':'Bearer $token'
    });
    if(res.statusCode==200)
      {
        trans.assignAll(jsonDecode(res.body));
        print(trans);
      }
  }
  Future<void> SUM()
  async {
    var url = Uri.parse("https://banking-management-api.vercel.app/transactions/sum");
    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data.isNotEmpty && data[0].containsKey('total_transfer')) {
        sum.value = data[0]['total_transfer'].toString();
      } else {
        sum.value = "0";
      }
    } else {
      sum.value = "0";
    }
  }
  void LOGOUT()
  {
    token="";
    trans.clear();
    sum.value="0";
    Get.to(()=>Splash());
  }
}