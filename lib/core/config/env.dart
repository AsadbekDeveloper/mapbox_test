import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String? _mapboxAccessToken;

  static Future<void> load() async {
    await dotenv.load(fileName: ".env");
    _mapboxAccessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'];
    if (_mapboxAccessToken == null || _mapboxAccessToken!.isEmpty || _mapboxAccessToken == 'your_access_token_here') {
      throw Exception(
          'MAPBOX_ACCESS_TOKEN not found in .env file or is invalid. Please ensure it is set correctly.');
    }
  }

  static String get mapboxAccessToken {
    if (_mapboxAccessToken == null) {
      throw Exception('Env not loaded. Call Env.load() in main.dart before accessing tokens.');
    }
    return _mapboxAccessToken!;
  }
}
