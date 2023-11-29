import 'package:flutter/services.dart';
import 'package:flutter_native_crash/flutter_native_crash.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_native_crash');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('crash', () async {
    try {
      await FlutterNativeCrash.crash();
    } catch (e) {
      expect(e, isAssertionError);
    }
  });
}
