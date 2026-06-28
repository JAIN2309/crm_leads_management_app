// lib/features/leads/screens/lead_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/lead_model.dart';
import '../providers/lead_provider.dart';
import '../widgets/image_grid_widget.dart';
import '../widgets/timeline_widget.dart';
import '../widgets/add_followup_bottom_sheet.dart';

class LeadDetailScreen extends StatelessWidget {
  final String leadId;

  const LeadDetailScreen({super.key, required this.leadId});

  Color _getStatusColor(LeadStatus status) {
    switch (status) {
      case LeadStatus.new_:
        return Colors.blue;
      case LeadStatus.contacted:
        return Colors.cyan;
      case LeadStatus.qualified:
        return Colors.purple;
      case LeadStatus.proposal:
        return Colors.orange;
      case LeadStatus.negotiation:
        return Colors.amber;
      case LeadStatus.converted:
        return Colors.green;
      case LeadStatus.lost:
        return Colors.red;
    }
  }

  Color _getPriorityColor(LeadPriority priority) {
    switch (priority) {
      case LeadPriority.low:
        return Colors.grey;
      case LeadPriority.medium:
        return Colors.blue;
      case LeadPriority.high:
        return Colors.orange;
      case LeadPriority.urgent:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final leadProvider = context.watch<LeadProvider>();
    final lead = leadProvider.getLeadById(leadId);
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final l10n = AppLocalizations.of(context)!;

    if (lead == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.leadDetails)),
        body: Center(child: Text(l10n.noLeadsFound)),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenHeight * 0.25,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _getStatusColor(lead.status),
                      _getStatusColor(lead.status).withOpacity(0.7),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: constraints.maxHeight * 0.15),
                          Hero(
                            tag: 'avatar_${lead.id}',
                            child: CircleAvatar(
                              radius: constraints.maxHeight * 0.2,
                              backgroundImage: NetworkImage(lead.profileImageUrl),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.05),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: mediaQuery.size.width * 0.04,
                              ),
                              child: Text(
                                lead.customerName,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: constraints.maxHeight * 0.02),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: mediaQuery.size.width * 0.03,
                              vertical: constraints.maxHeight * 0.025,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              lead.status.displayName(context),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.all(mediaQuery.size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _InfoSection(
                      title: l10n.contactInformation,
                      icon: Icons.contact_mail,
                      children: [
                        _InfoRow(
                          icon: Icons.business,
                          label: l10n.companyName,
                          value: lead.companyName,
                        ),
                        _InfoRow(
                          icon: Icons.email,
                          label: l10n.email,
                          value: lead.email,
                        ),
                        _InfoRow(
                          icon: Icons.phone,
                          label: l10n.mobile,
                          value: lead.mobileNumber,
                        ),
                        _InfoRow(
                          icon: Icons.location_on,
                          label: l10n.address,
                          value: lead.address,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    _InfoSection(
                      title: l10n.leadInformation,
                      icon: Icons.info_outline,
                      children: [
                        _InfoRow(
                          icon: Icons.source,
                          label: l10n.source,
                          value: lead.leadSource,
                        ),
                        _InfoRow(
                          icon: Icons.person,
                          label: l10n.assignedTo,
                          value: lead.assignedSalesperson,
                        ),
                        _InfoRow(
                          icon: Icons.calendar_today,
                          label: l10n.createdOn,
                          value: DateFormat('MMM dd, yyyy').format(lead.createdDate),
                        ),
                        _InfoRow(
                          icon: Icons.flag,
                          label: l10n.priority,
                          value: lead.priority.displayName(context),
                          valueColor: _getPriorityColor(lead.priority),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    ImageGridWidget(lead: lead),
                    SizedBox(height: screenHeight * 0.03),
                    TimelineWidget(lead: lead),
                    SizedBox(height: screenHeight * 0.1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddFollowUpBottomSheet(leadId: leadId),
          );
        },
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.addFollowUp),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _InfoSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
