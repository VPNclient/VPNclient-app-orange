import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_dimensions.dart';

/// Тема приложения VPN Client
/// Основана на концепции безопасности и надежности
/// Поддерживает светлую и темную темы
class AppTheme {
  // Приватный конструктор для предотвращения создания экземпляров
  AppTheme._();

  /// Светлая тема приложения
  static ThemeData get lightTheme {
    return ThemeData(
      // Основные цвета
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
      useMaterial3: true,
      
      // Цветовая схема
      colorScheme: AppColors.light,

      // Фон приложения
      scaffoldBackgroundColor: AppColors.lightBackgroundPrimary,

      // AppBar тема
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightNavigationBackground,
        foregroundColor: AppColors.lightNavigationText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.lightNavigationText,
          fontSize: AppDimensions.fontSizeXXL,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Карточки
      cardTheme: CardThemeData(
        color: AppColors.lightCardBackground,
        elevation: AppDimensions.cardElevation,
        shadowColor: AppColors.lightCardShadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
      ),

      // Кнопки
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          foregroundColor: AppColors.buttonText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingXXL,
            vertical: AppDimensions.paddingM,
          ),
          minimumSize: const Size(0, AppDimensions.buttonHeightM),
        ),
      ),

      // Текстовые кнопки
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
        ),
      ),

      // Поля ввода
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightInputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          borderSide: const BorderSide(color: AppColors.lightInputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          borderSide: const BorderSide(color: AppColors.lightInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          borderSide: const BorderSide(color: AppColors.lightInputBorderFocused),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
      ),

      // Переключатели
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.switchActive;
          }
          return AppColors.switchInactive;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.switchActive.withOpacity(0.5);
          }
          return AppColors.switchInactive.withOpacity(0.5);
        }),
      ),

      // Чекбоксы
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(AppColors.buttonText),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
        ),
      ),

      // Радио кнопки
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return AppColors.lightTextSecondary;
        }),
      ),

      // Слайдеры
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.lightBackgroundSecondary,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withOpacity(0.2),
      ),

      // Прогресс индикаторы
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.lightBackgroundSecondary,
      ),

      // Диалоги
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.lightCardBackground,
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.dialogRadius),
        ),
      ),

      // Боттомшит
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.lightCardBackground,
        elevation: AppDimensions.cardElevation,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.dialogRadius),
          ),
        ),
      ),

      // Навигация
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightNavigationBackground,
        selectedItemColor: AppColors.lightNavigationSelected,
        unselectedItemColor: AppColors.lightNavigationUnselected,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Текст
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: AppDimensions.fontSizeDisplay,
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: AppDimensions.fontSizeXXXL,
          fontWeight: FontWeight.bold,
          color: AppColors.lightTextPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: AppDimensions.fontSizeXXL,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: AppDimensions.fontSizeXL,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: AppDimensions.fontSizeL,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: AppDimensions.fontSizeM,
          fontWeight: FontWeight.w600,
          color: AppColors.lightTextPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: AppDimensions.fontSizeL,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: AppDimensions.fontSizeM,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: AppDimensions.fontSizeS,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextSecondary,
        ),
        bodyLarge: TextStyle(
          fontSize: AppDimensions.fontSizeL,
          color: AppColors.lightTextPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: AppDimensions.fontSizeM,
          color: AppColors.lightTextPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: AppDimensions.fontSizeS,
          color: AppColors.lightTextSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: AppDimensions.fontSizeM,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: AppDimensions.fontSizeS,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: AppDimensions.fontSizeXS,
          fontWeight: FontWeight.w500,
          color: AppColors.lightTextTertiary,
        ),
      ),

      // Иконки
      iconTheme: const IconThemeData(
        color: AppColors.lightTextPrimary,
        size: AppDimensions.iconSizeM,
      ),

      // Цвета для состояний
      extensions: [
        _VPNThemeExtension(
          connectedColor: AppColors.vpnConnected,
          disconnectedColor: AppColors.vpnDisconnected,
          connectingColor: AppColors.vpnConnecting,
          disconnectingColor: AppColors.vpnDisconnecting,
        ),
      ],
    );
  }

  /// Темная тема приложения
  static ThemeData get darkTheme {
    return ThemeData(
      // Основные цвета
      primarySwatch: Colors.blue,
      brightness: Brightness.dark,
      useMaterial3: true,
      
      // Цветовая схема
      colorScheme: AppColors.dark,

      // Фон приложения
      scaffoldBackgroundColor: AppColors.darkBackgroundPrimary,

      // AppBar тема
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkNavigationBackground,
        foregroundColor: AppColors.darkNavigationText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.darkNavigationText,
          fontSize: AppDimensions.fontSizeXXL,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Карточки
      cardTheme: CardThemeData(
        color: AppColors.darkCardBackground,
        elevation: AppDimensions.cardElevation,
        shadowColor: AppColors.darkCardShadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
      ),

      // Кнопки
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          foregroundColor: AppColors.buttonText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingXXL,
            vertical: AppDimensions.paddingM,
          ),
          minimumSize: const Size(0, AppDimensions.buttonHeightM),
        ),
      ),

      // Текстовые кнопки
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
        ),
      ),

      // Поля ввода
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkInputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          borderSide: const BorderSide(color: AppColors.darkInputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          borderSide: const BorderSide(color: AppColors.darkInputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          borderSide: const BorderSide(color: AppColors.darkInputBorderFocused),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
      ),

      // Переключатели
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.switchActive;
          }
          return AppColors.switchInactive;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.switchActive.withOpacity(0.5);
          }
          return AppColors.switchInactive.withOpacity(0.5);
        }),
      ),

      // Чекбоксы
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(AppColors.buttonText),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXS),
        ),
      ),

      // Радио кнопки
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return AppColors.darkTextSecondary;
        }),
      ),

      // Слайдеры
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.darkBackgroundSecondary,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withOpacity(0.2),
      ),

      // Прогресс индикаторы
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.darkBackgroundSecondary,
      ),

      // Диалоги
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkCardBackground,
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.dialogRadius),
        ),
      ),

      // Боттомшит
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.darkCardBackground,
        elevation: AppDimensions.cardElevation,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.dialogRadius),
          ),
        ),
      ),

      // Навигация
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkNavigationBackground,
        selectedItemColor: AppColors.darkNavigationSelected,
        unselectedItemColor: AppColors.darkNavigationUnselected,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),

      // Текст
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: AppDimensions.fontSizeDisplay,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: AppDimensions.fontSizeXXXL,
          fontWeight: FontWeight.bold,
          color: AppColors.darkTextPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: AppDimensions.fontSizeXXL,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: AppDimensions.fontSizeXL,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: AppDimensions.fontSizeL,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: AppDimensions.fontSizeM,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: AppDimensions.fontSizeL,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: AppDimensions.fontSizeM,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: AppDimensions.fontSizeS,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextSecondary,
        ),
        bodyLarge: TextStyle(
          fontSize: AppDimensions.fontSizeL,
          color: AppColors.darkTextPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: AppDimensions.fontSizeM,
          color: AppColors.darkTextPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: AppDimensions.fontSizeS,
          color: AppColors.darkTextSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: AppDimensions.fontSizeM,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: AppDimensions.fontSizeS,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: AppDimensions.fontSizeXS,
          fontWeight: FontWeight.w500,
          color: AppColors.darkTextTertiary,
        ),
      ),

      // Иконки
      iconTheme: const IconThemeData(
        color: AppColors.darkTextPrimary,
        size: AppDimensions.iconSizeM,
      ),

      // Цвета для состояний
      extensions: [
        _VPNThemeExtension(
          connectedColor: AppColors.vpnConnected,
          disconnectedColor: AppColors.vpnDisconnected,
          connectingColor: AppColors.vpnConnecting,
          disconnectingColor: AppColors.vpnDisconnecting,
        ),
      ],
    );
  }
}

/// Расширение темы для VPN-специфичных цветов
class _VPNThemeExtension extends ThemeExtension<_VPNThemeExtension> {
  final Color connectedColor;
  final Color disconnectedColor;
  final Color connectingColor;
  final Color disconnectingColor;

  const _VPNThemeExtension({
    required this.connectedColor,
    required this.disconnectedColor,
    required this.connectingColor,
    required this.disconnectingColor,
  });

  @override
  _VPNThemeExtension copyWith({
    Color? connectedColor,
    Color? disconnectedColor,
    Color? connectingColor,
    Color? disconnectingColor,
  }) {
    return _VPNThemeExtension(
      connectedColor: connectedColor ?? this.connectedColor,
      disconnectedColor: disconnectedColor ?? this.disconnectedColor,
      connectingColor: connectingColor ?? this.connectingColor,
      disconnectingColor: disconnectingColor ?? this.disconnectingColor,
    );
  }

  @override
  _VPNThemeExtension lerp(ThemeExtension<_VPNThemeExtension>? other, double t) {
    if (other is! _VPNThemeExtension) {
      return this;
    }
    return _VPNThemeExtension(
      connectedColor: Color.lerp(connectedColor, other.connectedColor, t)!,
      disconnectedColor: Color.lerp(disconnectedColor, other.disconnectedColor, t)!,
      connectingColor: Color.lerp(connectingColor, other.connectingColor, t)!,
      disconnectingColor: Color.lerp(disconnectingColor, other.disconnectingColor, t)!,
    );
  }
} 