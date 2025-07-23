import 'package:fieldbook/atoms/button_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'collect_activity_provider.dart';
import 'collect_input.dart';
import 'info_bar.dart';
import 'range_box.dart';
import 'trait_box.dart';

class CollectActivity extends StatelessWidget {
  const CollectActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CollectActivityProvider(
          plotId: '14RPN00001'), // TODO: set plotId dynamically
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Collect'),
          leading: const BackButton(),
        ),
        body: Theme(
          data: Theme.of(context).copyWith(
            elevatedButtonTheme: inputButtonTheme,
          ),
          child: Column(
            children: const [
              InfoBar(),
              TraitBox(),
              RangeBox(),
              CollectInput(),
            ],
          ),
        ),
      ),
    );
  }
}
