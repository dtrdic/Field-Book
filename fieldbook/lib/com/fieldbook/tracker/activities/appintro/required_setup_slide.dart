import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RequiredSetupSlide extends StatefulWidget {
  final VoidCallback? onContinue;
  const RequiredSetupSlide({Key? key, this.onContinue}) : super(key: key);

  @override
  State<RequiredSetupSlide> createState() => _RequiredSetupSlideState();
}

class _RequiredSetupSlideState extends State<RequiredSetupSlide> {
  bool _permissionsGranted = false;
  bool _storageDefined = false;

  @override
  void initState() {
    super.initState();
    _initStoragePath();
    _checkPermissions();
  }

  Future<void> _initStoragePath() async {
    final dir = await getApplicationDocumentsDirectory();
    _checkStorage();
  }

  Future<void> _checkPermissions() async {
    final cameraGranted = await Permission.camera.isGranted;
    final micGranted = await Permission.microphone.isGranted;
    final locationGranted = await Permission.location.isGranted;
    debugPrint('Permission check: camera=$cameraGranted, mic=$micGranted, location=$locationGranted');
    final status = cameraGranted && micGranted && locationGranted;
    setState(() {
      _permissionsGranted = status;
    });
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Permission.location,
    ].request();
    debugPrint('Requesting permissions (no storage)');
    debugPrint('Permission request results:');
    statuses.forEach((perm, status) {
      debugPrint('${perm.toString()}: ${status.toString()}');
    });
    _checkPermissions();
    if (!statuses.values.every((s) => s.isGranted)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please grant all required permissions.')),
      );
    }
  }

  Future<void> _checkStorage() async {
    final dir = await getApplicationDocumentsDirectory();
    final exists = await Directory(dir.path).exists();
    setState(() {
      _storageDefined = exists;
    });
  }

  Future<void> _defineStorage() async {
    String? result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      setState(() {
        _storageDefined = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a storage location.')),
      );
    }
  }

  bool get _setupComplete => _permissionsGranted && _storageDefined;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Required Setup',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'Set up your field and traits to get started.',
            style: TextStyle(fontSize: 18, color: Color(0xFF212121)),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              ListTile(
                leading: Icon(_permissionsGranted ? Icons.check_circle : Icons.lock, color: Color(0xFF1976D2)),
                title: const Text('Permissions'),
                subtitle: Text(_permissionsGranted
                    ? 'All required permissions granted.'
                    : 'Grant necessary permissions for app operation.'),
                trailing: Icon(Icons.chevron_right),
                onTap: _requestPermissions,
              ),
              ListTile(
                leading: Icon(_storageDefined ? Icons.check_circle : Icons.sd_storage, color: Color(0xFF1976D2)),
                title: const Text('Storage Setup'),
                subtitle: Text(_storageDefined
                    ? 'Storage location defined.'
                    : 'Define where your data will be stored.'),
                trailing: Icon(Icons.chevron_right),
                onTap: _defineStorage,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _setupComplete
                    ? widget.onContinue
                    : null,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
