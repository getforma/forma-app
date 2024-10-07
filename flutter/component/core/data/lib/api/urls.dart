import 'package:injectable/injectable.dart';

const namedApiUrl = 'apiUrl';

@module
abstract class Urls {
  @Named(namedApiUrl)
  String get baseApiUrl => 'https://api.getforma.app';
}
