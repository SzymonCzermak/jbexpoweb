import 'package:flutter/material.dart';
import 'package:jbexpoweb/StaticAppBar.dart';
import 'package:jbexpoweb/jbexpo_page.dart';
import 'package:jbexpoweb/PortfolioSection/PortfolioSection.dart';
import 'package:jbexpoweb/WorkSection/TransportSection.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  bool _isPolish = true; // Flaga języka

  final List<Widget> _pages = [
    JBExpoPage(isPolish: true),
    HowWeWorkPage(isPolish: true),
    PortfolioPage(isPolish: true),
  ];

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _toggleLanguage(bool value) {
    setState(() {
      _isPolish = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaticAppBar(
        currentIndex: _currentIndex,
        onNavigate: _navigateTo,
        isPolish: _isPolish,
        toggleLanguage: _toggleLanguage, // Przekazanie obsługi zmiany języka
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages.map((page) {
          if (page is JBExpoPage) {
            return JBExpoPage(isPolish: _isPolish);
          } else if (page is HowWeWorkPage) {
            return HowWeWorkPage(isPolish: _isPolish);
          } else if (page is PortfolioPage) {
            return PortfolioPage(isPolish: _isPolish);
          } else {
            return const SizedBox.shrink();
          }
        }).toList(),
      ),
    );
  }
}
