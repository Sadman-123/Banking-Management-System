import 'package:flutter/material.dart';
import 'package:untitled2/controller/bank_controller.dart';
import 'package:get/get.dart';
import 'package:untitled2/main.dart';
class Deposit extends StatelessWidget {
BankController bank=Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          bank.l1.value="0";
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => App(),));
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Deposit"),
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
              "${bank.l1}৳",
              style: TextStyle(
                  fontSize: mdw * 0.185, fontWeight: FontWeight.w900),
            ),),
            Container(
              width: mdw * 0.8,
              child: TextField(
                controller: bank.depositcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(37),
                  ),
                  hintText: "Enter Deposit Amount",
                ),
              ),
            ),
            SizedBox(height: mdh * 0.015),
            ElevatedButton(
              onPressed: () {
                bank.depo_to_trans();
                bank.l1.value="";
              },
              child: Text("Deposit Money"),
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Colors.greenAccent.shade400),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
