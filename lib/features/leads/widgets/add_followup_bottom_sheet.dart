// lib/features/leads/widgets/add_followup_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/lead_model.dart';
import '../providers/lead_provider.dart';

class AddFollowUpBottomSheet extends StatefulWidget {
  final String leadId;

  const AddFollowUpBottomSheet({super.key, required this.leadId});

  @override
  State<AddFollowUpBottomSheet> createState() => _AddFollowUpBottomSheetState();
}

class _AddFollowUpBottomSheetState extends State<AddFollowUpBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _remarkController = TextEditingController();
  DateTime? _selectedDate;
  FollowUpType _selectedType = FollowUpType.call;
  LeadStatus _selectedStatus = LeadStatus.contacted;
  LeadPriority _selectedPriority = LeadPriority.medium;

  @override
  void dispose() {
    _remarkController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a follow-up date'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final followUp = FollowUp(
        id: 'f_${DateTime.now().millisecondsSinceEpoch}',
        type: _selectedType,
        remark: _remarkController.text.trim(),
        date: _selectedDate!,
        status: _selectedStatus,
        priority: _selectedPriority,
      );

      context.read<LeadProvider>().addFollowUp(widget.leadId, followUp);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Follow-up added successfully'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.only(
        bottom: mediaQuery.viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.addFollowUp,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<FollowUpType>(
                  value: _selectedType,
                  decoration: InputDecoration(
                    labelText: l10n.selectType,
                    prefixIcon: const Icon(Icons.category),
                  ),
                  items: FollowUpType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type.displayName(context)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedType = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _remarkController,
                  decoration: InputDecoration(
                    labelText: l10n.remark,
                    hintText: l10n.remark,
                    prefixIcon: const Icon(Icons.notes),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.remarkRequired;
                    }
                    if (value.trim().length < 10) {
                      return l10n.remarkTooShort;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: l10n.date,
                      prefixIcon: const Icon(Icons.calendar_today),
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                    ),
                    child: Text(
                      _selectedDate == null
                          ? l10n.selectDate
                          : DateFormat('MMMM dd, yyyy').format(_selectedDate!),
                      style: TextStyle(
                        color: _selectedDate == null
                            ? theme.colorScheme.onSurfaceVariant
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<LeadStatus>(
                  value: _selectedStatus,
                  decoration: InputDecoration(
                    labelText: l10n.status,
                    prefixIcon: const Icon(Icons.flag),
                  ),
                  items: LeadStatus.values.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status.displayName(context)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedStatus = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<LeadPriority>(
                  value: _selectedPriority,
                  decoration: InputDecoration(
                    labelText: l10n.priority,
                    prefixIcon: const Icon(Icons.priority_high),
                  ),
                  items: LeadPriority.values.map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority.displayName(context)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedPriority = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _handleSubmit,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(l10n.submit),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
