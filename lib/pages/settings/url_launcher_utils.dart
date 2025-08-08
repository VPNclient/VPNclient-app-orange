import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UrlLauncherUtils {
  static Future<bool> launchTelegramBot() async {
    final supportDomain = dotenv.env['TELEGRAM_SUPPORT_DOMAIN'] ?? 'VPNclient_support';
    final botUrl = 'tg://resolve?domain=$supportDomain';

    if (await canLaunchUrl(Uri.parse(botUrl))) {
      await launchUrl(Uri.parse(botUrl), mode: LaunchMode.externalApplication);
      return true;
    }
    return false;
  }
}
