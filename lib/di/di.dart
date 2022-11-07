import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/api/notification_api.dart';

import '../data/local/local_data_manager.dart';
import 'di.config.dart';

GetIt get injector => GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<GetIt> configureDependencies() async {
  injector
    ..registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance(),
    )
    ..registerSingleton<LocalDataManager>(
      await LocalDataManager.init(),
    )
    ..registerSingleton<NotificationApi>(
      await NotificationApi.init(initScheduled: true),
    );
  return $initGetIt(injector);
}
