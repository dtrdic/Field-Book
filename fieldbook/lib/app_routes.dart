enum AppRoute {
  home('/', 'Home'),
  about('/about', 'About'),
  profilePreferences('/profile_preferences', 'Profile Preferences'),
  scanner('/scanner', 'Scanner'),
  fieldEditor('/field_editor', 'Field Editor');

  final String path;
  final String displayName;
  const AppRoute(this.path, this.displayName);

  static AppRoute? fromPath(String path) {
    return AppRoute.values.firstWhere(
      (route) => route.path == path,
      orElse: () => throw StateError('No matching route for path: \$path'),
    );
  }
}
