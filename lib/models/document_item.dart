import 'package:flutter/material.dart';

class DocumentItem {
  final String id;
  final String title;
  final IconData iconData;
  final String description;
  bool isChecked;

  DocumentItem({
    required this.id,
    required this.title,
    required this.iconData,
    required this.description,
    this.isChecked = false,
  });

  static List<DocumentItem> sampleDocuments = [
    DocumentItem(
      id: 'd1',
      title: 'PAN Card',
      iconData: Icons.credit_card,
      description: 'Proof of identity for taxation purposes',
    ),
    DocumentItem(
      id: 'd2',
      title: 'Aadhaar Card',
      iconData: Icons.badge,
      description: 'Unique identification number',
    ),
    DocumentItem(
      id: 'd3',
      title: 'Payslips',
      iconData: Icons.description,
      description: 'Proof of income for recent months',
    ),
    DocumentItem(
      id: 'd4',
      title: 'Bank Statements',
      iconData: Icons.account_balance,
      description: 'Financial transactions history',
    ),
    DocumentItem(
      id: 'd5',
      title: 'Address Proof',
      iconData: Icons.home,
      description: 'Proof of current residence',
    ),
  ];
}
