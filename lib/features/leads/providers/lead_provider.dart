// lib/features/leads/providers/lead_provider.dart

import 'package:flutter/material.dart';
import '../models/lead_model.dart';

class LeadProvider extends ChangeNotifier {
  List<Lead> _leads = [];
  List<Lead> _filteredLeads = [];
  String _searchQuery = '';
  LeadStatus? _statusFilter;

  LeadProvider() {
    _initializeMockData();
  }

  List<Lead> get leads => _filteredLeads;
  String get searchQuery => _searchQuery;
  LeadStatus? get statusFilter => _statusFilter;

  int get totalLeads => _leads.length;

  int get todaysFollowUps {
    final today = DateTime.now();
    return _leads.where((lead) {
      return lead.nextFollowUpDate.year == today.year &&
          lead.nextFollowUpDate.month == today.month &&
          lead.nextFollowUpDate.day == today.day;
    }).length;
  }

  List<Lead> get todaysFollowUpLeads {
    final today = DateTime.now();
    return _leads.where((lead) {
      return lead.nextFollowUpDate.year == today.year &&
          lead.nextFollowUpDate.month == today.month &&
          lead.nextFollowUpDate.day == today.day;
    }).toList();
  }

  int get convertedLeads =>
      _leads.where((lead) => lead.status == LeadStatus.converted).length;

  int get pendingLeads => _leads
      .where((lead) =>
          lead.status != LeadStatus.converted && lead.status != LeadStatus.lost)
      .length;

  void searchLeads(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void filterByStatus(LeadStatus? status) {
    _statusFilter = status;
    _applyFilters();
  }

  void filterByTodaysFollowUps() {
    _statusFilter = null;
    _searchQuery = '';
    _filteredLeads = todaysFollowUpLeads;
    notifyListeners();
  }

  void clearFilters() {
    _statusFilter = null;
    _searchQuery = '';
    _filteredLeads = _leads;
    notifyListeners();
  }

  void _applyFilters() {
    _filteredLeads = _leads.where((lead) {
      final matchesSearch = _searchQuery.isEmpty ||
          lead.customerName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          lead.companyName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          lead.mobileNumber.contains(_searchQuery);

      final matchesStatus =
          _statusFilter == null || lead.status == _statusFilter;

      return matchesSearch && matchesStatus;
    }).toList();
    notifyListeners();
  }

  Lead? getLeadById(String id) {
    try {
      return _leads.firstWhere((lead) => lead.id == id);
    } catch (e) {
      return null;
    }
  }

  void addFollowUp(String leadId, FollowUp followUp) {
    final leadIndex = _leads.indexWhere((lead) => lead.id == leadId);
    if (leadIndex != -1) {
      final updatedFollowUpHistory = List<FollowUp>.from(_leads[leadIndex].followUpHistory)
        ..add(followUp);
      
      _leads[leadIndex] = _leads[leadIndex].copyWith(
        followUpHistory: updatedFollowUpHistory,
        nextFollowUpDate: followUp.date,
        status: followUp.status,
      );
      _applyFilters();
    }
  }

  void addCustomerImage(String leadId, String imagePath) {
    final leadIndex = _leads.indexWhere((lead) => lead.id == leadId);
    if (leadIndex != -1) {
      final updatedImages = List<String>.from(_leads[leadIndex].customerImages)
        ..add(imagePath);
      
      _leads[leadIndex] = _leads[leadIndex].copyWith(
        customerImages: updatedImages,
      );
      notifyListeners();
    }
  }

  void deleteCustomerImage(String leadId, String imagePath) {
    final leadIndex = _leads.indexWhere((lead) => lead.id == leadId);
    if (leadIndex != -1) {
      final updatedImages = List<String>.from(_leads[leadIndex].customerImages)
        ..remove(imagePath);
      
      _leads[leadIndex] = _leads[leadIndex].copyWith(
        customerImages: updatedImages,
      );
      notifyListeners();
    }
  }

  Future<void> refreshLeads() async {
    await Future.delayed(const Duration(seconds: 1));
    notifyListeners();
  }

  void _initializeMockData() {
    _leads = [
      Lead(
        id: '1',
        customerName: 'John Doe',
        companyName: 'Tech Solutions Inc.',
        email: 'john.doe@techsolutions.com',
        mobileNumber: '+1 234 567 8900',
        address: '123 Main St, San Francisco, CA 94102',
        leadSource: 'Website',
        status: LeadStatus.qualified,
        priority: LeadPriority.high,
        assignedSalesperson: 'Sarah Johnson',
        createdDate: DateTime.now().subtract(const Duration(days: 15)),
        nextFollowUpDate: DateTime.now(),
        profileImageUrl: 'https://i.pravatar.cc/150?img=12',
        customerImages: [
          'https://picsum.photos/400/300?random=1',
          'https://picsum.photos/400/300?random=2',
          'https://picsum.photos/400/300?random=3',
        ],
        followUpHistory: [
          FollowUp(
            id: 'f1',
            type: FollowUpType.call,
            remark: 'Initial contact made. Customer interested in enterprise package.',
            date: DateTime.now().subtract(const Duration(days: 15)),
            status: LeadStatus.contacted,
            priority: LeadPriority.medium,
          ),
          FollowUp(
            id: 'f2',
            type: FollowUpType.meeting,
            remark: 'Demo scheduled for next week. Customer wants to see advanced features.',
            date: DateTime.now().subtract(const Duration(days: 10)),
            status: LeadStatus.qualified,
            priority: LeadPriority.high,
          ),
          FollowUp(
            id: 'f3',
            type: FollowUpType.quotation,
            remark: 'Sent detailed quotation with customization options.',
            date: DateTime.now().subtract(const Duration(days: 5)),
            status: LeadStatus.qualified,
            priority: LeadPriority.high,
          ),
        ],
      ),
      Lead(
        id: '2',
        customerName: 'Emily Chen',
        companyName: 'Global Enterprises Ltd.',
        email: 'emily.chen@globalenterprises.com',
        mobileNumber: '+1 234 567 8901',
        address: '456 Market St, New York, NY 10001',
        leadSource: 'Referral',
        status: LeadStatus.negotiation,
        priority: LeadPriority.urgent,
        assignedSalesperson: 'Michael Brown',
        createdDate: DateTime.now().subtract(const Duration(days: 20)),
        nextFollowUpDate: DateTime.now().add(const Duration(days: 1)),
        profileImageUrl: 'https://i.pravatar.cc/150?img=5',
        customerImages: [
          'https://picsum.photos/400/300?random=4',
          'https://picsum.photos/400/300?random=5',
        ],
        followUpHistory: [
          FollowUp(
            id: 'f4',
            type: FollowUpType.call,
            remark: 'Discussed pricing and contract terms.',
            date: DateTime.now().subtract(const Duration(days: 20)),
            status: LeadStatus.contacted,
            priority: LeadPriority.high,
          ),
          FollowUp(
            id: 'f5',
            type: FollowUpType.meeting,
            remark: 'Final negotiation meeting. Customer requesting 10% discount.',
            date: DateTime.now().subtract(const Duration(days: 3)),
            status: LeadStatus.negotiation,
            priority: LeadPriority.urgent,
          ),
        ],
      ),
      Lead(
        id: '3',
        customerName: 'Robert Martinez',
        companyName: 'Innovate Systems',
        email: 'robert.m@innovatesystems.com',
        mobileNumber: '+1 234 567 8902',
        address: '789 Tech Blvd, Austin, TX 73301',
        leadSource: 'LinkedIn',
        status: LeadStatus.converted,
        priority: LeadPriority.high,
        assignedSalesperson: 'Sarah Johnson',
        createdDate: DateTime.now().subtract(const Duration(days: 45)),
        nextFollowUpDate: DateTime.now().subtract(const Duration(days: 5)),
        profileImageUrl: 'https://i.pravatar.cc/150?img=33',
        customerImages: [
          'https://picsum.photos/400/300?random=6',
        ],
        followUpHistory: [
          FollowUp(
            id: 'f6',
            type: FollowUpType.call,
            remark: 'Initial inquiry about CRM solutions.',
            date: DateTime.now().subtract(const Duration(days: 45)),
            status: LeadStatus.new_,
            priority: LeadPriority.medium,
          ),
          FollowUp(
            id: 'f7',
            type: FollowUpType.meeting,
            remark: 'Product demo completed successfully.',
            date: DateTime.now().subtract(const Duration(days: 30)),
            status: LeadStatus.qualified,
            priority: LeadPriority.high,
          ),
          FollowUp(
            id: 'f8',
            type: FollowUpType.quotation,
            remark: 'Contract signed! Successfully converted.',
            date: DateTime.now().subtract(const Duration(days: 5)),
            status: LeadStatus.converted,
            priority: LeadPriority.high,
          ),
        ],
      ),
      Lead(
        id: '4',
        customerName: 'Sarah Williams',
        companyName: 'Digital Dynamics',
        email: 'sarah.w@digitaldynamics.com',
        mobileNumber: '+1 234 567 8903',
        address: '321 Innovation Dr, Seattle, WA 98101',
        leadSource: 'Trade Show',
        status: LeadStatus.new_,
        priority: LeadPriority.medium,
        assignedSalesperson: 'David Lee',
        createdDate: DateTime.now().subtract(const Duration(days: 2)),
        nextFollowUpDate: DateTime.now().add(const Duration(days: 2)),
        profileImageUrl: 'https://i.pravatar.cc/150?img=20',
        customerImages: [],
        followUpHistory: [
          FollowUp(
            id: 'f9',
            type: FollowUpType.email,
            remark: 'Sent welcome email with company brochure.',
            date: DateTime.now().subtract(const Duration(days: 2)),
            status: LeadStatus.new_,
            priority: LeadPriority.medium,
          ),
        ],
      ),
      Lead(
        id: '5',
        customerName: 'James Anderson',
        companyName: 'CloudFirst Corp',
        email: 'james.a@cloudfirst.com',
        mobileNumber: '+1 234 567 8904',
        address: '555 Cloud Ave, Boston, MA 02101',
        leadSource: 'Google Ads',
        status: LeadStatus.proposal,
        priority: LeadPriority.high,
        assignedSalesperson: 'Michael Brown',
        createdDate: DateTime.now().subtract(const Duration(days: 12)),
        nextFollowUpDate: DateTime.now(),
        profileImageUrl: 'https://i.pravatar.cc/150?img=15',
        customerImages: [
          'https://picsum.photos/400/300?random=7',
          'https://picsum.photos/400/300?random=8',
          'https://picsum.photos/400/300?random=9',
          'https://picsum.photos/400/300?random=10',
        ],
        followUpHistory: [
          FollowUp(
            id: 'f10',
            type: FollowUpType.call,
            remark: 'Discussed cloud integration requirements.',
            date: DateTime.now().subtract(const Duration(days: 12)),
            status: LeadStatus.contacted,
            priority: LeadPriority.medium,
          ),
          FollowUp(
            id: 'f11',
            type: FollowUpType.meeting,
            remark: 'Technical consultation completed.',
            date: DateTime.now().subtract(const Duration(days: 7)),
            status: LeadStatus.qualified,
            priority: LeadPriority.high,
          ),
          FollowUp(
            id: 'f12',
            type: FollowUpType.quotation,
            remark: 'Sent comprehensive proposal with timeline.',
            date: DateTime.now().subtract(const Duration(days: 2)),
            status: LeadStatus.proposal,
            priority: LeadPriority.high,
          ),
        ],
      ),
      Lead(
        id: '6',
        customerName: 'Lisa Thompson',
        companyName: 'Retail Pro Solutions',
        email: 'lisa.t@retailpro.com',
        mobileNumber: '+1 234 567 8905',
        address: '888 Commerce St, Chicago, IL 60601',
        leadSource: 'Website',
        status: LeadStatus.contacted,
        priority: LeadPriority.low,
        assignedSalesperson: 'Sarah Johnson',
        createdDate: DateTime.now().subtract(const Duration(days: 8)),
        nextFollowUpDate: DateTime.now().add(const Duration(days: 3)),
        profileImageUrl: 'https://i.pravatar.cc/150?img=9',
        customerImages: [
          'https://picsum.photos/400/300?random=11',
        ],
        followUpHistory: [
          FollowUp(
            id: 'f13',
            type: FollowUpType.call,
            remark: 'Left voicemail, waiting for callback.',
            date: DateTime.now().subtract(const Duration(days: 8)),
            status: LeadStatus.new_,
            priority: LeadPriority.low,
          ),
          FollowUp(
            id: 'f14',
            type: FollowUpType.email,
            remark: 'Sent follow-up email with product details.',
            date: DateTime.now().subtract(const Duration(days: 4)),
            status: LeadStatus.contacted,
            priority: LeadPriority.low,
          ),
        ],
      ),
      Lead(
        id: '7',
        customerName: 'David Kim',
        companyName: 'Startup Hub Inc.',
        email: 'david.kim@startuphub.com',
        mobileNumber: '+1 234 567 8906',
        address: '999 Venture Rd, Palo Alto, CA 94301',
        leadSource: 'Referral',
        status: LeadStatus.lost,
        priority: LeadPriority.medium,
        assignedSalesperson: 'David Lee',
        createdDate: DateTime.now().subtract(const Duration(days: 30)),
        nextFollowUpDate: DateTime.now().subtract(const Duration(days: 10)),
        profileImageUrl: 'https://i.pravatar.cc/150?img=68',
        customerImages: [],
        followUpHistory: [
          FollowUp(
            id: 'f15',
            type: FollowUpType.call,
            remark: 'Initial discussion about startup package.',
            date: DateTime.now().subtract(const Duration(days: 30)),
            status: LeadStatus.contacted,
            priority: LeadPriority.medium,
          ),
          FollowUp(
            id: 'f16',
            type: FollowUpType.meeting,
            remark: 'Customer went with competitor. Budget constraints.',
            date: DateTime.now().subtract(const Duration(days: 10)),
            status: LeadStatus.lost,
            priority: LeadPriority.medium,
          ),
        ],
      ),
    ];
    _filteredLeads = _leads;
  }
}
