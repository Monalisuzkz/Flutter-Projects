import 'package:flutter/material.dart';

class StrawberryScreen extends StatelessWidget {
  const StrawberryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    String StrawberryText = "Strawberry Cake A soft and fluffy cake layered with fresh strawberries and cream. Perfect for desserts lovers who enjoy a mix of sweet and tangy flavor.";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Razonable Activity 1'),
        backgroundColor: const Color(0xFFFFD1DC),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/strawberry_cake.jpg',
          height: 400,
          width: double.infinity,
          fit: BoxFit.cover,
          ),

          Padding(padding: const EdgeInsets.all(16.0),
          child: Text(StrawberryText,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          ),
          ),
        ],
      ),
    );
  }
}