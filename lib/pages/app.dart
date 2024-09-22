import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/controller/bank_controller.dart';
import 'package:untitled2/pages/deposit.dart';
import 'package:untitled2/pages/splash.dart';
import 'package:untitled2/pages/withdraw.dart';
class App extends StatelessWidget {
  BankController bank = Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Obx(() {
          // Check if trans list is not empty before accessing it
          if (bank.trans.isNotEmpty) {
            return RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: mdw * 0.055,
                ),
                children: [
                  TextSpan(text: "Welcome"),
                  TextSpan(
                      text: " ${bank.trans[0]['name']}",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: "👋"),
                ],
              ),
            );
          } else {
            return Text("Welcome", style: TextStyle(fontSize: mdw * 0.055));
          }
        }),
        actions: [
          IconButton(onPressed: (){bank.LOGOUT();}, icon: Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Obx(
                    () => Text(
                  "${bank.sum.value}৳",
                  style: TextStyle(
                      fontSize: mdw * 0.155, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStatePropertyAll(Colors.blueAccent),
                  foregroundColor:
                  MaterialStatePropertyAll(Colors.white),
                ),
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
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Deposit()),
                                );
                              },
                            ),
                            GestureDetector(
                              child: Image.asset(
                                "assets/cash-withdrawal.png",
                                height: mdh * 0.12,
                                width: mdw * 0.12,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Withdraw()),
                                );
                              },
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'Close',
                              style: TextStyle(color: Colors.black),
                            ),
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
                child: Text("Online Banking"),
              ),
            ),
            SizedBox(height: mdh * 0.018),
            Expanded(
              child: Container(
                child: Obx(() {
                  if (bank.trans.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (bank.trans.isNotEmpty && bank.trans.length == 0) {
                    return Center(
                      child: Text(
                        "No transactions available",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: bank.trans[index]['add']
                              ? Image.asset(
                            "assets/donation.png",
                            color: Colors.green,
                            height: mdh * 0.06,
                          )
                              : Image.asset(
                            "assets/money-withdrawal.png",
                            color: Colors.red,
                            height: mdh * 0.06,
                          ),
                          title: Text(
                            "${bank.trans[index]['time']}",
                            style: TextStyle(fontSize: mdw * 0.046),
                          ),
                          trailing: bank.trans[index]['add']
                              ? Text(
                            "+${bank.trans[index]['money_transfer']}",
                            style: TextStyle(
                                fontSize: mdw * 0.058, color: Colors.green),
                          )
                              : Text(
                            "-${bank.trans[index]['money_transfer']}",
                            style: TextStyle(
                                fontSize: mdw * 0.058, color: Colors.red),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: bank.trans.length,
                    );
                  }
                }),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
