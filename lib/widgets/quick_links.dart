import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickLinks extends StatelessWidget {
  final Function(String) onSectionSelected;
  
  const QuickLinks({Key? key, required this.onSectionSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildButton(context, "Market Overview"),
        _buildButton(context, "Investment Tips"),
        _buildButton(context, "AI Assistant"),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String title) {
    return GestureDetector(
      onTap: () => onSectionSelected(title),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
