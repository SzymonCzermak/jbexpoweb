import 'package:flutter/material.dart';
import 'package:jbexpoweb/AboutUsPage/AboutUsPage.dart';
import 'package:jbexpoweb/CompanyLocationPage.dart';
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
  int _currentIndex = 0; // Aktualnie wybrana zakładka
  bool _isPolish = true; // Flaga języka

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Tworzymy listę stron z przekazaniem funkcji onNavigate do JBExpoPage
    _pages = [
      JBExpoPage(
        isPolish: _isPolish,
        onNavigate: _navigateTo, // Przekazujemy nawigację
      ),
      HowWeWorkPage(isPolish: _isPolish),
      PortfolioPage(isPolish: _isPolish),
      AboutUsPage(isPolish: _isPolish),
      CompanyLocationWebPage(isPolish: _isPolish), // Lokalizacja firmy
    ];
  }

  // Obsługa nawigacji między zakładkami
  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index; // Zmieniamy indeks aktualnej strony
    });
  }

  // Obsługa zmiany języka
  void _toggleLanguage(bool value) {
    setState(() {
      _isPolish = value;

      // Odświeżamy język na każdej stronie
      _pages[0] = JBExpoPage(
        isPolish: _isPolish,
        onNavigate: _navigateTo,
      );
      _pages[1] = HowWeWorkPage(isPolish: _isPolish);
      _pages[2] = PortfolioPage(isPolish: _isPolish);
      _pages[3] = AboutUsPage(isPolish: _isPolish);
      _pages[4] = CompanyLocationWebPage(isPolish: _isPolish);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StaticAppBar(
        currentIndex: _currentIndex, // Aktualny indeks strony
        onNavigate: _navigateTo, // Funkcja nawigacji
        isPolish: _isPolish, // Flaga języka
        toggleLanguage: _toggleLanguage, // Funkcja zmiany języka
      ),
      body: IndexedStack(
        index: _currentIndex, // Wyświetlana strona na podstawie indeksu
        children: _pages,
      ),
    );
  }
}
