import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:vpn_client/pages/main/main_page.dart';
import 'package:vpn_client/pages/settings/setting_page.dart';
import 'package:vpn_client/pages/servers/servers_page.dart';
import 'package:vpn_client/theme_provider.dart';
import 'package:vpn_client/vpn_state.dart';
import 'package:vpn_client/localization_service.dart';
// import 'package:vpn_client/pages/apps/apps_page.dart';

import 'design/colors.dart';
import 'nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Locale userLocale =
      ui.PlatformDispatcher.instance.locale; // <-- Get the system locale
  await LocalizationService.load(userLocale);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeProvider(), child: const App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final Locale? manualLocale = null;
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'VPN Client',
      theme: lightTheme,
      darkTheme: darkTheme,
      locale: manualLocale,
      localeResolutionCallback: (locale, _) {
        if (locale == null) return const Locale('en');
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              (supportedLocale.countryCode == null ||
                  supportedLocale.countryCode == locale.countryCode)) {
            return supportedLocale;
          }
        }
        if (locale.languageCode == 'zh') {
          return supportedLocales.contains(const Locale('zh'))
              ? const Locale('zh')
              : const Locale('en');
        }
        return const Locale('en');
      },
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
        Locale('zh'),
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
  int _currentIndex = 1;
  late List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    _pages = [
      // const AppsPage(),
      ServersPage(onNavBarTap: _handleNavBarTap),
      const MainPage(),
      // const PlaceholderPage(text: 'Speed Page'),
      SettingPage(onNavBarTap: _handleNavBarTap),
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
