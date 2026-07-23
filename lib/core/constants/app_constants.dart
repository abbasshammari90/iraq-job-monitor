class AppConstants {
  // Classification types
  static const String veryRelevant = 'Very Relevant';
  static const String relevant = 'Relevant';
  static const String possiblyRelevant = 'Possibly Relevant';
  static const String ignore = 'Ignore';

  // Notification IDs
  static const int newJobNotificationId = 1;
  static const int syncStatusNotificationId = 2;

  // Default sync interval in minutes
  static const int defaultSyncInterval = 15;

  // Database constants
  static const String databaseName = 'iraq_job_monitor.db';
  static const int databaseVersion = 1;

  // App info
  static const String appName = 'Iraq Job Monitor';
  static const String appVersion = '1.0.0';

  // Default keywords
  static const List<String> defaultKeywords = [
    'software engineer',
    'developer',
    'flutter',
    'mobile app',
    'web developer',
    'backend',
    'frontend',
    'full stack',
    'react',
    'node.js',
    'python',
    'java',
    'dart',
    'kotlin',
    'swift',
    'senior',
    'junior',
    'internship',
    'contract',
    'remote',
  ];
}
