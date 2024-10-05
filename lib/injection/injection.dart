import 'package:forma_app/injection/injection.config.dart';
import 'package:home_feature/injection/injection.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
    initializerName: r'$initGetIt',
    preferRelativeImports: false,
    asExtension: false)
void configureDependencies() {
  configureHomeFeatureDependencies(getIt);
  $initGetIt(getIt);
}
