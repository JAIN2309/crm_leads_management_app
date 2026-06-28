// lib/features/leads/models/lead_model.dart

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Lead {
  final String id;
  final String customerName;
  final String companyName;
  final String email;
  final String mobileNumber;
  final String address;
  final String leadSource;
  final LeadStatus status;
  final LeadPriority priority;
  final String assignedSalesperson;
  final DateTime createdDate;
  final DateTime nextFollowUpDate;
  final String profileImageUrl;
  final List<String> customerImages;
  final List<FollowUp> followUpHistory;

  Lead({
    required this.id,
    required this.customerName,
    required this.companyName,
    required this.email,
    required this.mobileNumber,
    required this.address,
    required this.leadSource,
    required this.status,
    required this.priority,
    required this.assignedSalesperson,
    required this.createdDate,
    required this.nextFollowUpDate,
    required this.profileImageUrl,
    required this.customerImages,
    required this.followUpHistory,
  });

  Lead copyWith({
    String? id,
    String? customerName,
    String? companyName,
    String? email,
    String? mobileNumber,
    String? address,
    String? leadSource,
    LeadStatus? status,
    LeadPriority? priority,
    String? assignedSalesperson,
    DateTime? createdDate,
    DateTime? nextFollowUpDate,
    String? profileImageUrl,
    List<String>? customerImages,
    List<FollowUp>? followUpHistory,
  }) {
    return Lead(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      address: address ?? this.address,
      leadSource: leadSource ?? this.leadSource,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedSalesperson: assignedSalesperson ?? this.assignedSalesperson,
      createdDate: createdDate ?? this.createdDate,
      nextFollowUpDate: nextFollowUpDate ?? this.nextFollowUpDate,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      customerImages: customerImages ?? this.customerImages,
      followUpHistory: followUpHistory ?? this.followUpHistory,
    );
  }
}

enum LeadStatus {
  new_,
  contacted,
  qualified,
  proposal,
  negotiation,
  converted,
  lost,
}

enum LeadPriority {
  low,
  medium,
  high,
  urgent,
}

enum FollowUpType {
  call,
  meeting,
  quotation,
  email,
}

class FollowUp {
  final String id;
  final FollowUpType type;
  final String remark;
  final DateTime date;
  final LeadStatus status;
  final LeadPriority priority;

  FollowUp({
    required this.id,
    required this.type,
    required this.remark,
    required this.date,
    required this.status,
    required this.priority,
  });
}

extension LeadStatusExtension on LeadStatus {
  String displayName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case LeadStatus.new_:
        return l10n.newStatus;
      case LeadStatus.contacted:
        return l10n.contacted;
      case LeadStatus.qualified:
        return l10n.qualified;
      case LeadStatus.proposal:
        return l10n.proposal;
      case LeadStatus.negotiation:
        return l10n.negotiation;
      case LeadStatus.converted:
        return l10n.converted;
      case LeadStatus.lost:
        return l10n.lost;
    }
  }
}

extension LeadPriorityExtension on LeadPriority {
  String displayName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case LeadPriority.low:
        return l10n.low;
      case LeadPriority.medium:
        return l10n.medium;
      case LeadPriority.high:
        return l10n.high;
      case LeadPriority.urgent:
        return l10n.urgent;
    }
  }
}

extension FollowUpTypeExtension on FollowUpType {
  String displayName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case FollowUpType.call:
        return l10n.call;
      case FollowUpType.meeting:
        return l10n.meeting;
      case FollowUpType.quotation:
        return l10n.quotation;
      case FollowUpType.email:
        return l10n.email;
    }
  }
}
