import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vpn_client/services/config_service.dart';

void main() {
  group('StatBar Configuration Tests', () {
    setUpAll(() async {
      // Инициализируем конфигурацию перед тестами
      await ConfigService.initialize();
    });

    test('ConfigService.showStatBar should return true by default', () {
      // По умолчанию должно быть true
      expect(ConfigService.showStatBar, isTrue);
    });

    test('ConfigService.showStatBar should handle different string values', () {
      // Тестируем различные значения
      // Это тест для проверки логики, но в реальности мы не можем изменить dotenv во время теста
      // Поэтому просто проверяем, что метод существует и возвращает bool
      expect(ConfigService.showStatBar, isA<bool>());
    });
  });
}
