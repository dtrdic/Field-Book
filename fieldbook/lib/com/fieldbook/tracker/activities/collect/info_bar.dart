import 'package:flutter/material.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      child: const Text(
        'plot_id: 13RPN00015\nseed_name: T141\npedigree: T441/T13',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
