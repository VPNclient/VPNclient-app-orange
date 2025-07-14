import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static Future<bool> launchTelegramBot() async {
    const botUrl = 'tg://resolve?domain=VPNclient_support';

    if (await canLaunchUrl(Uri.parse(botUrl))) {
      await launchUrl(Uri.parse(botUrl), mode: LaunchMode.externalApplication);
      return true;
    }
    return false;
  }
}
