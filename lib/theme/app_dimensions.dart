/// Размеры и отступы приложения VPN Client
/// Обеспечивает консистентность дизайна
class AppDimensions {
  // Приватный конструктор для предотвращения создания экземпляров
  AppDimensions._();

  // Отступы
  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 12.0;
  static const double paddingL = 16.0;
  static const double paddingXL = 20.0;
  static const double paddingXXL = 24.0;
  static const double paddingXXXL = 32.0;

  // Радиусы скругления
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double borderRadius = radiusM; // Алиас для совместимости

  // Размеры иконок
  static const double iconSizeXS = 12.0;
  static const double iconSizeS = 16.0;
  static const double iconSizeM = 24.0;
  static const double iconSizeL = 32.0;
  static const double iconSizeXL = 48.0;
  static const double iconSizeXXL = 64.0;

  // Высоты элементов
  static const double buttonHeightS = 32.0;
  static const double buttonHeightM = 40.0;
  static const double buttonHeightL = 48.0;
  static const double buttonHeightXL = 56.0;

  static const double inputHeightS = 32.0;
  static const double inputHeightM = 40.0;
  static const double inputHeightL = 48.0;

  static const double appBarHeight = 56.0;
  static const double bottomNavigationHeight = 80.0;

  // Размеры карточек
  static const double cardPadding = paddingL;
  static const double cardRadius = radiusL;
  static const double cardElevation = 2.0;

  // Размеры диалогов
  static const double dialogRadius = radiusL;
  static const double dialogPadding = paddingXL;

  // Размеры прогресс-баров
  static const double progressBarHeight = 8.0;
  static const double progressBarRadius = radiusXS;

  // Размеры чипов
  static const double chipHeight = 32.0;
  static const double chipRadius = radiusXL;

  // Размеры аватаров
  static const double avatarSizeS = 32.0;
  static const double avatarSizeM = 48.0;
  static const double avatarSizeL = 64.0;
  static const double avatarSizeXL = 80.0;
  static const double avatarSizeXXL = 100.0;

  // Размеры изображений
  static const double imageSizeS = 64.0;
  static const double imageSizeM = 96.0;
  static const double imageSizeL = 128.0;
  static const double imageSizeXL = 192.0;

  // Размеры сетки
  static const int gridCrossAxisCount = 2;
  static const double gridSpacing = paddingL;
  static const double gridChildAspectRatio = 1.0;

  // Размеры списков
  static const double listItemHeight = 56.0;
  static const double listItemPadding = paddingL;

  // Размеры навигации
  static const double navigationItemHeight = 48.0;
  static const double navigationItemPadding = paddingL;

  // Размеры для мобильных устройств
  static const double mobileMaxWidth = 600.0;
  static const double tabletMaxWidth = 1200.0;

  // Размеры для VPN элементов
  static const double vpnButtonSize = 120.0;
  static const double vpnStatusIndicatorSize = 16.0;
  static const double vpnServerCardHeight = 80.0;
  static const double vpnConnectionIndicatorSize = 24.0;

  // Размеры для анимаций
  static const Duration animationDurationFast = Duration(milliseconds: 200);
  static const Duration animationDurationNormal = Duration(milliseconds: 300);
  static const Duration animationDurationSlow = Duration(milliseconds: 500);

  // Размеры шрифтов
  static const double fontSizeXS = 10.0;
  static const double fontSizeS = 12.0;
  static const double fontSizeM = 14.0;
  static const double fontSizeL = 16.0;
  static const double fontSizeXL = 18.0;
  static const double fontSizeXXL = 20.0;
  static const double fontSizeXXXL = 24.0;
  static const double fontSizeDisplay = 32.0;

  // Высоты строк
  static const double lineHeightXS = 14.0;
  static const double lineHeightS = 16.0;
  static const double lineHeightM = 20.0;
  static const double lineHeightL = 24.0;
  static const double lineHeightXL = 28.0;
  static const double lineHeightXXL = 32.0;

  // Размеры для VPN статуса
  static const double vpnStatusTextSize = fontSizeL;
  static const double vpnStatusIconSize = iconSizeM;
  static const double vpnConnectionProgressSize = 80.0;

  // Размеры для серверов
  static const double serverListTileHeight = 72.0;
  static const double serverFlagSize = 24.0;
  static const double serverPingIndicatorSize = 8.0;

  // Размеры для настроек
  static const double settingsItemHeight = 56.0;
  static const double settingsIconSize = iconSizeM;
  static const double settingsSwitchSize = 40.0;

  // Размеры для уведомлений
  static const double notificationHeight = 64.0;
  static const double notificationIconSize = iconSizeM;
  static const double notificationRadius = radiusM;

  // Размеры для модальных окон
  static const double modalRadius = radiusL;
  static const double modalPadding = paddingXL;
  static const double modalMaxWidth = 400.0;

  // Размеры для загрузки
  static const double loadingSpinnerSize = 32.0;
  static const double loadingTextSize = fontSizeM;

  // Размеры для ошибок
  static const double errorIconSize = iconSizeXL;
  static const double errorTextSize = fontSizeL;

  // Размеры для успеха
  static const double successIconSize = iconSizeXL;
  static const double successTextSize = fontSizeL;

  // Размеры для предупреждений
  static const double warningIconSize = iconSizeL;
  static const double warningTextSize = fontSizeM;

  // Размеры для информации
  static const double infoIconSize = iconSizeL;
  static const double infoTextSize = fontSizeM;

  // Размеры для кнопок VPN
  static const double vpnConnectButtonSize = 120.0;
  static const double vpnDisconnectButtonSize = 120.0;
  static const double vpnButtonIconSize = iconSizeXL;

  // Размеры для индикаторов состояния
  static const double statusIndicatorSize = 12.0;
  static const double statusIndicatorBorderWidth = 2.0;

  // Размеры для градиентов
  static const double gradientRadius = radiusL;
  static const double gradientOpacity = 0.8;

  // Размеры для теней
  static const double shadowBlurRadius = 4.0;
  static const double shadowSpreadRadius = 0.0;
  static const double shadowOffsetX = 0.0;
  static const double shadowOffsetY = 2.0;

  // Размеры для анимаций VPN
  static const Duration vpnConnectionAnimationDuration = Duration(milliseconds: 1000);
  static const Duration vpnStatusChangeAnimationDuration = Duration(milliseconds: 300);
  static const Duration vpnButtonPressAnimationDuration = Duration(milliseconds: 150);

  // Размеры для вибрации
  static const Duration hapticFeedbackDuration = Duration(milliseconds: 50);

  // Размеры для звуков
  static const Duration soundEffectDuration = Duration(milliseconds: 500);

  // Размеры для уведомлений системы
  static const double systemNotificationIconSize = 24.0;
  static const double systemNotificationTextSize = fontSizeS;

  // Размеры для глубоких ссылок
  static const double deepLinkButtonSize = 48.0;
  static const double deepLinkIconSize = iconSizeM;

  // Размеры для аналитики
  static const double analyticsEventSize = 1.0; // Минимальный размер для отслеживания

  // Размеры для кэширования
  static const int cacheMaxSize = 100; // Максимальное количество элементов в кэше
  static const Duration cacheExpirationDuration = Duration(hours: 24);

  // Размеры для сетевых запросов
  static const Duration networkTimeoutDuration = Duration(seconds: 30);
  static const Duration networkRetryDelay = Duration(seconds: 5);
  static const int networkMaxRetries = 3;

  // Размеры для логирования
  static const int logMaxLines = 1000;
  static const Duration logRotationInterval = Duration(hours: 24);

  // Размеры для безопасности
  static const int passwordMinLength = 8;
  static const int passwordMaxLength = 128;
  static const Duration sessionTimeoutDuration = Duration(hours: 24);

  // Размеры для производительности
  static const int maxConcurrentOperations = 4;
  static const Duration operationTimeoutDuration = Duration(seconds: 60);
  static const int maxMemoryUsageMB = 512;

  // Размеры для доступности
  static const double minimumTouchTargetSize = 44.0;
  static const double minimumTextSize = fontSizeM;
  static const double minimumContrastRatio = 4.5;

  // Размеры для тестирования
  static const Duration testTimeoutDuration = Duration(seconds: 30);
  static const int testMaxRetries = 3;
  static const Duration testRetryDelay = Duration(seconds: 1);
} 