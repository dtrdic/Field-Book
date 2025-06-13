import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AboutActivity extends StatefulWidget {
  const AboutActivity({super.key});

  @override
  State<AboutActivity> createState() => _AboutActivityState();
}

class _AboutActivityState extends State<AboutActivity> {
  String version = '1.0.0'; // current app version placeholder
  String latestVersion = '';
  bool isUpdateAvailable = false;
  bool checkingUpdate = false;
  String downloadUrl = '';

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    setState(() {
      checkingUpdate = true;
    });
    final owner = 'PhenoApps';
    final repo = 'Field-Book';
    final apiUrl = 'https://api.github.com/repos/$owner/$repo/releases/latest';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          latestVersion = data['tag_name'] ?? version;
          downloadUrl = (data['assets'] != null && data['assets'].isNotEmpty)
              ? data['assets'][0]['browser_download_url'] ?? ''
              : '';
          isUpdateAvailable = _isNewerVersion(version, latestVersion);
        });
      }
    } catch (e) {
      // ...existing error handling...
    } finally {
      setState(() {
        checkingUpdate = false;
      });
    }
  }

  bool _isNewerVersion(String current, String latest) {
    List<int> currentParts =
        current.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    List<int> latestParts =
        latest.split('.').map((e) => int.tryParse(e) ?? 0).toList();
    int len = currentParts.length < latestParts.length
        ? currentParts.length
        : latestParts.length;
    for (int i = 0; i < len; i++) {
      if (currentParts[i] < latestParts[i]) {
        return true;
      } else if (currentParts[i] > latestParts[i]) {
        return false;
      }
    }
    return latestParts.length > currentParts.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // App title/version card
          Card(
            child: ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Field Book'),
              subtitle: Text('Version: $version'),
            ),
          ),
          // Update check card
          Card(
            child: ListTile(
              leading: checkingUpdate
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.system_update),
              title: Text(isUpdateAvailable
                  ? 'Update Available: $latestVersion'
                  : 'No Updates'),
              subtitle: isUpdateAvailable && downloadUrl.isNotEmpty
                  ? const Text('Tap to download')
                  : null,
              onTap: isUpdateAvailable && downloadUrl.isNotEmpty
                  ? () {
                      // Implement URL launch (e.g., using url_launcher)
                      // ...existing code for launching URL...
                    }
                  : null,
            ),
          ),
          // Developer info card
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Project Lead'),
              subtitle: const Text('Trife – Project Lead Info'),
            ),
          ),
          // Contact card
          Card(
            child: ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email'),
              subtitle: const Text('trife@example.com'),
              onTap: () {
                // ...existing code to launch email client...
              },
            ),
          ),
          // Contributors card
          Card(
            child: ListTile(
              leading: const Icon(Icons.web),
              title: const Text('Contributors'),
              subtitle: const Text('https://github.com/PhenoApps/Field-Book#-contributors'),
              onTap: () {
                // ...existing code to open website...
              },
            ),
          ),
          // Additional cards can be added here to fully replicate the Java AboutActivity
          // ...existing code...
        ],
      ),
    );
  }
}
