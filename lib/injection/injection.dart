import 'package:forma_app/injection/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
    initializerName: r'$initGetIt',
    preferRelativeImports: false,
    asExtension: false)
void configureDependencies() {
  $initGetIt(getIt);
}
