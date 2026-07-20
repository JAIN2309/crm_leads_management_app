// lib/features/settings/screens/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crm_leads_mobile_app/l10n/app_localizations.dart';
import '../../../core/theme/theme_provider.dart';
import '../providers/language_provider.dart';
import '../../auth/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final languageProvider = context.watch<LanguageProvider>();
    final authProvider = context.watch<AuthProvider>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          _buildSectionHeader(context, l10n.appearance),
          _buildSettingTile(
            context: context,
            icon: Icons.dark_mode_outlined,
            title: l10n.darkMode,
            subtitle: themeProvider.isDarkMode ? l10n.enabled : l10n.disabled,
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          const Divider(height: 1),
          _buildSectionHeader(context, l10n.language),
          _buildSettingTile(
            context: context,
            icon: Icons.language_outlined,
            title: l10n.language,
            subtitle: languageProvider.currentLanguageName,
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLanguageDialog(context),
          ),
          const Divider(height: 1),
          _buildSectionHeader(context, l10n.account),
          _buildSettingTile(
            context: context,
            icon: Icons.person_outline,
            title: l10n.profile,
            subtitle: 'admin@crm.com',
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.profileFeature)),
              );
            },
          ),
          _buildSettingTile(
            context: context,
            icon: Icons.logout,
            iconColor: theme.colorScheme.error,
            title: l10n.logout,
            subtitle: l10n.signOut,
            trailing: Icon(Icons.chevron_right, color: theme.colorScheme.error),
            onTap: () => _showLogoutDialog(context, authProvider),
          ),
          const Divider(height: 1),
          _buildSectionHeader(context, l10n.about),
          _buildSettingTile(
            context: context,
            icon: Icons.info_outline,
            title: l10n.version,
            subtitle: '1.0.0',
          ),
          _buildSettingTile(
            context: context,
            icon: Icons.description_outlined,
            title: l10n.termsConditions,
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.termsConditions)),
              );
            },
          ),
          _buildSettingTile(
            context: context,
            icon: Icons.privacy_tip_outlined,
            title: l10n.privacyPolicy,
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.privacyPolicy)),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? theme.colorScheme.primary).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: iconColor ?? theme.colorScheme.primary,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final languageProvider = context.read<LanguageProvider>();
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.selectLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: languageProvider.supportedLanguages
              .map((lang) => _buildLanguageOption(
                    context,
                    lang['code']!,
                    lang['name']!,
                    lang['flag']!,
                  ))
              .toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String code,
    String name,
    String flag,
  ) {
    final languageProvider = context.watch<LanguageProvider>();
    final l10n = AppLocalizations.of(context)!;
    return RadioListTile<String>(
      value: code,
      groupValue: languageProvider.locale.languageCode,
      onChanged: (value) {
        if (value != null) {
          languageProvider.setLanguage(value);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.languageChanged(name))),
          );
        }
      },
      title: Row(
        children: [
          Text(flag, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Text(name),
        ],
      ),
      dense: true,
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.logout),
        content: Text(l10n.logoutConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              authProvider.logout();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.logout),
          ),
        ],
      ),
    );
  }
}
