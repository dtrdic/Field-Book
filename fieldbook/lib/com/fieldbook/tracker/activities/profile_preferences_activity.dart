import 'package:device_info_plus/device_info_plus.dart';
import 'package:fieldbook/app_widgets.dart';
import 'package:flutter/material.dart';
import '../pigeon/person_name_manager_api.g.dart';
import '../pigeon/shared_preferences_api.g.dart';

class ProfilePreferencesActivity extends StatefulWidget {
  const ProfilePreferencesActivity({Key? key}) : super(key: key);

  @override
  State<ProfilePreferencesActivity> createState() => _ProfilePreferencesActivityState();
}

class _ProfilePreferencesActivityState extends State<ProfilePreferencesActivity> {
  final _prefs = SharedPreferencesApi();
  final _personApi = PersonNameManagerApi();

  String? _firstName;
  String? _lastName;
  String? _deviceName;
  String? _verificationInterval;
  final String _verificationIntervalKey = 'com.tracker.fieldbook.preference.profile_verification_interval';
  final List<String> _intervalOptions = [
    'Every time app is opened', // @string/verification_interval_every_open
    'Every 12 hours',           // @string/verification_interval_every_12
    'Every 24 hours',           // @string/verification_interval_every_24
    'Never',                    // @string/verification_interval_never
  ];
  final List<String> _intervalValues = ['0', '1', '2', '3'];
  List<PersonName?> _savedNames = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<String> _getDefaultDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.model ?? 'Device';
  }

  Future<void> _loadProfile() async {
    final first = await _prefs.getString('FirstName');
    final last = await _prefs.getString('LastName');
    final device = await _prefs.getString('DeviceName');
    // Use the same key as Android for verification interval
    final intervalValue = await _prefs.getString(_verificationIntervalKey);
    final names = await _personApi.getPersonNames();
    String deviceName = device ?? '';
    if (deviceName.isEmpty) {
      deviceName = await _getDefaultDeviceName();
    }
    String? intervalLabel;
    if (intervalValue != null) {
      final idx = _intervalValues.indexOf(intervalValue);
      if (idx >= 0 && idx < _intervalOptions.length) {
        intervalLabel = _intervalOptions[idx];
      }
    }
    setState(() {
      _firstName = first ?? '';
      _lastName = last ?? '';
      _deviceName = deviceName;
      _verificationInterval = intervalLabel ?? _intervalOptions[0];
      _savedNames = names;
      _loading = false;
    });
  }

  String get _personSummary {
    if ((_firstName?.isNotEmpty ?? false) || (_lastName?.isNotEmpty ?? false)) {
      return '${_firstName ?? ''} ${_lastName ?? ''}'.trim();
    }
    return '';
  }

  String get _deviceNameSummary {
    return _deviceName?.isNotEmpty ?? false ? _deviceName! : 'Device';
  }

  Future<void> _showPersonDialog({bool populate = true}) async {
    final firstController = TextEditingController(text: populate ? _firstName : '');
    final lastController = TextEditingController(text: populate ? _lastName : '');
    String? error;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Person'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: firstController,
              decoration: InputDecoration(labelText: 'First Name', errorText: error),
              autofocus: true,
            ),
            TextField(
              controller: lastController,
              decoration: InputDecoration(labelText: 'Last Name', errorText: error),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              firstController.clear();
              lastController.clear();
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final first = firstController.text.trim();
              final last = lastController.text.trim();
              if (first.isEmpty && last.isEmpty) {
                setState(() {}); // To show error
                return;
              }
              await _prefs.setString('FirstName', first);
              await _prefs.setString('LastName', last);
              await _personApi.savePersonName(first, last);
              Navigator.pop(context);
              _loadProfile();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSavedNamesDialog() async {
    final currentIndex = _savedNames.indexWhere((n) => n?.firstName == _firstName && n?.lastName == _lastName);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Previously Used Names'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _savedNames.length,
            itemBuilder: (context, i) {
              final n = _savedNames[i];
              final isCurrent = i == currentIndex;
              return ListTile(
                title: Text('${n?.firstName ?? ''} ${n?.lastName ?? ''}'),
                selected: isCurrent,
                onTap: () async {
                  await _prefs.setString('FirstName', n?.firstName ?? '');
                  await _prefs.setString('LastName', n?.lastName ?? '');
                  Navigator.pop(context);
                  _loadProfile();
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await _personApi.clearPersonNames();
              await _prefs.setString('FirstName', '');
              await _prefs.setString('LastName', '');
              Navigator.pop(context);
              _loadProfile();
              _showPersonDialog(populate: false);
            },
            child: const Text('Clear All'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showPersonDialog(populate: false);
            },
            child: const Text('New Person'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeviceNameDialog() async {
    final controller = TextEditingController(text: _deviceName);
    String? error;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Device Name'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: 'Device Name', errorText: error),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => controller.clear(),
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isEmpty) {
                setState(() {}); // To show error
                return;
              }
              await _prefs.setString('DeviceName', name);
              Navigator.pop(context);
              _loadProfile();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showVerificationIntervalDialog() async {
    int selectedIdx = _intervalOptions.indexOf(_verificationInterval ?? _intervalOptions[0]);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verification Interval'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_intervalOptions.length, (i) => RadioListTile<int>(
            title: Text(_intervalOptions[i]),
            value: i,
            groupValue: selectedIdx,
            onChanged: (value) async {
              if (value != null) {
                await _prefs.setString(_verificationIntervalKey, _intervalValues[value]);
                setState(() {
                  _verificationInterval = _intervalOptions[value];
                });
                Navigator.pop(context);
              }
            },
          )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: buildAppBar(
        context,
        title: 'Profile Preferences',
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 4),
            child: Text('Person', style: Theme.of(context).textTheme.titleMedium),
          ),
          ListTile(
            title: const Text('Person'),
            subtitle: Text(_personSummary.isEmpty ? 'Not set' : _personSummary),
            onTap: () {
              if (_savedNames.isNotEmpty) {
                _showSavedNamesDialog();
              } else {
                _showPersonDialog();
              }
            },
          ),
          ListTile(
            title: const Text('Verification Interval'),
            subtitle: Text(_verificationInterval ?? _intervalOptions[0]),
            onTap: _showVerificationIntervalDialog,
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 4),
            child: Text('Device', style: Theme.of(context).textTheme.titleMedium),
          ),
          ListTile(
            title: const Text('Device Name'),
            subtitle: Text(_deviceNameSummary),
            onTap: _showDeviceNameDialog,
          ),
        ],
      ),
    );
  }
}
