
import 'dart:async';

import 'package:flutter/services.dart';

class LocalIp {
  static const MethodChannel _channel =
      const MethodChannel('local_ip');

  static Future<String> get ip async {
    final String ip = await _channel.invokeMethod('getIP');
    return ip;
  }
}
