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

  /// Получить резервный URL подписки
  static String? get backupSubscriptionUrl {
    final url = dotenv.env['SUBSCRIPTION_URL_BACKUP'];
    return url?.isNotEmpty == true ? url : null;
  }

  /// Получить премиум URL подписки
  static String? get premiumSubscriptionUrl {
    final url = dotenv.env['SUBSCRIPTION_URL_PREMIUM'];
    return url?.isNotEmpty == true ? url : null;
  }

  /// Получить все доступные URL подписок
  static List<String> get allSubscriptionUrls {
    final urls = <String>[];
    
    // Основная подписка
    urls.add(mainSubscriptionUrl);
    
    // Резервная подписка
    if (backupSubscriptionUrl != null) {
      urls.add(backupSubscriptionUrl!);
    }
    
    // Премиум подписка
    if (premiumSubscriptionUrl != null) {
      urls.add(premiumSubscriptionUrl!);
    }
    
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

  /// Проверить, загружена ли конфигурация
  static bool get isConfigured {
    return dotenv.env.isNotEmpty;
  }
} 