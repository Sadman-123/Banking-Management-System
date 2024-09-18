import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/controller/bank_controller.dart';
import 'package:untitled2/main.dart';
class Withdraw extends StatelessWidget{
  BankController bank=Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: AppBar(
        title: Text("Withdraw"),
        leading: IconButton(onPressed: (){
          bank.l2.value="0";
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => App(),));
        }, icon: Icon(Icons.arrow_back)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Obx(()=>Text(
              "${bank.l2.value}৳",
              style: TextStyle(fontSize: mdw * 0.155, fontWeight: FontWeight.w900,color: Colors.red),
            ),),
            Container(
              width: mdw * 0.8,
              child: TextField(
                controller: bank.withdrawcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(37),
                  ),
                  hintText: "Enter Withdrawal Amount",
                ),
              ),
            ),
            SizedBox(height: mdh * 0.015),
            ElevatedButton(
              onPressed: () {
                bank.withdraw_to_trans();
              },
              child: Text("Deposit Money"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber.shade400),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}