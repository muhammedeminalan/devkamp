import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:app/config/di/injection_container.config.dart';

final GetIt sl = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> setupDependencies() async {
  await sl.init();
}
