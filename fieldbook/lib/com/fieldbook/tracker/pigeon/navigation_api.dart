import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class NavigationApi {
  void onNavigatorPop(String? result);
}

