import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:my_app/screens/ai_assistant_screen.dart';
import 'package:my_app/screens/investment_tips_screen.dart';
import 'package:my_app/utils/theme_provider.dart';
import 'package:my_app/screens/market_dashboard_screen/market_dashboard_screen.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _hoverIndex = -1;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'DeepState',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildHeroSection(context),
            const SizedBox(height: 20),
            _buildFeatureCards(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final theme = Theme.of(context);
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 500),
      child: FadeInAnimation(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: theme.colorScheme.surface.withOpacity(0.8),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Manage your investments smartly.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCards(BuildContext context) {
    return AnimationLimiter(
      child: Column(
        children: [
          _buildAnimatedCard(
            context,
            'Market Dashboard',
            Icons.show_chart,
            Colors.blueAccent,
            const MarketDashboardScreen(),
            0,
          ),
          _buildAnimatedCard(
            context,
            'Investment Tips',
            Icons.trending_up,
            Colors.greenAccent,
            const InvestmentTipsScreen(),
            1,
          ),
          _buildAnimatedCard(
            context,
            'AI Assistant',
            Icons.smart_toy,
            Colors.deepPurple,
            const AIAssistantScreen(),
            2,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget screen,
    int index,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 500),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder:
                      (context, animation, secondaryAnimation) => screen,
                  transitionsBuilder: (
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            },
            child: MouseRegion(
              onEnter: (_) => setState(() => _hoverIndex = index),
              onExit: (_) => setState(() => _hoverIndex = -1),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isDarkMode ? Colors.grey[900] : Colors.white,
                  boxShadow:
                      _hoverIndex == index
                          ? [
                            BoxShadow(
                              color:
                                  isDarkMode
                                      ? Colors.white.withOpacity(0.1)
                                      : Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 3,
                            ),
                          ]
                          : [],
                ),
                child: ListTile(
                  leading: Icon(icon, color: color, size: 32),
                  title: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
