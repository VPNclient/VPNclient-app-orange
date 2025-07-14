import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import
import 'package:vpn_client/localization_service.dart';
import 'setting_info_card.dart';
import 'support_service_card.dart';
import 'package:vpn_client/utility/clean_scroll.dart';
import 'action_button.dart';
import 'reset_settings_dialog.dart';
import 'snackbar_utils.dart';
import 'url_launcher_utils.dart';

class SettingPage extends StatefulWidget {
  final Function(int) onNavBarTap;

  const SettingPage({super.key, required this.onNavBarTap});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isConnected = true;
  String _connectionStatus = '1 me/vnp_client_bot';
  String _supportStatus = '1 me/vnp_client_support';
  String _userId = '2485926342';

  @override
  void initState() {
    super.initState();
    _loadSettings(); // Load saved state on page start
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isConnected = prefs.getBool('isConnected') ?? true;
      _connectionStatus =
          prefs.getString('connectionStatus') ?? '1 me/vnp_client_bot';
      _supportStatus =
          prefs.getString('supportStatus') ?? '1 me/vnp_client_support';
      _userId = prefs.getString('userId') ?? '2485926342';
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isConnected', _isConnected);
    await prefs.setString('connectionStatus', _connectionStatus);
    await prefs.setString('supportStatus', _supportStatus);
    await prefs.setString('userId', _userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text(
          LocalizationService.to('settings'),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: const SizedBox(),
      ),
      body: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SettingInfoCard(
                isConnected: _isConnected,
                connectionStatus: _connectionStatus,
                supportStatus: _supportStatus,
                userId: _userId,
              ),
              const SizedBox(height: 20),
              SupportServiceCard(
                onTap: () {
                  _connectToBot();
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ActionButton(
                  isConnected: _isConnected,
                  onResetPressed: _showResetDialog,
                  onConnectPressed: _connectToBot,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResetDialog() async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const ResetSettingsDialog(),
    );

    if (result == true) {
      _resetSettings();
    }
  }

  void _resetSettings() async {
    setState(() {
      _isConnected = false;
      _connectionStatus = '';
      _supportStatus = '';
      _userId = '';
    });

    await _saveSettings(); // Save updated state persistently

    if (!mounted) return;
    SnackbarUtils.showResetSuccessSnackbar(context);
  }

  void _connectToBot() async {
    final success = await UrlLauncherUtils.launchTelegramBot();

    if (!mounted) return;

    if (!success) {
      SnackbarUtils.showTelegramErrorSnackbar(context);
    }
  }
}
