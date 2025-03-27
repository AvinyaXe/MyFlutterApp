import 'dart:ui'; // Import for BackdropFilter
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class MarketOverviewScreen extends StatelessWidget {
  MarketOverviewScreen({Key? key}) : super(key: key); // Removed `const`

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(_marketData.length, (index) {
              final data = _marketData[index];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _MarketCard(
                      title: data['title']!,
                      description: data['description']!,
                      icon: data['icon'] as IconData,
                      color: data['color'] as Color,
                      isDarkMode: isDarkMode,
                    ),
                  ),
                ),
              );
            }),
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
    },
    {
      'title': 'Cryptocurrency',
      'description': 'Real-time crypto price updates and analysis.',
      'icon': Icons.currency_bitcoin,
      'color': Colors.orangeAccent,
    },
    {
      'title': 'Global Economy',
      'description': 'Recent financial news and global trends.',
      'icon': Icons.public,
      'color': Colors.greenAccent,
    },
  ];
}

class _MarketCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isDarkMode;

  const _MarketCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
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
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.isDarkMode
                ? Colors.white.withOpacity(0.2)
                : Colors.black.withOpacity(0.2), // Adjusted border for light mode
          ),
          gradient: LinearGradient(
            colors: widget.isDarkMode
                ? [
                    Colors.white.withOpacity(_isHovered ? 0.2 : 0.1),
                    Colors.white.withOpacity(_isHovered ? 0.1 : 0.05),
                  ]
                : [
                    Colors.white.withOpacity(_isHovered ? 0.9 : 0.5), // More visible on hover
                    Colors.white.withOpacity(_isHovered ? 0.6 : 0.3),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: widget.isDarkMode
                  ? Colors.black.withOpacity(0.3) // Dark mode shadow
                  : Colors.grey.withOpacity(0.2), // Light mode shadow
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: _isHovered ? 5.0 : 10.0, sigmaY: _isHovered ? 5.0 : 10.0), // Less blur on hover
            child: ListTile(
              leading: Icon(widget.icon, color: widget.color, size: 32),
              title: Text(
                widget.title,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: widget.isDarkMode
                      ? Colors.white.withOpacity(0.95)
                      : Colors.black.withOpacity(_isHovered ? 0.95 : 0.7), // Darker text on hover
                ),
              ),
              subtitle: Text(
                widget.description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: widget.isDarkMode
                      ? Colors.white.withOpacity(0.85)
                      : Colors.black.withOpacity(_isHovered ? 0.85 : 0.6), // Adjusted for visibility
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: widget.isDarkMode
                    ? Colors.white
                    : Colors.black.withOpacity(_isHovered ? 0.9 : 0.6), // Darker icon on hover
              ),
            ),
          ),
        ),
      ),
    );
  }
}
