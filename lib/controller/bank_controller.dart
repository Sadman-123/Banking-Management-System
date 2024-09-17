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
  RxList<dynamic>sums=[].obs;
  RxString l1="0".obs;
  RxString l2="0".obs;
  RxString sum="".obs;
  String getCurrentTimeAndDate() {
    DateTime now = DateTime.now();
    String formattedTimeDate = DateFormat('hh:mm a dd/MM/yyyy').format(now);
    return formattedTimeDate;
  }
  @override
  void onInit() {
    super.onInit();
    getTrans();
    getSum();
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
        l1.value="+${depositcontroller.text}";
        depositcontroller.clear();
        Get.snackbar("Success", "Deposit Successfully");
      }
      getTrans();
      getSum();
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
      l2.value="-${withdrawcontroller.text}";
      Get.snackbar("Success", "Withdraw Successfully");
      withdrawcontroller.clear();
    }
    getTrans();
    getSum();
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
  Future<void> getSum() async {
    var url = Uri.parse("https://banking-management-api.vercel.app/api/sum/${usercontroller.text}");
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var x = jsonDecode(res.body);
      if (x.isNotEmpty && x[0]['total_transfer'] != null) {
        sum.value = x[0]['total_transfer'].toString();
      } else {
        sum.value = "0";
      }
    } else {
      print("Error");
    }
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    l1.value="";
  }
}