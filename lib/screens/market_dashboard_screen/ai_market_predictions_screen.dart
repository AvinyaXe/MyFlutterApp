import 'package:flutter/material.dart';
import 'package:my_app/services/vertex_ai_service.dart';

class AIMarketPredictionsScreen extends StatefulWidget {
  @override
  _AIMarketPredictionsScreenState createState() => _AIMarketPredictionsScreenState();
}

class _AIMarketPredictionsScreenState extends State<AIMarketPredictionsScreen> {
  final VertexAIService vertexAI = VertexAIService();
  String prediction = "Waiting for AI Prediction...";

  void fetchPrediction() async {
    final result = await vertexAI.getPrediction("What are today's stock market trends?");
    setState(() {
      prediction = result;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPrediction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AI Market Predictions")),
      body: Center(child: Text(prediction)),
    );
  }
}
