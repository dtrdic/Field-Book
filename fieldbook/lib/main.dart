import 'package:fieldbook/com/fieldbook/tracker/activities/field_editor_activity.dart';
import 'package:fieldbook/com/fieldbook/tracker/activities/profile_preferences_activity.dart';
import 'package:fieldbook/com/fieldbook/tracker/activities/scanner_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_routes.dart';
import 'com/fieldbook/tracker/activities/appintro/appintro_activity.dart';
import 'com/fieldbook/tracker/activities/about_activity.dart';
import 'com/fieldbook/tracker/activities/collect/collect_activity.dart';
import 'com/fieldbook/tracker/activities/config_activity.dart';
import 'theme.dart';

void main() => runApp(const FieldBookFlutter());

const MethodChannel _navigationChannel = MethodChannel('com.fieldbook/navigation');


class FieldBookFlutter extends StatefulWidget {
  const FieldBookFlutter({super.key});

  @override
  State<FieldBookFlutter> createState() => _FieldBookFlutterState();
}

class _FieldBookFlutterState extends State<FieldBookFlutter> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _navigationChannel.setMethodCallHandler((call) async {
      if (call.method == 'navigateTo') {
        final String? route = call.arguments as String?;
        if (route != null && _navigatorKey.currentState != null) {
          _navigatorKey.currentState!.pushReplacementNamed(route);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Flutter Demo',
      theme: appTheme.copyWith(
        dividerTheme: const DividerThemeData(
          color: Colors.grey,
          thickness: 1.0,
          space: 0.0,
        ),
      ),
      initialRoute: AppRoute.config.path,
      routes: {
        AppRoute.config.path: (context) => const ConfigActivity(),
        AppRoute.collect.path: (context) => const CollectActivity(),
        AppRoute.about.path: (context) => const AboutActivity(),
        AppRoute.profilePreferences.path: (context) => const ProfilePreferencesActivity(),
        AppRoute.scanner.path: (context) => const ScannerActivity(),
        AppRoute.fieldEditor.path: (context) => const FieldEditorActivity(),
        AppRoute.appIntroActivity.path: (context) => const AppIntroActivity(),
      },

    );
  }
}
