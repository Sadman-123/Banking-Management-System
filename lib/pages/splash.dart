import 'package:flutter/material.dart';
import 'package:untitled2/main.dart';
import 'package:get/get.dart';
import 'package:untitled2/controller/bank_controller.dart';
class Splash extends StatelessWidget {
  BankController bank=Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/finance.png",
                        width: mdw * 0.55,
                      ),
                    ),
                    Text(
                      "City Bank",
                      style: TextStyle(
                        fontSize: mdw * 0.13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Your Trust, Our Commitment.",
                      style: TextStyle(
                        fontSize: mdw * 0.063,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      width: mdw * 0.7,
                      child: TextField(
                        controller: bank.usercontroller,
                        decoration: InputDecoration(
                          hintText: "User Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => App(),));
                        bank.getTrans();
                        bank.getSum();
                      },
                      child: Text("LOGIN"),
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
