import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vpn_client/pages/apps/apps_list_item.dart';
import 'dart:convert';

class SearchDialog extends StatefulWidget {
  final String placeholder;
  final List<Map<String, dynamic>> apps;

  const SearchDialog({
    super.key,
    required this.placeholder,
    required this.apps,
  });

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> _filteredApps;
  List<Map<String, dynamic>> _recentlySearchedApps = [];

  @override
  void initState() {
    super.initState();
    _loadRecentlySearched();
    _filteredApps = widget.apps.where((app) {
      return app['text'] != 'Все приложения';
    }).toList();
    _searchController.addListener(_filterApps);
  }

  Future<void> _loadRecentlySearched() async {
    final prefs = await SharedPreferences.getInstance();
    final String? recentlySearched = prefs.getString('recently_searched_apps');
    if (recentlySearched != null) {
      setState(() {
        _recentlySearchedApps = List<Map<String, dynamic>>.from(jsonDecode(recentlySearched));
      });
    }
  }

  Future<void> _saveRecentlySearched(Map<String, dynamic> app) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _recentlySearchedApps.removeWhere((item) => item['text'] == app['text']);
      _recentlySearchedApps.insert(0, app);
      if (_recentlySearchedApps.length > 5) {
        _recentlySearchedApps = _recentlySearchedApps.sublist(0, 5);
      }
    });
    await prefs.setString('recently_searched_apps', jsonEncode(_recentlySearchedApps));
  }

  void _filterApps() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredApps = widget.apps.where((app) {
        return app['text'].toLowerCase().contains(query) && app['text'] != 'Все приложения';
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Определяем, что показывать в зависимости от состояния
    final isQueryEmpty = _searchController.text.isEmpty;
    final hasRecentSearches = _recentlySearchedApps.isNotEmpty;

    // Логика отображения:
    // 1. Если запрос не пустой, показываем только _filteredApps
    // 2. Если запрос пустой и есть недавно измененные приложения, показываем только _recentlySearchedApps
    // 3. Если запрос пустой и нет недавно измененных приложений, показываем _filteredApps
    final showFilteredApps = !isQueryEmpty || (isQueryEmpty && !hasRecentSearches);
    final showRecentSearches = isQueryEmpty && hasRecentSearches;

    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Поиск',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(widget.apps);
                          },
                          child: const Text(
                            'Готово',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    contentPadding: const EdgeInsets.all(14),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              // Отображаем недавно измененные приложения, если запрос пустой и есть недавно измененные
              if (showRecentSearches)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: const Text(
                        'Недавно искали',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        children: List.generate(_recentlySearchedApps.length, (index) {
                          final app = _recentlySearchedApps[index];
                          return AppListItem(
                            icon: app['icon'],
                            image: app['image'],
                            text: app['text'],
                            isSwitch: app['isSwitch'] ?? false,
                            isActive: app['isActive'] ?? false,
                            isEnabled: true,
                            onTap: () {
                              setState(() {
                                _recentlySearchedApps[index]['isActive'] =
                                !_recentlySearchedApps[index]['isActive'];
                              });
                              final originalIndex = widget.apps.indexWhere(
                                    (item) => item['text'] == app['text'],
                              );
                              if (originalIndex != -1) {
                                widget.apps[originalIndex]['isActive'] =
                                _recentlySearchedApps[index]['isActive'];
                              }
                              _saveRecentlySearched(_recentlySearchedApps[index]);
                            },
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              // Отображаем отфильтрованный список, если запрос не пустой или нет недавно измененных
              Expanded(
                child: showFilteredApps
                    ? _filteredApps.isEmpty
                    ? Center(
                  child: Text(
                    'Ничего не найдено',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  itemCount: _filteredApps.length,
                  itemBuilder: (context, index) {
                    return AppListItem(
                      icon: _filteredApps[index]['icon'],
                      image: _filteredApps[index]['image'],
                      text: _filteredApps[index]['text'],
                      isSwitch: _filteredApps[index]['isSwitch'] ?? false,
                      isActive: _filteredApps[index]['isActive'] ?? false,
                      isEnabled: true,
                      onTap: () {
                        setState(() {
                          _filteredApps[index]['isActive'] =
                          !_filteredApps[index]['isActive'];
                          if (_searchController.text.isNotEmpty) {
                            _saveRecentlySearched(_filteredApps[index]);
                          }
                        });
                        final originalIndex = widget.apps.indexWhere(
                              (app) => app['text'] == _filteredApps[index]['text'],
                        );
                        if (originalIndex != -1) {
                          widget.apps[originalIndex]['isActive'] =
                          _filteredApps[index]['isActive'];
                        }
                      },
                    );
                  },
                )
                    : const SizedBox.shrink(), // Если показываем недавно измененные, скрываем _filteredApps
              ),
              Transform.scale(
                scale: 1.2,
                child: Transform.translate(
                  offset: const Offset(0, 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}