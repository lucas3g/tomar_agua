import 'package:get_it/get_it.dart';
import 'package:tomar_agua/app/core/shared/controller/alarm_controller.dart';

final GetIt getIt = GetIt.instance;

void configureDependencies() {
  getIt.registerSingleton<AlarmController>(AlarmController());
}
