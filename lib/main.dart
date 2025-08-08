import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:vpn_client/pages/main/main_page.dart';
import 'package:vpn_client/pages/settings/setting_page.dart';
import 'package:vpn_client/pages/servers/servers_page.dart';
import 'package:vpn_client/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vpn_client/vpn_state.dart';
import 'package:vpn_client/localization_service.dart';
import 'package:vpn_client/services/config_service.dart';
import 'package:vpn_client/services/onboarding_service.dart';
import 'package:vpn_client/services/deep_link_service.dart';
import 'package:vpn_client/pages/onboarding/onboarding_screen.dart';
// import 'package:vpn_client/pages/apps/apps_page.dart';

import 'theme/app_theme_export.dart';
import 'nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация конфигурации
  await ConfigService.initialize();

  Locale userLocale;
  try {
    userLocale = ui.PlatformDispatcher.instance.locale; // <-- Get the system locale
  } catch (e) {
    print('Error getting system locale: $e');
    userLocale = const Locale('en'); // Fallback to English
  }
  await LocalizationService.load(userLocale);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => VpnState()),
        ChangeNotifierProvider(create: (_) {
          final onboardingService = OnboardingService();
          onboardingService.initialize();
          return onboardingService;
        }),
      ],
      child: const App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    // Инициализация deep link сервиса после построения виджета
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final onboardingService = Provider.of<OnboardingService>(context, listen: false);
      DeepLinkService().initialize(onboardingService);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final onboardingService = Provider.of<OnboardingService>(context);

    // If you want to override it manually, do it here (or leave as null to use system):
    // final Locale? manualLocale = const Locale('ru'); // ← override example
    final Locale? manualLocale = null; // ← use system by default

    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'VPN Client',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      locale: manualLocale,
      localeResolutionCallback: (locale, _) {
        try {
          if (locale == null) return const Locale('en');

          // Check for exact match
          final supported = ['en', 'ru', 'th', 'zh'];
          if (supported.contains(locale.languageCode)) {
            return Locale(locale.languageCode);
          }

          // Fallback to 'en' if not found
          return const Locale('en');
        } catch (e) {
          // Log error and return default locale
          print('Error resolving locale: $e');
          return const Locale('en');
        }
      },

      themeMode: themeProvider.themeMode,
      home: onboardingService.shouldShowOnboarding()
          ? OnboardingScreen(onboardingService: onboardingService)
          : const MainScreen(),
      routes: {
        '/main': (context) => const MainScreen(),
      },
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
