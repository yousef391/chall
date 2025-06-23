import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:challenge_fac_app/feautures/facture/presentation/settings.dart';
import 'package:flutter/material.dart';
import 'package:challenge_fac_app/feautures/facture/presentation/facteurs_screen.dart';
import 'package:challenge_fac_app/feautures/facture/presentation/manage_article.dart';
import 'package:challenge_fac_app/feautures/facture/presentation/add_article_screen.dart';

class RootScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;
  const RootScreen({
    super.key,
    required this.onToggleTheme,
    required this.isDark,
  });

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    InvoiceListScreen(),
    InvoiceForm(),
    StockScreen(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: IndexedStack(index: _currentIndex, children: _screens),

      floatingActionButton: FloatingActionButton(
        onPressed: widget.onToggleTheme,
        backgroundColor: Colors.deepPurple,
        tooltip: widget.isDark ? 'Mode clair' : 'Mode sombre',
        child: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.receipt_long,
          Icons.add_box,
          Icons.inventory_2,
          Icons.settings,
        ],
        activeIndex: _currentIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.smoothEdge,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveColor: Colors.grey,
      ),
    );
  }
}
