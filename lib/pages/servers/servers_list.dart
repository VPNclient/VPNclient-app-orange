import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_client/pages/servers/servers_list_item.dart';
import 'package:vpn_client/localization_service.dart';
import 'dart:convert';
import 'package:vpn_client/theme/app_colors.dart';

class ServersList extends StatefulWidget {
  final Function(List<Map<String, dynamic>>)? onServersLoaded;
  final List<Map<String, dynamic>> servers;

  const ServersList({
    super.key,
    this.onServersLoaded,
    required this.servers,
  });

  get onNavBarTap => null;

  @override
  State<ServersList> createState() => _ServersListState();
}

class _ServersListState extends State<ServersList> {
  List<Map<String, dynamic>> _servers = [];
  bool _isLoading = true;
  bool _isSortedByPing = false;

  @override
  void initState() {
    super.initState();
    if (widget.servers.isNotEmpty) {
      _servers = List.from(widget.servers);
      _isLoading = false;
      if (widget.onServersLoaded != null) {
        widget.onServersLoaded!(_servers);
      }
    } else {
      _loadServers();
    }
  }

  @override
  void didUpdateWidget(ServersList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.servers != widget.servers) {
      _servers = List.from(widget.servers);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_servers.isEmpty) {
      _loadServers();
    }
  }

  Future<void> _loadServers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Map<String, dynamic>> serversList = [
        {
          'icon': 'assets/images/flags/auto.svg',
          'text': LocalizationService.to('auto_select'),
          'ping': LocalizationService.to('fastest'),
          'isActive': true,
        },
        {
          'icon': 'assets/images/flags/Kazahstan.svg',
          'text': LocalizationService.to('kazakhstan'),
          'ping': '48',
          'isActive': false,
        },
        {
          'icon': 'assets/images/flags/Turkey.svg',
          'text': LocalizationService.to('turkey'),
          'ping': '142',
          'isActive': false,
        },
        {
          'icon': 'assets/images/flags/Poland.svg',
          'text': LocalizationService.to('poland'),
          'ping': '298',
          'isActive': false,
        },
      ];

      final prefs = await SharedPreferences.getInstance();
      final String? savedServers = prefs.getString('selected_servers');
      if (savedServers != null) {
        final List<dynamic> savedServersList = jsonDecode(savedServers);
        for (var savedApp in savedServersList) {
          final index = serversList.indexWhere(
            (server) => server['text'] == savedApp['text'],
          );
          if (index != -1) {
            serversList[index]['isActive'] = savedApp['isActive'];
          }
        }
      }

      setState(() {
        _servers = serversList;
        _isLoading = false;
      });

      if (widget.onServersLoaded != null) {
        widget.onServersLoaded!(_servers);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Error loading servers: $e');
    }
  }

  Future<void> _saveSelectedServers() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedServers =
        _servers
            .map(
              (server) => {
                'text': server['text'],
                'isActive': server['isActive'],
                'icon': server['icon'],
                'ping': server['ping'],
              },
            )
            .toList();
    await prefs.setString('selected_servers', jsonEncode(selectedServers));
  }

  List<Map<String, dynamic>> get servers => _servers;

  void _onItemTapped(int index) {
    setState(() {
      for (int i = 0; i < _servers.length; i++) {
        _servers[i]['isActive'] = false;
      }
      _servers[index]['isActive'] = true;
    });

    _saveSelectedServers();
    if (widget.onServersLoaded != null) {
      widget.onServersLoaded!(_servers);
    }

    if (widget.onNavBarTap != null) {
      widget.onNavBarTap!(2);
    }
  }

  void _sortServersByPing() {
    setState(() {
      _isSortedByPing = !_isSortedByPing;
      
      if (_isSortedByPing) {
        _servers.sort((a, b) {
          final pingA = _getPingValue(a['ping']);
          final pingB = _getPingValue(b['ping']);
          return pingA.compareTo(pingB);
        });
      } else {
        _loadServers(); // Восстанавливаем исходный порядок
      }
    });
  }

  int _getPingValue(String? ping) {
    if (ping == null || ping == 'fastest') return 0;
    return int.tryParse(ping) ?? 999;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeServers =
        _servers.where((server) => server['isActive'] == true).toList();
    final inactiveServers =
        _servers.where((server) => server['isActive'] != true).toList();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      decoration: BoxDecoration(
        color: isDark 
            ? AppColors.darkBackgroundPrimary 
            : AppColors.lightBackgroundPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child:
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                )
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Статистика серверов
                    if (_servers.isNotEmpty) ...[
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
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
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildStatItem(
                                  context, 
                                  '${_servers.length}', 
                                  LocalizationService.to('total_servers'),
                                  Icons.dns,
                                  isDark,
                                ),
                                _buildStatItem(
                                  context, 
                                  '${activeServers.length}', 
                                  LocalizationService.to('active_servers'),
                                  Icons.check_circle,
                                  isDark,
                                ),
                                _buildStatItem(
                                  context, 
                                  '${_getAveragePing()}', 
                                  LocalizationService.to('avg_ping'),
                                  Icons.speed,
                                  isDark,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Кнопка сортировки
                            Container(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _sortServersByPing,
                                icon: Icon(
                                  _isSortedByPing ? Icons.sort : Icons.sort_by_alpha,
                                  color: isDark 
                                      ? AppColors.darkTextPrimary 
                                      : AppColors.lightTextPrimary,
                                ),
                                label: Text(
                                  _isSortedByPing 
                                      ? LocalizationService.to('sort_by_name')
                                      : LocalizationService.to('sort_by_ping'),
                                  style: TextStyle(
                                    color: isDark 
                                        ? AppColors.darkTextPrimary 
                                        : AppColors.lightTextPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary.withOpacity(0.1),
                                  foregroundColor: AppColors.primary,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (activeServers.isNotEmpty) ...[
                      Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 12),
                        child: Text(
                          LocalizationService.to('selected_server'),
                          style: TextStyle(
                            color: isDark 
                                ? AppColors.darkTextSecondary 
                                : AppColors.lightTextSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ...List.generate(activeServers.length, (index) {
                        final server = activeServers[index];
                        return ServerListItem(
                          icon: server['icon'],
                          text: server['text'],
                          ping: server['ping'],
                          isActive: server['isActive'],
                          onTap: () => _onItemTapped(_servers.indexOf(server)),
                        );
                      }),
                    ],
                    if (inactiveServers.isNotEmpty) ...[
                      Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 12, top: 20),
                        child: Text(
                          LocalizationService.to('all_servers'),
                          style: TextStyle(
                            color: isDark 
                                ? AppColors.darkTextSecondary 
                                : AppColors.lightTextSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      ...List.generate(inactiveServers.length, (index) {
                        final server = inactiveServers[index];
                        return ServerListItem(
                          icon: server['icon'],
                          text: server['text'],
                          ping: server['ping'],
                          isActive: server['isActive'],
                          onTap: () => _onItemTapped(_servers.indexOf(server)),
                        );
                      }),
                    ],
                  ],
                ),
              ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label, IconData icon, bool isDark) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: isDark 
                ? AppColors.darkTextPrimary 
                : AppColors.lightTextPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: isDark 
                ? AppColors.darkTextSecondary 
                : AppColors.lightTextSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _getAveragePing() {
    int totalPing = 0;
    int validPings = 0;
    
    for (var server in _servers) {
      final ping = server['ping'];
      if (ping != null && ping != 'fastest') {
        final pingValue = int.tryParse(ping);
        if (pingValue != null) {
          totalPing += pingValue;
          validPings++;
        }
      }
    }
    
    if (validPings == 0) return '0';
    return '${(totalPing / validPings).round()}';
  }
}
