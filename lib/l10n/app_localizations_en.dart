// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CRM Lead Management';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get invalidEmail => 'Invalid email format';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get loggingIn => 'Logging in...';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get overview => 'Overview';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get totalLeads => 'Total Leads';

  @override
  String get todaysFollowUps => 'Today\'s Follow-ups';

  @override
  String get convertedLeads => 'Converted Leads';

  @override
  String get pendingLeads => 'Pending Leads';

  @override
  String get pending => 'pending';

  @override
  String get won => 'won';

  @override
  String get inProgress => 'In progress';

  @override
  String get viewAllLeads => 'View All Leads';

  @override
  String get browseLeads => 'Browse and manage your leads';

  @override
  String get todaysFollowUpsAction => 'Today\'s Follow-ups';

  @override
  String leadsNeedAttention(int count) {
    return '$count leads need attention';
  }

  @override
  String get reportsAnalytics => 'Reports & Analytics';

  @override
  String get viewPerformance => 'View performance metrics';

  @override
  String get comingSoon => 'coming soon!';

  @override
  String get leads => 'Leads';

  @override
  String get today => 'Today';

  @override
  String get searchLeads => 'Search by name, company, or phone...';

  @override
  String get all => 'All';

  @override
  String get newStatus => 'New';

  @override
  String get contacted => 'Contacted';

  @override
  String get qualified => 'Qualified';

  @override
  String get proposal => 'Proposal';

  @override
  String get negotiation => 'Negotiation';

  @override
  String get converted => 'Converted';

  @override
  String get lost => 'Lost';

  @override
  String get noLeadsFound => 'No Leads Found';

  @override
  String get adjustFilters => 'Try adjusting your search or filters';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get low => 'Low';

  @override
  String get medium => 'Medium';

  @override
  String get high => 'High';

  @override
  String get urgent => 'Urgent';

  @override
  String nextFollowUp(String date) {
    return 'Next Follow-up: $date';
  }

  @override
  String get leadDetails => 'Lead Details';

  @override
  String get contactInformation => 'Contact Information';

  @override
  String get mobile => 'Mobile';

  @override
  String get address => 'Address';

  @override
  String get companyName => 'Company';

  @override
  String get leadInformation => 'Lead Information';

  @override
  String get source => 'Source';

  @override
  String get status => 'Status';

  @override
  String get priority => 'Priority';

  @override
  String get assignedTo => 'Assigned To';

  @override
  String get createdOn => 'Created On';

  @override
  String get customerImages => 'Customer Images';

  @override
  String get addImage => 'Add Image';

  @override
  String get noImages => 'No images added yet';

  @override
  String get deleteImage => 'Delete Image';

  @override
  String get deleteImageConfirm =>
      'Are you sure you want to delete this image?';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get followUpHistory => 'Follow-up History';

  @override
  String get noFollowUps => 'No follow-up activities yet';

  @override
  String get addFollowUp => 'Add Follow-up';

  @override
  String get call => 'Call';

  @override
  String get meeting => 'Meeting';

  @override
  String get quotation => 'Quotation';

  @override
  String get selectType => 'Select Type';

  @override
  String get selectStatus => 'Select Status';

  @override
  String get selectPriority => 'Select Priority';

  @override
  String get remark => 'Remark';

  @override
  String get remarkRequired => 'Remark is required';

  @override
  String get remarkTooShort => 'Remark must be at least 10 characters';

  @override
  String get date => 'Date';

  @override
  String get selectDate => 'Select Date';

  @override
  String get submit => 'Submit';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get language => 'Language';

  @override
  String get account => 'Account';

  @override
  String get profile => 'Profile';

  @override
  String get logout => 'Logout';

  @override
  String get signOut => 'Sign out from your account';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get termsConditions => 'Terms & Conditions';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String languageChanged(String language) {
    return 'Language changed to $language';
  }

  @override
  String get logoutConfirm => 'Are you sure you want to logout?';

  @override
  String get toggleTheme => 'Toggle theme';

  @override
  String get profileFeature => 'Profile feature coming soon!';

  @override
  String get reportsFeature => 'Reports feature coming soon!';
}
