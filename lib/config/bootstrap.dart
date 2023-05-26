import 'env.dart';
import 'service_locator.dart';

Future<void> bootstrap() async {
  await setupEnv();
  setupServiceLocators();
}
