import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled2/controller/bank_controller.dart';
import 'package:untitled2/pages/splash.dart';
void main() {
  Get.put(BankController());
  runApp(Main());
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
