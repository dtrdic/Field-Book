import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'collect_activity_provider.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plotId = Provider.of<CollectActivityProvider>(context).plotId;
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      child: Text(
        'plot_id: $plotId\nseed_name: T141\npedigree: T441/T13',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
