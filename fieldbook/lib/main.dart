import 'package:fieldbook/com/fieldbook/tracker/activities/field_editor_activity.dart';
import 'package:fieldbook/com/fieldbook/tracker/activities/profile_preferences_activity.dart';
import 'package:fieldbook/com/fieldbook/tracker/activities/scanner_activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_routes.dart';
import 'com/fieldbook/tracker/activities/about_activity.dart';
import 'theme.dart';

void main() => runApp(const MyApp());

const MethodChannel _navigationChannel = MethodChannel('com.fieldbook/navigation');


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _navigationChannel.setMethodCallHandler((call) async {
      if (call.method == 'navigateTo') {
        final String? route = call.arguments as String?;
        if (route != null && _navigatorKey.currentState != null) {
          _navigatorKey.currentState!.pushNamed(route);
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
          indent: 16.0,
          endIndent: 16.0,
        ),
      ),
      initialRoute: AppRoute.home.path,
      routes: {
        AppRoute.home.path: (context) => const MyHomePage(title: ''),
        AppRoute.about.path: (context) => const AboutActivity(),
        AppRoute.profilePreferences.path: (context) => const ProfilePreferencesActivity(),
        AppRoute.scanner.path: (context) => const ScannerActivity(),
        AppRoute.fieldEditor.path: (context) => const FieldEditorActivity(),
      },

    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    // Build the list of routes dynamically from AppRoute enum, skipping home
    final routes = AppRoute.values.where((route) => route != AppRoute.home).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        children: [
          const Text(
            'FieldBook Flutter Home',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            '(Go back)',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ...routes.map((route) => ListTile(
                title: Text(route.displayName),
                onTap: () => Navigator.pushNamed(context, route.path),
                trailing: const Icon(Icons.chevron_right),
              )),
        ],
      ),
    );
  }
}
