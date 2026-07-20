// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'CRM लीड प्रबंधन';

  @override
  String get welcomeBack => 'वापसी पर स्वागत है!';

  @override
  String get login => 'लॉगिन';

  @override
  String get email => 'ईमेल';

  @override
  String get password => 'पासवर्ड';

  @override
  String get emailRequired => 'ईमेल आवश्यक है';

  @override
  String get invalidEmail => 'अमान्य ईमेल प्रारूप';

  @override
  String get passwordRequired => 'पासवर्ड आवश्यक है';

  @override
  String get passwordTooShort => 'पासवर्ड कम से कम 6 अक्षर का होना चाहिए';

  @override
  String get loggingIn => 'लॉगिन हो रहा है...';

  @override
  String get dashboard => 'डैशबोर्ड';

  @override
  String get overview => 'सिंहावलोकन';

  @override
  String get quickActions => 'त्वरित क्रियाएं';

  @override
  String get totalLeads => 'कुल लीड';

  @override
  String get todaysFollowUps => 'आज के फॉलोअप';

  @override
  String get convertedLeads => 'परिवर्तित लीड';

  @override
  String get pendingLeads => 'लंबित लीड';

  @override
  String get pending => 'लंबित';

  @override
  String get won => 'जीत';

  @override
  String get inProgress => 'प्रगति में';

  @override
  String get viewAllLeads => 'सभी लीड देखें';

  @override
  String get browseLeads => 'अपने लीड ब्राउज़ और प्रबंधित करें';

  @override
  String get todaysFollowUpsAction => 'आज के फॉलोअप';

  @override
  String leadsNeedAttention(int count) {
    return '$count लीड को ध्यान देने की आवश्यकता है';
  }

  @override
  String get reportsAnalytics => 'रिपोर्ट और विश्लेषण';

  @override
  String get viewPerformance => 'प्रदर्शन मेट्रिक्स देखें';

  @override
  String get comingSoon => 'जल्द आ रहा है!';

  @override
  String get leads => 'लीड';

  @override
  String get today => 'आज';

  @override
  String get searchLeads => 'नाम, कंपनी या फोन से खोजें...';

  @override
  String get all => 'सभी';

  @override
  String get newStatus => 'नया';

  @override
  String get contacted => 'संपर्क किया';

  @override
  String get qualified => 'योग्य';

  @override
  String get proposal => 'प्रस्ताव';

  @override
  String get negotiation => 'बातचीत';

  @override
  String get converted => 'परिवर्तित';

  @override
  String get lost => 'खोया';

  @override
  String get noLeadsFound => 'कोई लीड नहीं मिला';

  @override
  String get adjustFilters =>
      'अपनी खोज या फ़िल्टर समायोजित करने का प्रयास करें';

  @override
  String get clearFilters => 'फ़िल्टर साफ़ करें';

  @override
  String get low => 'कम';

  @override
  String get medium => 'मध्यम';

  @override
  String get high => 'उच्च';

  @override
  String get urgent => 'अत्यावश्यक';

  @override
  String nextFollowUp(String date) {
    return 'अगला फॉलोअप: $date';
  }

  @override
  String get leadDetails => 'लीड विवरण';

  @override
  String get contactInformation => 'संपर्क जानकारी';

  @override
  String get mobile => 'मोबाइल';

  @override
  String get address => 'पता';

  @override
  String get companyName => 'कंपनी';

  @override
  String get leadInformation => 'लीड जानकारी';

  @override
  String get source => 'स्रोत';

  @override
  String get status => 'स्थिति';

  @override
  String get priority => 'प्राथमिकता';

  @override
  String get assignedTo => 'को सौंपा गया';

  @override
  String get createdOn => 'बनाया गया';

  @override
  String get customerImages => 'ग्राहक चित्र';

  @override
  String get addImage => 'चित्र जोड़ें';

  @override
  String get noImages => 'अभी तक कोई चित्र नहीं जोड़ा गया';

  @override
  String get deleteImage => 'चित्र हटाएं';

  @override
  String get deleteImageConfirm => 'क्या आप वाकई इस चित्र को हटाना चाहते हैं?';

  @override
  String get delete => 'हटाएं';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get followUpHistory => 'फॉलोअप इतिहास';

  @override
  String get noFollowUps => 'अभी तक कोई फॉलोअप गतिविधि नहीं';

  @override
  String get addFollowUp => 'फॉलोअप जोड़ें';

  @override
  String get call => 'कॉल';

  @override
  String get meeting => 'बैठक';

  @override
  String get quotation => 'उद्धरण';

  @override
  String get selectType => 'प्रकार चुनें';

  @override
  String get selectStatus => 'स्थिति चुनें';

  @override
  String get selectPriority => 'प्राथमिकता चुनें';

  @override
  String get remark => 'टिप्पणी';

  @override
  String get remarkRequired => 'टिप्पणी आवश्यक है';

  @override
  String get remarkTooShort => 'टिप्पणी कम से कम 10 अक्षर की होनी चाहिए';

  @override
  String get date => 'तारीख';

  @override
  String get selectDate => 'तारीख चुनें';

  @override
  String get submit => 'जमा करें';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get appearance => 'रूप';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get enabled => 'सक्षम';

  @override
  String get disabled => 'अक्षम';

  @override
  String get language => 'भाषा';

  @override
  String get account => 'खाता';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get logout => 'लॉगआउट';

  @override
  String get signOut => 'अपने खाते से साइन आउट करें';

  @override
  String get about => 'के बारे में';

  @override
  String get version => 'संस्करण';

  @override
  String get termsConditions => 'नियम और शर्तें';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String languageChanged(String language) {
    return 'भाषा $language में बदल गई';
  }

  @override
  String get logoutConfirm => 'क्या आप वाकई लॉगआउट करना चाहते हैं?';

  @override
  String get toggleTheme => 'थीम टॉगल करें';

  @override
  String get profileFeature => 'प्रोफ़ाइल सुविधा जल्द आ रही है!';

  @override
  String get reportsFeature => 'रिपोर्ट सुविधा जल्द आ रही है!';
}
