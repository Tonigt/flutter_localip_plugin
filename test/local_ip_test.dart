import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_ip/local_ip.dart';

void main() {
  const MethodChannel channel = MethodChannel('local_ip');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getIP', () async {
    expect(await LocalIp.ip, '42');
  });
}
