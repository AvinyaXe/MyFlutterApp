import 'package:flutter/material.dart';
import 'package:my_app/screens/market_dashboard_screen/market_overview_screen.dart';
import 'package:my_app/screens/market_dashboard_screen/ai_market_predictions_screen.dart';

class MarketDashboardScreen extends StatelessWidget {
  const MarketDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Two tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Market Dashboard'),
          backgroundColor: Colors.deepPurple,
          bottom: const TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)), 
              color: Colors.deepPurpleAccent, // Active tab color
            ),
            labelColor: Colors.white, // Active tab text color
            unselectedLabelColor: Colors.grey, // Inactive tab text color
            tabs: [
              Tab(text: "Overview"),
              Tab(text: "AI Predictions"),
            ],
          ),

        ),
        body: TabBarView(
          children: [
            MarketOverviewScreen(), // Tab 1: Market Overview
            AIMarketPredictionsScreen(), // Tab 2: AI Market Predictions
          ],
        ),
      ),
    );
  }
}
