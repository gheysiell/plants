import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static final String apiKey = dotenv.get('API_KEY');
  static const String baseUrl = 'https://zylalabs.com/api/1852/plants+data+api/';
  static const String timeoutExceptionMessage = 'timeout exception in';
  static const String genericExceptionMessage = 'generic exception in';
  static const String badRequestMessage = 'bad request in';
  static const Duration durationTimeoutRemoteHttp = Duration(seconds: 10);
}
