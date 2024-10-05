import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
    initializerName: r'$initSensorComponentDomainGetIt',
    preferRelativeImports: false,
    asExtension: false)
void configureSensorComponentDomainDependencies(final getIt) =>
    $initSensorComponentDomainGetIt(getIt);
