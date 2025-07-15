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
      theme: appTheme,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const MyHomePage(title: ''),
        AppRoutes.about: (context) => const AboutActivity(),
        AppRoutes.profilePreferences: (context) => const ProfilePreferencesActivity(),
        AppRoutes.scanner: (context) => const ScannerActivity()
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'FieldBook Flutter Home',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              '(Go back)',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
