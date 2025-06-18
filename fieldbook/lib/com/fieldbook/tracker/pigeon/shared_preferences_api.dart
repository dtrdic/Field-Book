import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class SharedPreferencesApi {
  String? getString(String key);
  bool setString(String key, String value);
  bool remove(String key);
  List<String> getAllKeys();
}

