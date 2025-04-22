import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'package:vpn_client/pages/apps/apps_page.dart';
import 'package:vpn_client/pages/main/main_page.dart';
import 'package:vpn_client/pages/servers/servers_page.dart';
import 'package:vpn_client/theme_provider.dart';

import 'design/colors.dart';
import 'nav_bar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeProvider(), child: const App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    var language = const Locale('th');//<-- You can change language here manually

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VPN Client',
      theme: lightTheme,
      darkTheme: darkTheme,
      locale: language,
      themeMode: themeProvider.themeMode,
      home: const MainScreen(),

    
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        Locale('th'), 
        
      ],
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const AppsPage(),
      ServersPage(onNavBarTap: _handleNavBarTap),
      const MainPage(),
      const PlaceholderPage(text: 'Speed Page'),
      const PlaceholderPage(text: 'Settings Page'),
    ];
  }

  void _handleNavBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavBar(
        initialIndex: _currentIndex,
        onItemTapped: _handleNavBarTap,
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String text;
  const PlaceholderPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text));
  }
}
