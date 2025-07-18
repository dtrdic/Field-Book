import 'package:flutter/material.dart';

class OptionalSetupSlide extends StatelessWidget {
  const OptionalSetupSlide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Optional Setup',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
        ),
        const SizedBox(height: 16),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            'Customize your experience with optional settings.',
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
                leading: Checkbox(value: false, onChanged: null),
                title: Text('Load Sample Data'),
                subtitle: Text('Preload example data for testing.'),
              ),
              ListTile(
                leading: Checkbox(value: false, onChanged: null),
                title: Text('Enable Tutorial'),
                subtitle: Text('Show tutorial on startup.'),
              ),
              ListTile(
                leading: Checkbox(value: false, onChanged: null),
                title: Text('High Contrast Theme'),
                subtitle: Text('Use a high contrast color scheme.'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

