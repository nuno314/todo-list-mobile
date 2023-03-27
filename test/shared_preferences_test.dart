import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  });

  group('SharedPreferences', () {
    test('test writing and reading string', () async {
      // Given
      const expectedValue = 'Something';
      // When
      await prefs.setString('key', expectedValue);
      final actualValue = prefs.getString('key');
      // Then
      expect(actualValue, equals(expectedValue));
    });

    test('test remove string from shared preferences', () async {
      // Given
      const value = 'Something';
      // When
      await prefs.setString('key', value);
      final actualValue = await prefs.remove('key');
      // Then
      expect(actualValue, true);
      expect(prefs.containsKey('key'), false);
    });
  });
}
