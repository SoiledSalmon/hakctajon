import 'package:flutter/material.dart';

enum DocumentCategory {
  identity,
  income,
  property,
  other,
}

class DocumentItem {
  final String id;
  final String title;
  final IconData iconData;
  final String description;
  final DocumentCategory category;
  bool isChecked;

  DocumentItem({
    required this.id,
    required this.title,
    required this.iconData,
    required this.description,
    required this.category,
    this.isChecked = false,
  });

  static List<DocumentItem> sampleDocuments = [
    // Identity Proof
    DocumentItem(
      id: 'id_pan',
      title: 'PAN Card',
      iconData: Icons.credit_card,
      description: 'Permanent Account Number card',
      category: DocumentCategory.identity,
    ),
    DocumentItem(
      id: 'id_aadhaar',
      title: 'Aadhaar Card',
      iconData: Icons.fingerprint,
      description: 'UIDAI identification card',
      category: DocumentCategory.identity,
    ),
    DocumentItem(
      id: 'id_passport',
      title: 'Passport / Voter ID',
      iconData: Icons.account_box,
      description: 'Alternative government photo ID',
      category: DocumentCategory.identity,
    ),
    DocumentItem(
      id: 'id_photo',
      title: 'Passport Photo',
      iconData: Icons.person,
      description: 'Recent passport size photograph',
      category: DocumentCategory.identity,
    ),

    // Income Proof
    DocumentItem(
      id: 'inc_payslip',
      title: 'Payslips',
      iconData: Icons.receipt_long,
      description: 'Last 3 months salary slips',
      category: DocumentCategory.income,
    ),
    DocumentItem(
      id: 'inc_bank',
      title: 'Bank Statements',
      iconData: Icons.account_balance,
      description: 'Last 6 months bank account statements',
      category: DocumentCategory.income,
    ),
    DocumentItem(
      id: 'inc_itr',
      title: 'Form 16 / ITR',
      iconData: Icons.description,
      description: 'Income Tax Returns for last 2 years',
      category: DocumentCategory.income,
    ),
    DocumentItem(
      id: 'inc_emp',
      title: 'Employment Letter',
      iconData: Icons.work,
      description: 'Job contract or confirmation letter',
      category: DocumentCategory.income,
    ),

    // Property/Asset (Optional/Specific)
    DocumentItem(
      id: 'prop_deed',
      title: 'Property Documents',
      iconData: Icons.home_work,
      description: 'Sale deed/Agreement for secured loans',
      category: DocumentCategory.property,
    ),
    DocumentItem(
      id: 'edu_cert',
      title: 'Educational Certs',
      iconData: Icons.school,
      description: 'Degree certificates for education loans',
      category: DocumentCategory.property,
    ),

    // Other/Processing
    DocumentItem(
      id: 'oth_address',
      title: 'Address Proof',
      iconData: Icons.location_on,
      description: 'Utility bill or Rent agreement',
      category: DocumentCategory.other,
    ),
    DocumentItem(
      id: 'oth_cheque',
      title: 'Processing Fee Cheque',
      iconData: Icons.payments,
      description: 'Cheque for loan processing fee',
      category: DocumentCategory.other,
    ),
    DocumentItem(
      id: 'oth_cibil',
      title: 'Credit Report',
      iconData: Icons.analytics,
      description: 'CIBIL/Credit score report',
      category: DocumentCategory.other,
    ),
    DocumentItem(
      id: 'oth_coapp',
      title: 'Co-applicant Docs',
      iconData: Icons.group,
      description: 'KYC for co-applicant if any',
      category: DocumentCategory.other,
    ),
  ];
}