import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
    initializerName: r'$initCoreComponentDomainGetIt',
    preferRelativeImports: false,
    asExtension: false)
void configureCoreComponentDomainDependencies(final getIt) =>
    $initCoreComponentDomainGetIt(getIt);
