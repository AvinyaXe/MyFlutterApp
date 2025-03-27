import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:my_app/utils/theme_provider.dart';
import 'package:my_app/screens/home_screen.dart';
import 'package:my_app/utils/app_theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), // Provide the ThemeProvider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Use provider

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          themeProvider.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
} 