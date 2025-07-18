enum AppRoute {
  config('/', 'Configuration'),
  about('/about', 'About'),
  profilePreferences('/profile_preferences', 'Profile Preferences'),
  scanner('/scanner', 'Scanner'),
  fieldEditor('/field_editor', 'Field Editor'),
  appIntroActivity('/app_intro', 'App Intro Activity');

  final String path;
  final String displayName;
  const AppRoute(this.path, this.displayName);
}
