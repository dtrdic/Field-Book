import 'package:fieldbook/app_widgets.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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

  void _showCitationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Citation'),
        content: const Text(
          'Please cite Field Book as:\n\nRife TW, Poland JA. Field Book: An Open-Source Application for Field Data Collection on Android. Crop Science. 2014;54(4):1624-1627.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchEmail(String email, {String? subject}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      query: subject != null ? 'subject=${Uri.encodeComponent(subject)}' : null,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _openAppOrStore(String packageName, String storeUrl) async {
    try {
      // Try to launch the app
      bool launched = await launchUrl(Uri.parse('intent://#Intent;package=$packageName;end'));
      if (!launched) {
        await _launchUrl(storeUrl);
      }
    } catch (_) {
      await _launchUrl(storeUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'About',
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          // App info card (title, version, update, manual, citation, rate)
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text('App Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Field Book'),
                  subtitle: Text('Version: $version'),
                ),
                ListTile(
                  leading: checkingUpdate
                      ? const CircularProgressIndicator()
                      : Icon(isUpdateAvailable ? Icons.system_update : Icons.verified),
                  title: Text(isUpdateAvailable
                      ? 'Update Available: $latestVersion'
                      : 'No Updates'),
                  subtitle: isUpdateAvailable && downloadUrl.isNotEmpty
                      ? const Text('Tap to download')
                      : null,
                  onTap: isUpdateAvailable && downloadUrl.isNotEmpty
                      ? () => _launchUrl(downloadUrl)
                      : null,
                ),
                ListTile(
                  leading: const Icon(Icons.menu_book),
                  title: const Text('Manual'),
                  onTap: () => _launchUrl('https://fieldbook.phenoapps.org/'),
                ),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Citation'),
                  onTap: _showCitationDialog,
                ),
                ListTile(
                  leading: const Icon(Icons.star_rate),
                  title: const Text('Rate this app'),
                  onTap: () => _launchUrl('https://play.google.com/store/apps/details?id=com.fieldbook.tracker'),
                ),
              ],
            ),
          ),
          // Project lead card
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text('Project Lead', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Trife – Project Lead Info'),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: const Text('trife@example.com'),
                  onTap: () => _launchEmail('trife@example.com', subject: 'Field Book Question'),
                ),
              ],
            ),
          ),
          // Contributors & funding card
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text('Support', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('Contributors'),
                  onTap: () => _launchUrl('https://github.com/PhenoApps/Field-Book#-contributors'),
                ),
                ListTile(
                  leading: const Icon(Icons.attach_money),
                  title: const Text('Funding'),
                  onTap: () => _launchUrl('https://github.com/PhenoApps/Field-Book#-funding'),
                ),
              ],
            ),
          ),
          // Technical card (GitHub, libraries)
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text('Technical', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                ListTile(
                  leading: const Icon(Icons.code),
                  title: const Text('GitHub'),
                  onTap: () => _launchUrl('https://github.com/PhenoApps/Field-Book'),
                ),
                ListTile(
                  leading: const Icon(Icons.library_books),
                  title: const Text('Open Source Libraries'),
                  onTap: () => _launchUrl('https://github.com/PhenoApps/Field-Book#-libraries'),
                ),
              ],
            ),
          ),
          // Other apps card
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text('Other Apps', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text('PhenoApps.org'),
                  onTap: () => _launchUrl('http://phenoapps.org/'),
                ),
                ListTile(
                  leading: const Icon(Icons.apps),
                  title: const Text('Coordinate'),
                  onTap: () => _openAppOrStore(
                    'org.wheatgenetics.coordinate',
                    'https://play.google.com/store/apps/details?id=org.wheatgenetics.coordinate',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.apps),
                  title: const Text('Intercross'),
                  onTap: () => _openAppOrStore(
                    'org.phenoapps.intercross',
                    'https://play.google.com/store/apps/details?id=org.phenoapps.intercross',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
