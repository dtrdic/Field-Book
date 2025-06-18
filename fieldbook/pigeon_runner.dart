import 'package:pigeon/pigeon.dart';

void main(List<String> args) {
  Pigeon.run([
    '--input', 'lib/com/fieldbook/tracker/pigeon/person_name_manager_api.dart',
    '--dart_out', 'lib/com/fieldbook/tracker/pigeon/person_name_manager_api.g.dart',
    '--java_out', '../app/src/main/java/com/fieldbook/tracker/pigeon/PersonNameManagerApiHost.java',
    '--java_package', 'com.fieldbook.tracker.pigeon',
  ]);

  Pigeon.run([
    '--input', 'lib/com/fieldbook/tracker/pigeon/shared_preferences_api.dart',
    '--dart_out', 'lib/com/fieldbook/tracker/pigeon/shared_preferences_api.g.dart',
    '--java_out', '../app/src/main/java/com/fieldbook/tracker/pigeon/SharedPreferencesApiHost.java',
    '--java_package', 'com.fieldbook.tracker.pigeon',
  ]);
}
