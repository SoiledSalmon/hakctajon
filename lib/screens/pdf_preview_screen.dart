import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/dummy_methods.dart';
import 'package:flutter/material.dart';

class PDFPreviewScreen extends StatelessWidget {
  const PDFPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const dummyProfile = {
      'Name': 'John Doe',
      'Age': '30',
      'Loan Type': 'Personal Loan',
    };

    const dummyEligibility = {
      'Approved': 'Yes',
      'Eligible Amount': '₹50,000 - ₹200,000',
    };

    const dummyDocuments = [
      'PAN Card: Provided',
      'Aadhaar Card: Provided',
      'Payslips: Missing',
    ];

    const dummyAINotes =
        'Based on your profile and documents, you are eligible for a personal loan between ₹50,000 and ₹200,000. Please submit the missing payslips to improve approval chances.';

    return Scaffold(
      appBar: AppBar(title: const Text('PDF Preview')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 600),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Applicant Profile',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const Divider(height: 20),
                  ...dummyProfile.entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '${e.key}: ${e.value}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Eligibility Results',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const Divider(height: 20),
                  ...dummyEligibility.entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        '${e.key}: ${e.value}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Document Checklist',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const Divider(height: 20),
                  ...dummyDocuments.map(
                    (doc) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(doc, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'AI Notes',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const Divider(height: 20),
                  Text(dummyAINotes, style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        generatePDF();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Download PDF (dummy)')),
                        );
                      },
                      icon: const Icon(Icons.download),
                      label: const Text('Download PDF'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: AppTheme.primary1,
                        foregroundColor: AppTheme.neutralWhite,
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
