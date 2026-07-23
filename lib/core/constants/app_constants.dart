class AppConstants {
  // Default Keywords
  static const List<String> defaultKeywords = [
    'Application Specialist',
    'Senior Application Specialist',
    'Product Specialist',
    'Technical Support',
    'Biomedical Engineer',
    'Medical Laboratory',
    'Medical Representative',
    'Sales Representative',
    'Scientific Office',
    'Medical Equipment',
    'IVD',
    'Laboratory',
    'Clinical Chemistry',
    'Hematology',
    'Microbiology',
    'Molecular Biology',
    'PCR',
    'ELISA',
    'Flow Cytometry',
    'HPLC',
    'GC-MS',
    'QA',
    'QC',
    'Quality Assurance',
    'Quality Control',
    'Pharmaceutical',
    'Drug Factory',
    'Biochemistry',
    'Toxicology',
    'Research Assistant',
  ];

  // Job Relevance Classifications
  static const String veryRelevant = 'Very Relevant';
  static const String relevant = 'Relevant';
  static const String possiblyRelevant = 'Possibly Relevant';
  static const String ignore = 'Ignore';

  // Database
  static const String databaseName = 'iraq_job_monitor.db';

  // Background Job Tags
  static const String telegramSyncTag = 'telegram_sync';
  static const String notificationTag = 'notification_check';

  // Notification IDs
  static const int newJobNotificationId = 1;
  static const int syncStatusNotificationId = 2;

  // Pagination
  static const int itemsPerPage = 20;
}
