// lib/features/leads/widgets/timeline_widget.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:crm_leads_mobile_app/l10n/app_localizations.dart';
import '../models/lead_model.dart';

class TimelineWidget extends StatelessWidget {
  final Lead lead;

  const TimelineWidget({super.key, required this.lead});

  IconData _getFollowUpIcon(FollowUpType type) {
    switch (type) {
      case FollowUpType.call:
        return Icons.phone;
      case FollowUpType.meeting:
        return Icons.people;
      case FollowUpType.quotation:
        return Icons.description;
      case FollowUpType.email:
        return Icons.email;
    }
  }

  Color _getFollowUpColor(FollowUpType type) {
    switch (type) {
      case FollowUpType.call:
        return Colors.blue;
      case FollowUpType.meeting:
        return Colors.purple;
      case FollowUpType.quotation:
        return Colors.orange;
      case FollowUpType.email:
        return Colors.teal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final sortedFollowUps = List<FollowUp>.from(lead.followUpHistory)
      ..sort((a, b) => b.date.compareTo(a.date));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              l10n.followUpHistory,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (sortedFollowUps.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.history,
                      size: 48,
                      color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.noFollowUps,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sortedFollowUps.length,
                itemBuilder: (context, index) {
                  final followUp = sortedFollowUps[index];
                  final isLast = index == sortedFollowUps.length - 1;

                  return _TimelineItem(
                    followUp: followUp,
                    isLast: isLast,
                    icon: _getFollowUpIcon(followUp.type),
                    color: _getFollowUpColor(followUp.type),
                    parentContext: context,
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final FollowUp followUp;
  final bool isLast;
  final IconData icon;
  final Color color;
  final BuildContext parentContext;

  const _TimelineItem({
    required this.followUp,
    required this.isLast,
    required this.icon,
    required this.color,
    required this.parentContext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 2),
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        followUp.type.displayName(parentContext),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        DateFormat('MMM dd, yyyy').format(followUp.date),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    followUp.remark,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          followUp.status.displayName(parentContext),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          followUp.priority.displayName(parentContext),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSecondaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
