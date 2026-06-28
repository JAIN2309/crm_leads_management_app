// lib/features/dashboard/screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../leads/providers/lead_provider.dart';
import '../../leads/screens/lead_list_screen.dart';
import '../../leads/models/lead_model.dart';
import '../../settings/screens/settings_screen.dart';
import '../../../core/theme/theme_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final leadProvider = context.watch<LeadProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.dashboard),
            Text(
              l10n.welcomeBack,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            tooltip: l10n.settings,
          ),
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
            tooltip: l10n.toggleTheme,
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => leadProvider.refreshLeads(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.overview,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.04,
                  mainAxisSpacing: screenWidth * 0.04,
                  childAspectRatio: 1.1,
                  children: [
                    _SummaryCard(
                      title: l10n.totalLeads,
                      value: leadProvider.totalLeads.toString(),
                      icon: Icons.people_outline,
                      color: Colors.blue,
                      trend: '+12%',
                      onTap: () {
                        leadProvider.filterByStatus(null);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LeadListScreen(),
                          ),
                        );
                      },
                    ),
                    _SummaryCard(
                      title: l10n.todaysFollowUps,
                      value: leadProvider.todaysFollowUps.toString(),
                      icon: Icons.calendar_today,
                      color: Colors.orange,
                      trend: '${leadProvider.todaysFollowUps} ${l10n.pending}',
                      onTap: () {
                        leadProvider.filterByTodaysFollowUps();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LeadListScreen(),
                          ),
                        );
                      },
                    ),
                    _SummaryCard(
                      title: l10n.convertedLeads,
                      value: leadProvider.convertedLeads.toString(),
                      icon: Icons.check_circle_outline,
                      color: Colors.green,
                      trend: '+${leadProvider.convertedLeads} ${l10n.won}',
                      onTap: () {
                        leadProvider.filterByStatus(LeadStatus.converted);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LeadListScreen(),
                          ),
                        );
                      },
                    ),
                    _SummaryCard(
                      title: l10n.pendingLeads,
                      value: leadProvider.pendingLeads.toString(),
                      icon: Icons.pending_outlined,
                      color: Colors.purple,
                      trend: l10n.inProgress,
                      onTap: () {
                        leadProvider.filterByStatus(null);
                        leadProvider.searchLeads('');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LeadListScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.quickActions,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                _QuickActionCard(
                  title: l10n.viewAllLeads,
                  subtitle: l10n.browseLeads,
                  icon: Icons.list_alt,
                  color: theme.colorScheme.primary,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LeadListScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.015),
                _QuickActionCard(
                  title: l10n.todaysFollowUpsAction,
                  subtitle: l10n.leadsNeedAttention(leadProvider.todaysFollowUps),
                  icon: Icons.notifications_active_outlined,
                  color: Colors.orange,
                  onTap: () {
                    leadProvider.filterByTodaysFollowUps();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LeadListScreen(),
                      ),
                    );
                  },
                ),
                SizedBox(height: screenHeight * 0.015),
                _QuickActionCard(
                  title: l10n.reportsAnalytics,
                  subtitle: l10n.viewPerformance,
                  icon: Icons.analytics_outlined,
                  color: Colors.teal,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.reportsFeature),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;
  final VoidCallback onTap;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(mediaQuery.size.width * 0.03),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(mediaQuery.size.width * 0.02),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(icon, color: color, size: mediaQuery.size.width * 0.05),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                      ),
                    ],
                  ),
                  SizedBox(height: constraints.maxHeight * 0.08),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            value,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        Text(
                          title,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.02),
                        Text(
                          trend,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
