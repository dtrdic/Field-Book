import 'package:fieldbook/app_widgets.dart';
import 'package:flutter/material.dart';
import '../../../../app_routes.dart';

class ConfigActivity extends StatelessWidget {
  const ConfigActivity({Key? key}) : super(key: key);

  static const List<_ConfigItem> configList = [
    _ConfigItem(
      title: 'Fields',
      icon: Icons.grass,
      route: AppRoute.fieldEditor,
    ),
    _ConfigItem(
      title: 'Traits',
      icon: Icons.list_alt,
      route: null, // TODO: Add Traits route if available
    ),
    _ConfigItem(
      title: 'Collect',
      icon: Icons.assignment,
      route: AppRoute.collect,
    ),
    _ConfigItem(
      title: 'Export',
      icon: Icons.save_alt,
      route: null, // TODO: Add Export route if available
    ),
    _ConfigItem(
      title: 'Settings',
      icon: Icons.settings,
      route: null, // TODO: Add Settings route if available
    ),
    _ConfigItem(
      title: 'Statistics',
      icon: Icons.bar_chart,
      route: null, // TODO: Add Statistics route if available
    ),
    _ConfigItem(
      title: 'About',
      icon: Icons.info_outline,
      route: AppRoute.about,
    ),
    _ConfigItem(
      title: 'Test Intro',
      icon: Icons.slideshow,
      route: AppRoute.appIntroActivity,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView.separated(
        itemCount: configList.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final item = configList[index];
          return ListTile(
            leading: Icon(item.icon, size: 32),
            title: Text(item.title, style: const TextStyle(fontSize: 18)),
            onTap: item.route != null
                ? () => Navigator.pushNamed(context, item.route!.path)
                : null,
          );
        },
      ),
    );
  }
}

class _ConfigItem {
  final String title;
  final IconData icon;
  final AppRoute? route;
  const _ConfigItem({required this.title, required this.icon, this.route});
}
