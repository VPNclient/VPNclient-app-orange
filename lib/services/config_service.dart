import 'package:flutter_dotenv/flutter_dotenv.dart';

class ConfigService {
  static const String _defaultSubscriptionUrl = "vless://c61daf3e-83ff-424f-a4ff-5bfcb46f0b30@45.77.190.146:8443?encryption=none&flow=&security=reality&sni=www.gstatic.com&fp=chrome&pbk=rLCmXWNVoRBiknloDUsbNS5ONjiI70v-BWQpWq0HCQ0&sid=108108108108#%F0%9F%87%BA%F0%9F%87%B8+%F0%9F%99%8F+USA+%231";

  /// Инициализация конфигурации
  static Future<void> initialize() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      print('Warning: Could not load .env file: $e');
      // Используем значения по умолчанию
    }
  }

  /// Получить основной URL подписки
  static String get mainSubscriptionUrl {
    return dotenv.env['SUBSCRIPTION_URL_MAIN'] ?? _defaultSubscriptionUrl;
  }



  /// Получить все доступные URL подписок
  static List<String> get allSubscriptionUrls {
    final urls = <String>[];
    
    // Основная подписка
    urls.add(mainSubscriptionUrl);
    
    return urls;
  }

  /// Получить настройки серверов по умолчанию
  static Map<String, bool> get defaultServerSettings {
    return {
      'auto': dotenv.env['DEFAULT_SERVER_AUTO']?.toLowerCase() == 'true' ?? true,
      'kazakhstan': dotenv.env['DEFAULT_SERVER_KAZAKHSTAN']?.toLowerCase() == 'true' ?? false,
      'turkey': dotenv.env['DEFAULT_SERVER_TURKEY']?.toLowerCase() == 'true' ?? false,
      'poland': dotenv.env['DEFAULT_SERVER_POLAND']?.toLowerCase() == 'true' ?? false,
    };
  }

  /// Получить название приложения
  static String get appName {
    return dotenv.env['APP_NAME'] ?? 'VPN Client';
  }

  /// Получить версию приложения
  static String get appVersion {
    return dotenv.env['APP_VERSION'] ?? '1.0.12';
  }

  /// Получить URL телеграм бота
  static String get telegramBotUrl {
    return dotenv.env['TELEGRAM_BOT_URL'] ?? 't.me/vpnclientbot';
  }

  /// Получить username телеграм бота (без @)
  static String get telegramBotUsername {
    final url = telegramBotUrl;
    if (url.startsWith('t.me/')) {
      return url.substring(5);
    } else if (url.startsWith('@')) {
      return url.substring(1);
    }
    return url;
  }

  /// Получить полный URL телеграм бота для открытия
  static String get telegramBotFullUrl {
    final username = telegramBotUsername;
    return 'https://t.me/$username';
  }

  /// Получить URL телеграм бота для веб-версии
  static String get telegramBotWebUrl {
    final username = telegramBotUsername;
    return 'https://web.telegram.org/k/#@$username';
  }

  /// Получить название приложения для отображения
  static String get appDisplayName {
    return dotenv.env['APP_NAME'] ?? 'VPNclient';
  }

  /// Получить настройки onboarding
  static bool get showOnboarding {
    return dotenv.env['SHOW_ONBOARDING']?.toLowerCase() == 'true' ?? true;
  }

  /// Проверить, есть ли захардкоженная ссылка на подписку
  static bool get hasHardcodedSubscription {
    final mainUrl = dotenv.env['SUBSCRIPTION_URL_MAIN'];
    
    // Проверяем, что есть непустая ссылка на подписку
    final hasSubscription = (mainUrl?.isNotEmpty == true && mainUrl != _defaultSubscriptionUrl);
    
    print('ConfigService: hasHardcodedSubscription = $hasSubscription');
    print('ConfigService: mainUrl = $mainUrl');
    
    return hasSubscription;
  }

  /// Проверить, требуется ли получение подписки через Telegram бот
  static bool get requiresTelegramBot {
    return !hasHardcodedSubscription;
  }

  /// Проверить, является ли Telegram бот опциональным
  static bool get isTelegramBotOptional {
    return hasHardcodedSubscription;
  }

  /// Проверить, нужно ли показывать onboarding
  static bool get shouldShowOnboarding {
    // Если SUBSCRIPTION_URL_MAIN не настроен, onboarding обязателен
    if (!hasHardcodedSubscription) {
      return true;
    }
    
    // Если SUBSCRIPTION_URL_MAIN настроен, используем настройку SHOW_ONBOARDING
    return showOnboarding;
  }

  /// Проверить, можно ли пропустить onboarding
  static bool get canSkipOnboarding {
    // Если SUBSCRIPTION_URL_MAIN не настроен, пропустить нельзя
    if (!hasHardcodedSubscription) {
      return false;
    }
    
    // Если SUBSCRIPTION_URL_MAIN настроен и SHOW_ONBOARDING=true, можно пропустить
    if (hasHardcodedSubscription && showOnboarding) {
      return true;
    }
    
    // В остальных случаях пропустить нельзя
    return false;
  }

  /// Проверить, загружена ли конфигурация
  static bool get isConfigured {
    return dotenv.env.isNotEmpty;
  }

  /// Проверить, нужно ли отображать верхние виджеты со статистикой
  static bool get showStatBar {
    return dotenv.env['SHOW_STAT_BAR']?.toLowerCase() == 'true' ?? true;
  }
} 