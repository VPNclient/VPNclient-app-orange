import 'package:flutter/material.dart';

/// Цветовая палитра приложения VPN Client
/// Основана на концепции безопасности и надежности
/// Поддерживает светлую и темную темы
class AppColors {
  // Приватный конструктор для предотвращения создания экземпляров
  AppColors._();

  // Основные цвета (одинаковые для обеих тем)
  static const Color primary = Color(0xFF4A90E2); // Синий для доверия и безопасности
  static const Color secondary = Color(0xFF6B9BD4); // Более светлый синий
  static const Color accent = Color(0xFF7FB3E8); // Очень светлый синий

  // Цвета состояний VPN (одинаковые для обеих тем)
  static const Color connected = Color(0xFF10B981); // Зеленый для подключенного состояния
  static const Color disconnected = Color(0xFFEF4444); // Красный для отключенного состояния
  static const Color connecting = Color(0xFFF59E0B); // Оранжевый для подключения
  static const Color disconnecting = Color(0xFFF59E0B); // Оранжевый для отключения

  // Цвета состояний (одинаковые для обеих тем)
  static const Color success = Color(0xFF10B981); // Зеленый для успеха
  static const Color warning = Color(0xFFF59E0B); // Оранжевый для предупреждений
  static const Color error = Color(0xFFEF4444); // Красный для ошибок
  static const Color info = Color(0xFF3B82F6); // Синий для информации

  // Светлая тема
  static const ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    secondary: secondary,
    surface: Color(0xFFFFFFFF), // Белый
    background: Color(0xFFF8FAFC), // Очень светлый серо-белый
    error: error,
    onPrimary: Color(0xFFFFFFFF), // Белый
    onSecondary: Color(0xFFFFFFFF), // Белый
    onSurface: Color(0xFF1E293B), // Темно-серый
    onBackground: Color(0xFF1E293B), // Темно-серый
    onError: Color(0xFFFFFFFF), // Белый
  );

  // Темная тема
  static const ColorScheme dark = ColorScheme(
    brightness: Brightness.dark,
    primary: primary,
    secondary: secondary,
    surface: Color(0xFF1E293B), // Темно-серый
    background: Color(0xFF0F172A), // Очень темный синий
    error: error,
    onPrimary: Color(0xFFFFFFFF), // Белый
    onSecondary: Color(0xFFFFFFFF), // Белый
    onSurface: Color(0xFFF1F5F9), // Светло-серый
    onBackground: Color(0xFFF1F5F9), // Светло-серый
    onError: Color(0xFFFFFFFF), // Белый
  );

  // Фоновые цвета для светлой темы
  static const Color lightBackgroundPrimary = Color(0xFFF8FAFC); // Очень светлый серо-белый
  static const Color lightBackgroundSecondary = Color(0xFFE2E8F0); // Светло-серый
  static const Color lightBackgroundTertiary = Color(0xFFCBD5E1); // Средне-серый

  // Фоновые цвета для темной темы
  static const Color darkBackgroundPrimary = Color(0xFF0F172A); // Очень темный синий
  static const Color darkBackgroundSecondary = Color(0xFF1E293B); // Темно-серый
  static const Color darkBackgroundTertiary = Color(0xFF334155); // Средне-темный серый

  // Цвета текста для светлой темы
  static const Color lightTextPrimary = Color(0xFF1E293B); // Темно-серый для основного текста
  static const Color lightTextSecondary = Color(0xFF64748B); // Средне-серый для второстепенного текста
  static const Color lightTextTertiary = Color(0xFF94A3B8); // Светло-серый для третичного текста

  // Цвета текста для темной темы
  static const Color darkTextPrimary = Color(0xFFF1F5F9); // Светло-серый для основного текста
  static const Color darkTextSecondary = Color(0xFFCBD5E1); // Средне-серый для второстепенного текста
  static const Color darkTextTertiary = Color(0xFF94A3B8); // Темно-серый для третичного текста

  // Цвета для карточек и элементов интерфейса (светлая тема)
  static const Color lightCardBackground = Color(0xFFFFFFFF); // Белый
  static const Color lightCardShadow = Color(0xFFE2E8F0); // Светло-серый
  static const Color lightSurfaceLight = Color(0xFFF1F5F9); // Очень светлый серо-белый

  // Цвета для карточек и элементов интерфейса (темная тема)
  static const Color darkCardBackground = Color(0xFF1E293B); // Темно-серый
  static const Color darkCardShadow = Color(0xFF0F172A); // Очень темный синий
  static const Color darkSurfaceLight = Color(0xFF334155); // Средне-темный серый

  // Цвета для навигации (светлая тема)
  static const Color lightNavigationBackground = Color(0xFFFFFFFF); // Белый
  static const Color lightNavigationText = Color(0xFF1E293B); // Темно-серый
  static const Color lightNavigationSelected = primary; // Основной цвет
  static const Color lightNavigationUnselected = Color(0xFF94A3B8); // Светло-серый

  // Цвета для навигации (темная тема)
  static const Color darkNavigationBackground = Color(0xFF1E293B); // Темно-серый
  static const Color darkNavigationText = Color(0xFFF1F5F9); // Светло-серый
  static const Color darkNavigationSelected = primary; // Основной цвет
  static const Color darkNavigationUnselected = Color(0xFF64748B); // Средне-серый

  // Цвета для кнопок
  static const Color buttonPrimary = primary; // Основной цвет
  static const Color buttonSecondary = Color(0xFFE2E8F0); // Светло-серый
  static const Color buttonText = Color(0xFFFFFFFF); // Белый
  static const Color buttonTextSecondary = Color(0xFF1E293B); // Темно-серый

  // Цвета для полей ввода (светлая тема)
  static const Color lightInputBackground = Color(0xFFFFFFFF); // Белый
  static const Color lightInputBorder = Color(0xFFE2E8F0); // Светло-серый
  static const Color lightInputBorderFocused = primary; // Основной цвет

  // Цвета для полей ввода (темная тема)
  static const Color darkInputBackground = Color(0xFF1E293B); // Темно-серый
  static const Color darkInputBorder = Color(0xFF334155); // Средне-темный серый
  static const Color darkInputBorderFocused = primary; // Основной цвет

  // Цвета для переключателей
  static const Color switchActive = primary; // Основной цвет
  static const Color switchInactive = Color(0xFFCBD5E1); // Средне-серый

  // Цвета для VPN статуса
  static const Color vpnConnected = connected; // Зеленый для подключенного состояния
  static const Color vpnDisconnected = disconnected; // Красный для отключенного состояния
  static const Color vpnConnecting = connecting; // Оранжевый для подключения
  static const Color vpnDisconnecting = disconnecting; // Оранжевый для отключения

  // Цвета для индикаторов скорости и качества соединения
  static const Color speedExcellent = Color(0xFF10B981); // Зеленый для отличной скорости (< 50ms)
  static const Color speedGood = Color(0xFFF59E0B); // Оранжевый для хорошей скорости (50-100ms)
  static const Color speedFair = Color(0xFFF59E0B); // Оранжевый для удовлетворительной скорости (100-200ms)
  static const Color speedPoor = Color(0xFFEF4444); // Красный для плохой скорости (> 200ms)

  // Цвета для индикаторов загрузки/выгрузки
  static const Color downloadActive = Color(0xFF3B82F6); // Синий для активной загрузки
  static const Color uploadActive = Color(0xFF8B5CF6); // Фиолетовый для активной выгрузки
  static const Color pingActive = Color(0xFF10B981); // Зеленый для активного пинга

  // Цвета для градиентов (светлая тема)
  static const List<Color> lightBackgroundGradient = [
    lightBackgroundPrimary,
    lightBackgroundSecondary,
    lightBackgroundTertiary,
  ];

  static const List<Color> lightCardGradient = [
    lightCardBackground,
    lightSurfaceLight,
  ];

  // Цвета для градиентов (темная тема)
  static const List<Color> darkBackgroundGradient = [
    darkBackgroundPrimary,
    darkBackgroundSecondary,
    darkBackgroundTertiary,
  ];

  static const List<Color> darkCardGradient = [
    darkCardBackground,
    darkSurfaceLight,
  ];

  // Основной градиент приложения
  static const LinearGradient mainGradient = LinearGradient(
    colors: [Color(0xFFFBB800), Color(0xFFEA7500)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Градиент для VPN статуса
  static const LinearGradient vpnConnectedGradient = LinearGradient(
    colors: [connected, Color(0xFF059669)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient vpnDisconnectedGradient = LinearGradient(
    colors: [disconnected, Color(0xFFDC2626)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient vpnConnectingGradient = LinearGradient(
    colors: [connecting, Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
} 