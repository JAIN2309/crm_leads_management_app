// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'CRM લીડ મેનેજમેન્ટ';

  @override
  String get welcomeBack => 'પાછા સ્વાગત છે!';

  @override
  String get login => 'લોગિન';

  @override
  String get email => 'ઈમેલ';

  @override
  String get password => 'પાસવર્ડ';

  @override
  String get emailRequired => 'ઈમેલ આવશ્યક છે';

  @override
  String get invalidEmail => 'અમાન્ય ઈમેલ ફોર્મેટ';

  @override
  String get passwordRequired => 'પાસવર્ડ આવશ્યક છે';

  @override
  String get passwordTooShort => 'પાસવર્ડ ઓછામાં ઓછો 6 અક્ષરોનો હોવો જોઈએ';

  @override
  String get loggingIn => 'લૉગિન થઈ રહ્યું છે...';

  @override
  String get dashboard => 'ડેશબોર્ડ';

  @override
  String get overview => 'ઝાંખી';

  @override
  String get quickActions => 'ઝડપી ક્રિયાઓ';

  @override
  String get totalLeads => 'કુલ લીડ્સ';

  @override
  String get todaysFollowUps => 'આજના ફોલોઅપ્સ';

  @override
  String get convertedLeads => 'રૂપાંતરિત લીડ્સ';

  @override
  String get pendingLeads => 'બાકી લીડ્સ';

  @override
  String get pending => 'બાકી';

  @override
  String get won => 'જીત્યું';

  @override
  String get inProgress => 'પ્રગતિમાં';

  @override
  String get viewAllLeads => 'બધા લીડ્સ જુઓ';

  @override
  String get browseLeads => 'તમારા લીડ્સ બ્રાઉઝ અને મેનેજ કરો';

  @override
  String get todaysFollowUpsAction => 'આજના ફોલોઅપ્સ';

  @override
  String leadsNeedAttention(int count) {
    return '$count લીડ્સને ધ્યાનની જરૂર છે';
  }

  @override
  String get reportsAnalytics => 'રિપોર્ટ્સ અને વિશ્લેષણ';

  @override
  String get viewPerformance => 'પ્રદર્શન મેટ્રિક્સ જુઓ';

  @override
  String get comingSoon => 'ટૂંક સમયમાં આવી રહ્યું છે!';

  @override
  String get leads => 'લીડ્સ';

  @override
  String get today => 'આજે';

  @override
  String get searchLeads => 'નામ, કંપની અથવા ફોન દ્વારા શોધો...';

  @override
  String get all => 'બધા';

  @override
  String get newStatus => 'નવું';

  @override
  String get contacted => 'સંપર્ક કર્યો';

  @override
  String get qualified => 'લાયક';

  @override
  String get proposal => 'પ્રસ્તાવ';

  @override
  String get negotiation => 'વાટાઘાટ';

  @override
  String get converted => 'રૂપાંતરિત';

  @override
  String get lost => 'ખોવાયેલું';

  @override
  String get noLeadsFound => 'કોઈ લીડ્સ મળ્યા નથી';

  @override
  String get adjustFilters =>
      'તમારી શોધ અથવા ફિલ્ટર્સ સમાયોજિત કરવાનો પ્રયાસ કરો';

  @override
  String get clearFilters => 'ફિલ્ટર્સ સાફ કરો';

  @override
  String get low => 'ઓછું';

  @override
  String get medium => 'મધ્યમ';

  @override
  String get high => 'ઊંચું';

  @override
  String get urgent => 'તાત્કાલિક';

  @override
  String nextFollowUp(String date) {
    return 'આગામી ફોલોઅપ: $date';
  }

  @override
  String get leadDetails => 'લીડ વિગતો';

  @override
  String get contactInformation => 'સંપર્ક માહિતી';

  @override
  String get mobile => 'મોબાઇલ';

  @override
  String get address => 'સરનામું';

  @override
  String get companyName => 'કંપની';

  @override
  String get leadInformation => 'લીડ માહિતી';

  @override
  String get source => 'સ્રોત';

  @override
  String get status => 'સ્થિતિ';

  @override
  String get priority => 'પ્રાથમિકતા';

  @override
  String get assignedTo => 'સોંપાયેલ';

  @override
  String get createdOn => 'બનાવ્યું';

  @override
  String get customerImages => 'ગ્રાહક ચિત્રો';

  @override
  String get addImage => 'ચિત્ર ઉમેરો';

  @override
  String get noImages => 'હજી સુધી કોઈ ચિત્રો ઉમેર્યા નથી';

  @override
  String get deleteImage => 'ચિત્ર કાઢી નાખો';

  @override
  String get deleteImageConfirm => 'શું તમે ખરેખર આ ચિત્ર કાઢી નાખવા માંગો છો?';

  @override
  String get delete => 'કાઢી નાખો';

  @override
  String get cancel => 'રદ કરો';

  @override
  String get followUpHistory => 'ફોલોઅપ ઇતિહાસ';

  @override
  String get noFollowUps => 'હજી સુધી કોઈ ફોલોઅપ પ્રવૃત્તિઓ નથી';

  @override
  String get addFollowUp => 'ફોલોઅપ ઉમેરો';

  @override
  String get call => 'કૉલ';

  @override
  String get meeting => 'મીટિંગ';

  @override
  String get quotation => 'અવતરણ';

  @override
  String get selectType => 'પ્રકાર પસંદ કરો';

  @override
  String get selectStatus => 'સ્થિતિ પસંદ કરો';

  @override
  String get selectPriority => 'પ્રાથમિકતા પસંદ કરો';

  @override
  String get remark => 'ટિપ્પણી';

  @override
  String get remarkRequired => 'ટિપ્પણી આવશ્યક છે';

  @override
  String get remarkTooShort => 'ટિપ્પણી ઓછામાં ઓછી 10 અક્ષરોની હોવી જોઈએ';

  @override
  String get date => 'તારીખ';

  @override
  String get selectDate => 'તારીખ પસંદ કરો';

  @override
  String get submit => 'સબમિટ કરો';

  @override
  String get settings => 'સેટિંગ્સ';

  @override
  String get appearance => 'દેખાવ';

  @override
  String get darkMode => 'ડાર્ક મોડ';

  @override
  String get enabled => 'સક્ષમ';

  @override
  String get disabled => 'અક્ષમ';

  @override
  String get language => 'ભાષા';

  @override
  String get account => 'ખાતું';

  @override
  String get profile => 'પ્રોફાઇલ';

  @override
  String get logout => 'લૉગઆઉટ';

  @override
  String get signOut => 'તમારા ખાતામાંથી સાઇન આઉટ કરો';

  @override
  String get about => 'વિશે';

  @override
  String get version => 'સંસ્કરણ';

  @override
  String get termsConditions => 'નિયમો અને શરતો';

  @override
  String get privacyPolicy => 'ગોપનીયતા નીતિ';

  @override
  String get selectLanguage => 'ભાષા પસંદ કરો';

  @override
  String languageChanged(String language) {
    return 'ભાષા $language માં બદલાઈ ગઈ';
  }

  @override
  String get logoutConfirm => 'શું તમે ખરેખર લૉગઆઉટ કરવા માંગો છો?';

  @override
  String get toggleTheme => 'થીમ ટોગલ કરો';

  @override
  String get profileFeature => 'પ્રોફાઇલ સુવિધા ટૂંક સમયમાં આવી રહી છે!';

  @override
  String get reportsFeature => 'રિપોર્ટ સુવિધા ટૂંક સમયમાં આવી રહી છે!';
}
