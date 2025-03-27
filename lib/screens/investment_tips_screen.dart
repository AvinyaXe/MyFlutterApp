import 'package:flutter/material.dart';

class InvestmentTipsScreen extends StatelessWidget {
  const InvestmentTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investment Tips'),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          'Here you will find investment strategies and tips!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
