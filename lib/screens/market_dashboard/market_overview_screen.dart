import 'dart:ui'; // Import for BackdropFilter
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MarketOverviewScreen extends StatelessWidget {
  MarketOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Market Overview',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: AnimationLimiter(
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.9,
            ),
            itemCount: _marketData.length,
            itemBuilder: (context, index) {
              final data = _marketData[index];
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 500),
                columnCount: 2,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _MarketCard(
                      title: data['title']!,
                      description: data['description']!,
                      icon: data['icon'] as IconData,
                      color: data['color'] as Color,
                      imageUrl: data['imageUrl']!,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _marketData = [
    {
      'title': 'Stock Market',
      'description': 'Latest stock trends and market indices.',
      'icon': Icons.show_chart,
      'color': Colors.blueAccent,
      'imageUrl': 'assets/images/stock_market.jpg',
    },
    {
      'title': 'Cryptocurrency',
      'description': 'Real-time crypto price updates and analysis.',
      'icon': Icons.currency_bitcoin,
      'color': Colors.orangeAccent,
      'imageUrl': 'assets/images/crypto.jpg',
    },
    {
      'title': 'Global Economy',
      'description': 'Recent financial news and global trends.',
      'icon': Icons.public,
      'color': Colors.greenAccent,
      'imageUrl': 'assets/images/global_economy.jpg',
    },
    {
      'title': 'Real Estate Trends',
      'description': 'Market updates on real estate investments.',
      'icon': Icons.house,
      'color': Colors.purpleAccent,
      'imageUrl': 'assets/images/real_estate_trends.jpg',
    },
  ];
}

class _MarketCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String imageUrl;
  final bool isDarkMode;

  const _MarketCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.imageUrl,
    required this.isDarkMode,
  });

  @override
  _MarketCardState createState() => _MarketCardState();
}

class _MarketCardState extends State<_MarketCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _isHovered ? (Matrix4.identity()..scale(1.03)) : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isDarkMode
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isDarkMode
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.2),
              blurRadius: _isHovered ? 15 : 10,
              spreadRadius: _isHovered ? 3 : 2,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            children: [
              Image.asset(widget.imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
              ListTile(
                leading: Icon(widget.icon, color: widget.color, size: 32),
                title: Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: widget.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                subtitle: Text(
                  widget.description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: widget.isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: widget.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
