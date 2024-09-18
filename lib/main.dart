import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/controller/bank_controller.dart';
import 'package:untitled2/pages/deposit.dart';
import 'package:untitled2/pages/splash.dart';
import 'package:untitled2/pages/withdraw.dart';
void main() {
  Get.put(BankController());
  runApp(Main());
}

class Bank_Controller {
}
class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: mdw * 0.088,color: Colors.black),
        )
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
class App extends StatelessWidget {
  BankController bank=Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
            style: TextStyle(
                color: Colors.black,
              fontSize: mdw*0.055
            ),
            children: [
              TextSpan(text: "Welcome"),
              TextSpan(text: " ${bank.usercontroller.text}",style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: "👋")
            ]
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                bank.usercontroller.text ="";
                bank.trans.clear();
                bank.sum.value="0";
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Splash(),));
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Obx(()=>Text(
                "${bank.sum}৳",
                style: TextStyle(
                    fontSize: mdw * 0.155, fontWeight: FontWeight.w900),
              ),)
            ),
            Container(
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.blueAccent),
                      foregroundColor: WidgetStatePropertyAll(Colors.white)),
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: Text(
                            'Choose your Option',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  child: Image.asset(
                                "assets/arrow.png",
                                height: mdh * 0.12,
                                width: mdw * 0.12,
                              ),
                                onTap: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Deposit(),));
                                },
                              ),
                              GestureDetector(
                                child: Image.asset(
                                  "assets/cash-withdrawal.png",
                                  height: mdh * 0.12,
                                  width: mdw * 0.12,
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Withdraw(),));
                                },
                              )
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Close',style: TextStyle(color: Colors.black),),
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Dismiss alert dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Online Banking")),
            ),
            SizedBox(height: mdh*0.018,),
            Expanded(
              child: Container(
                child:Obx((){
                  return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Obx(()=>bank.trans[index]['add']?Image.asset("assets/donation.png",color: Colors.green,height: mdh*0.06,):Image.asset("assets/money-withdrawal.png",color: Colors.red,height: mdh*0.06,)),
                          title: Obx(()=>Text("${bank.trans[index]['time']}",style: TextStyle(fontSize: mdw*0.046),),),
                          trailing: Obx(()=>bank.trans[index]['add']?Text("+${bank.trans[index]['money_transfer']}",style: TextStyle(fontSize: mdw*0.058,color: Colors.green),):Text("-${bank.trans[index]['money_transfer']}",style: TextStyle(fontSize: mdw*0.058,color: Colors.red),)),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: bank.trans.length);
                })
              ),
            )
          ],
        ),
      ),
    );
  }
}
