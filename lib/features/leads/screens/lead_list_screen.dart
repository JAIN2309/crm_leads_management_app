// lib/features/leads/screens/lead_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/lead_model.dart';
import '../providers/lead_provider.dart';
import 'lead_detail_screen.dart';

class LeadListScreen extends StatefulWidget {
  const LeadListScreen({super.key});

  @override
  State<LeadListScreen> createState() => _LeadListScreenState();
}

class _LeadListScreenState extends State<LeadListScreen> {
  final _searchController = TextEditingController();
  final _filterScrollController = ScrollController();
  bool _showLeftButton = false;
  bool _showRightButton = true;

  @override
  void initState() {
    super.initState();
    _filterScrollController.addListener(_updateButtonVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateButtonVisibility();
    });
  }

  void _updateButtonVisibility() {
    if (!_filterScrollController.hasClients) return;
    setState(() {
      _showLeftButton = _filterScrollController.offset > 10;
      _showRightButton = _filterScrollController.offset <
          _filterScrollController.position.maxScrollExtent - 10;
    });
  }

  void _scrollLeft() {
    _filterScrollController.animateTo(
      _filterScrollController.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _filterScrollController.animateTo(
      _filterScrollController.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _filterScrollController.dispose();
    super.dispose();
  }

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

  Widget _buildFilterChip(String label, bool selected, VoidCallback onTap, Color? color) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      avatar: color != null
          ? CircleAvatar(
              radius: 6,
              backgroundColor: color,
            )
          : null,
      showCheckmark: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final leadProvider = context.watch<LeadProvider>();
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.leads),
        actions: [
          if (leadProvider.todaysFollowUps > 0)
            TextButton.icon(
              onPressed: () {
                leadProvider.filterByTodaysFollowUps();
              },
              icon: const Icon(Icons.today),
              label: Text("${l10n.today} (${leadProvider.todaysFollowUps})"),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(mediaQuery.size.height * 0.08),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.size.width * 0.04,
                vertical: 8,
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: l10n.searchLeads,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            leadProvider.searchLeads('');
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  leadProvider.searchLeads(value);
                },
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.065,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  if (_showLeftButton)
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            theme.colorScheme.surface,
                            theme.colorScheme.surface.withOpacity(0),
                          ],
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.chevron_left, size: 20),
                        onPressed: _scrollLeft,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  Expanded(
                    child: ListView(
                      controller: _filterScrollController,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: mediaQuery.size.width * 0.04),
                      children: [
                        _buildFilterChip(
                          l10n.all,
                          leadProvider.statusFilter == null,
                          () => leadProvider.filterByStatus(null),
                          null,
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          l10n.newStatus,
                          leadProvider.statusFilter == LeadStatus.new_,
                          () => leadProvider.filterByStatus(LeadStatus.new_),
                          _getStatusColor(LeadStatus.new_),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          l10n.contacted,
                          leadProvider.statusFilter == LeadStatus.contacted,
                          () => leadProvider.filterByStatus(LeadStatus.contacted),
                          _getStatusColor(LeadStatus.contacted),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          l10n.qualified,
                          leadProvider.statusFilter == LeadStatus.qualified,
                          () => leadProvider.filterByStatus(LeadStatus.qualified),
                          _getStatusColor(LeadStatus.qualified),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          l10n.proposal,
                          leadProvider.statusFilter == LeadStatus.proposal,
                          () => leadProvider.filterByStatus(LeadStatus.proposal),
                          _getStatusColor(LeadStatus.proposal),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          l10n.negotiation,
                          leadProvider.statusFilter == LeadStatus.negotiation,
                          () => leadProvider.filterByStatus(LeadStatus.negotiation),
                          _getStatusColor(LeadStatus.negotiation),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          l10n.converted,
                          leadProvider.statusFilter == LeadStatus.converted,
                          () => leadProvider.filterByStatus(LeadStatus.converted),
                          _getStatusColor(LeadStatus.converted),
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          l10n.lost,
                          leadProvider.statusFilter == LeadStatus.lost,
                          () => leadProvider.filterByStatus(LeadStatus.lost),
                          _getStatusColor(LeadStatus.lost),
                        ),
                      ],
                    ),
                  ),
                  if (_showRightButton)
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            theme.colorScheme.surface.withOpacity(0),
                            theme.colorScheme.surface,
                          ],
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.chevron_right, size: 20),
                        onPressed: _scrollRight,
                        padding: EdgeInsets.zero,
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                thickness: 6,
                radius: const Radius.circular(10),
                child: RefreshIndicator(
                  onRefresh: () => leadProvider.refreshLeads(),
                  child: leadProvider.leads.isEmpty
                      ? _buildEmptyState(context)
                      : ListView.builder(
                          padding: EdgeInsets.all(mediaQuery.size.width * 0.04),
                          itemCount: leadProvider.leads.length,
                          itemBuilder: (context, index) {
                            final lead = leadProvider.leads[index];
                            return _LeadCard(
                              lead: lead,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LeadDetailScreen(leadId: lead.id),
                                  ),
                                );
                              },
                              statusColor: _getStatusColor(lead.status),
                              priorityColor: _getPriorityColor(lead.priority),
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 100,
              color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.noLeadsFound,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.adjustFilters,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                _searchController.clear();
                context.read<LeadProvider>().searchLeads('');
                context.read<LeadProvider>().filterByStatus(null);
              },
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context)!.clearFilters),
            ),
          ],
        ),
      ),
    );
  }
}

class _LeadCard extends StatelessWidget {
  final Lead lead;
  final VoidCallback onTap;
  final Color statusColor;
  final Color priorityColor;

  const _LeadCard({
    required this.lead,
    required this.onTap,
    required this.statusColor,
    required this.priorityColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(lead.profileImageUrl),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                lead.customerName,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: priorityColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: priorityColor.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                lead.priority.displayName(context).toUpperCase(),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: priorityColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.business,
                              size: 14,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                lead.companyName,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 14,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              lead.mobileNumber,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        lead.status.displayName(context),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 14,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        lead.assignedSalesperson,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    AppLocalizations.of(context)!.nextFollowUp(DateFormat('MMM dd, yyyy').format(lead.nextFollowUpDate)),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
