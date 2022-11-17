import 'package:daily_client/daily_client.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<DailyClient>(DailyClient());
}
