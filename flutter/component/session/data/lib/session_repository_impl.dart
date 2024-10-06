import 'package:injectable/injectable.dart';
import 'package:session_component_domain/session_repository.dart';

@LazySingleton(as: SessionRepository)
class SessionRepositoryImpl implements SessionRepository {}
