import 'package:flutter/material.dart';
class Withdraw extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var mdw = MediaQuery.of(context).size.width;
    var mdh = MediaQuery.of(context).size.height;
    return  Scaffold(
      appBar: AppBar(
        title: Text("Withdraw"),
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
            Text(
              "0৳", // Use .value for reactive variables
              style: TextStyle(fontSize: mdw * 0.185, fontWeight: FontWeight.w900),
            ),
            Container(
              width: mdw * 0.8,
              child: TextField(
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