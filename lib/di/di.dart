import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  $initGetIt(getIt);
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(
    (log) => print('${log.level.name}: ${log.time}: ${log.message}'),
  );
}
