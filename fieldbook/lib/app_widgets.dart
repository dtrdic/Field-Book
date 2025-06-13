import 'package:flutter/material.dart';

/// A reusable AppBar for consistent navigation and actions across the app.
AppBar buildAppBar(BuildContext context, {String title = '', List<Widget>? actions}) {
  return AppBar(
    leading: Navigator.of(context).canPop()
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          )
        : null,
    title: Text(title),
    actions: actions,
  );
}

