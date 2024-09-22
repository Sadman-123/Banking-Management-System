import 'package:flutter/material.dart';
import 'package:untitled2/main.dart';
import 'package:get/get.dart';
import 'package:untitled2/controller/bank_controller.dart';
import 'package:untitled2/pages/splash.dart';
class Splash2 extends StatelessWidget {
  BankController bank=Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF7C93C3),
      appBar: AppBar(
        backgroundColor: Color(0xFF7C93C3),
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
                        color: Color(0xFF181C14),
                      ),
                    ),
                    Text(
                      "Your Trust, Our Commitment.",
                      style: TextStyle(
                        fontSize: mdw * 0.063,
                        color: Color(0xFF181C14),
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
                        style: TextStyle(
                            fontSize: mdw*0.05,
                            fontWeight: FontWeight.bold
                        ),
                        controller: bank.registerusername,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: mdw*0.05
                          ),
                          filled: true,
                          hintText: "New User Name",
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(44)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: mdw * 0.7,
                      child: TextField(
                        style: TextStyle(
                            fontSize: mdw*0.05,
                            fontWeight: FontWeight.bold
                        ),
                        controller: bank.registerpass,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: mdw*0.05
                          ),
                          filled: true,
                          hintText: "New Password",
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(44)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                       bank.REGISTER();
                      },
                      child: Text("REGISTRATION"),
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.white),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: (){Get.to(Splash(),transition: Transition.cupertino);},
                      child: RichText(text: TextSpan(
                          style: TextStyle(fontSize: mdw*0.043),
                          children: [
                            TextSpan(text: "Already have account? ",style: TextStyle(color: Colors.black)),
                            TextSpan(text: "Login Now",style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold))
                          ]
                      ),
                      ),
                    )
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
