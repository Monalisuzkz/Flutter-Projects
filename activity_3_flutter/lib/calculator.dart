import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  String result = "";
  
  void calculate(String operator) {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;
    double res = 0;

    switch (operator) {

      case '+':
      res = num1 + num2;
      break;

      case '-':
      res = num1 - num2;
      break;

      case '*':
      res = num1 * num2;
      break;

      case '÷':
      if(num2 != 0) {
        res = num1 / num2;
      } else {
        result = "Cannot divide by zero";
        return;
      }
        break;

    }

    setState(() {
      result = res.toStringAsFixed(2);
    });
  }

  Widget buildOperatorButton (String operator, Color color) {
    return ElevatedButton(style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    onPressed: () => calculate(operator),
    child: Text(operator, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
    );
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razonable Activity 3"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.purple.shade100, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [TextField(
          controller: num1Controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Number 1",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SizedBox(height: 15),
        TextField(
          controller: num2Controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Number 2",
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildOperatorButton('+', Colors.green),
            buildOperatorButton('-', Colors.red),
            buildOperatorButton('*', Colors.orange),
            buildOperatorButton('÷', Colors.blue),
          ],
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 8, offset: Offset(2, 4)),
            ],
          ),
          child: Text("Result: $result",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
          textAlign: TextAlign.center,),
        ),
        ],
        ),
      ),
    );
  }
}