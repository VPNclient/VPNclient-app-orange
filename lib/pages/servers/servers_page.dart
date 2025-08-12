import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_client/pages/servers/servers_list.dart';
import 'package:vpn_client/search_dialog.dart';
import 'package:vpn_client/localization_service.dart';
import 'package:vpn_client/theme/app_colors.dart';

class ServersPage extends StatefulWidget {
  final Function(int) onNavBarTap;
  const ServersPage({super.key, required this.onNavBarTap});

  @override
  State<ServersPage> createState() => ServersPageState();
}

class ServersPageState extends State<ServersPage> {
  List<Map<String, dynamic>> _servers = [];

  void _showSearchDialog(BuildContext context) async {
    if (_servers.isNotEmpty) {
      final updatedServers = await showDialog<List<Map<String, dynamic>>>(
        context: context,
        builder: (BuildContext context) {
          return SearchDialog(
            placeholder: LocalizationService.to('country_name'),
            items: _servers,
            type: 2,
          );
        },
      );

      if (updatedServers != null) {
        setState(() {
          _servers = updatedServers;
        });

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('selected_servers', jsonEncode(updatedServers));
      }
    } else {
      debugPrint('Servers list is empty, cannot show search dialog');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark 
          ? AppColors.darkBackgroundPrimary 
          : AppColors.lightBackgroundPrimary,
      appBar: AppBar(
        title: Text(
          LocalizationService.to('selected_server'),
          style: TextStyle(
            color: isDark 
                ? AppColors.darkTextPrimary 
                : AppColors.lightTextPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDark 
            ? AppColors.darkBackgroundPrimary 
            : AppColors.lightBackgroundPrimary,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDark 
              ? AppColors.darkTextPrimary 
              : AppColors.lightTextPrimary,
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 20),
            child: Transform.flip(
              flipX: true,
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: isDark 
                      ? AppColors.darkTextPrimary 
                      : AppColors.lightTextPrimary,
                  size: 28,
                ),
                onPressed: () => _showSearchDialog(context),
                tooltip: LocalizationService.to('search'),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Информационная панель
          Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark 
                  ? AppColors.darkCardBackground 
                  : AppColors.lightCardBackground,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: isDark 
                      ? AppColors.darkCardShadow.withOpacity(0.2)
                      : AppColors.lightCardShadow.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppColors.info,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    LocalizationService.to('select_best_server'),
                    style: TextStyle(
                      color: isDark 
                          ? AppColors.darkTextSecondary 
                          : AppColors.lightTextSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Список серверов
          Expanded(
            child: ServersList(
              onServersLoaded: (servers) {
                setState(() {
                  _servers = servers;
                });
              },
              servers: _servers,
            ),
          ),
        ],
      ),
    );
  }
}
