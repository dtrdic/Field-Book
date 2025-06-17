import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppBar buildAppBar(BuildContext context, {String title = '', List<Widget>? actions}) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
          SystemNavigator.pop();
      },
    ),
    title: Text(title),
    actions: actions,
  );
}
