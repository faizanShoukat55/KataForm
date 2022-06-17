
import 'package:get_it/get_it.dart';

import '../../core/services/auth_services.dart';
import '../../core/services/database_services.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerSingleton(AuthService());
  locator.registerSingleton(DatabaseService());
}
