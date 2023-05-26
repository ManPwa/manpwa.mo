import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> setupEnv() async {
  await dotenv.load(fileName: ".env");
}

class EnvVariables {
  static final kAPIBaseUrl = dotenv.get('API_BASE_URL');
}
