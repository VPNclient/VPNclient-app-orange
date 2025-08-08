import 'package:flutter/material.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';
import 'onboarding_service.dart';

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  StreamSubscription? _subscription;
  OnboardingService? _onboardingService;
  final AppLinks _appLinks = AppLinks();

  /// Инициализация сервиса
  void initialize(OnboardingService onboardingService) {
    _onboardingService = onboardingService;
    _initDeepLinkListener();
  }

  /// Инициализация слушателя deep links
  void _initDeepLinkListener() async {
    // Обработка deep links при запуске приложения
    try {
      final Uri? initialLink = await _appLinks.getInitialAppLink();
      if (initialLink != null) {
        _handleDeepLink(initialLink.toString());
      }
    } catch (e) {
      print('Error getting initial app link: $e');
    }

    // Обработка deep links во время работы приложения
    _subscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri.toString());
      }
    }, onError: (err) {
      print('Deep link error: $err');
    });
  }

  /// Обработка deep link
  void _handleDeepLink(String link) {
    print('Received deep link: $link');
    
    if (link.startsWith('vpnclient://')) {
      // Обработка deep link для завершения onboarding
      if (_onboardingService != null) {
        _onboardingService!.handleDeepLink(link);
      }
    }
  }

  /// Освобождение ресурсов
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _onboardingService = null;
  }
} 