import 'package:get_it/get_it.dart';

export "package:get_it/get_it.dart" show GetIt;

final getIt = GetIt.instance;

T di<T extends Object>([String? name]) {
  return getIt<T>(instanceName: name);
}
