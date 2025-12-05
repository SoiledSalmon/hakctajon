import 'package:flutter/material.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final String illustrationUrl;
  final String audioSummaryUrl;
  final IconData iconData;
  final String category;
  final String duration;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.illustrationUrl,
    required this.audioSummaryUrl,
    required this.iconData,
    required this.category,
    required this.duration,
  });

  static List<Course> sampleCourses = [
    Course(
      id: 'c1',
      title: 'Understanding CIBIL & Credit Score',
      description:
          'Your credit score is the single most important factor in loan approvals. Learn how CIBIL scores are calculated, what factors negatively impact them, and practical steps to improve your score over time. A good score can save you thousands in interest rates.',
      illustrationUrl:
          'https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?auto=format&fit=crop&w=800&q=80',
      audioSummaryUrl: '',
      iconData: Icons.assessment,
      category: 'Essential',
      duration: '5 min read',
    ),
    Course(
      id: 'c2',
      title: 'Why Loan Applications Get Rejected',
      description:
          'Rejection can be disheartening. Discover the top reasons lenders turn down applications—from high debt-to-income ratios to incomplete documentation. Learn how to pre-screen your own profile to ensure a smooth approval process.',
      illustrationUrl:
          'https://images.unsplash.com/photo-1573164713988-8665fc963095?auto=format&fit=crop&w=800&q=80',
      audioSummaryUrl: '',
      iconData: Icons.warning_amber_rounded,
      category: 'Basics',
      duration: '4 min read',
    ),
    Course(
      id: 'c3',
      title: 'EMI Calculator & Interest Types',
      description:
          'Confused by Flat vs. Reducing balance interest rates? Master the math behind Equated Monthly Installments (EMIs). We explain how simple and compound interest work so you can choose the loan structure that costs you the least in the long run.',
      illustrationUrl:
          'https://images.unsplash.com/photo-1565514020176-dbf2238cdb74?auto=format&fit=crop&w=800&q=80',
      audioSummaryUrl: '',
      iconData: Icons.calculate,
      category: 'Advanced',
      duration: '7 min read',
    ),
    Course(
      id: 'c4',
      title: 'Types of Loans & Which to Choose',
      description:
          'Not all loans are created equal. Explore the differences between personal, home, education, and business loans. Understand secured vs. unsecured loans to pick the right financial product for your specific needs.',
      illustrationUrl:
          'https://images.unsplash.com/photo-1601597111158-2fceff292cdc?auto=format&fit=crop&w=800&q=80',
      audioSummaryUrl: '',
      iconData: Icons.account_balance,
      category: 'Guide',
      duration: '6 min read',
    ),
    Course(
      id: 'c5',
      title: 'Documents Required for Approval',
      description:
          'Don\'t let missing paperwork delay your funds. Get a comprehensive checklist of KYC documents, income proofs for salaried vs. self-employed individuals, and property documents needed for secured loans.',
      illustrationUrl:
          'https://images.unsplash.com/photo-1586281380349-632531db7ed4?auto=format&fit=crop&w=800&q=80',
      audioSummaryUrl: '',
      iconData: Icons.folder_open,
      category: 'Checklist',
      duration: '3 min read',
    ),
    Course(
      id: 'c6',
      title: 'Loan Repayment Strategies',
      description:
          'Smart repayment can make you debt-free faster. Learn about prepayment options, how to manage loan defaults if you face a financial crisis, and the benefits of foreclosure to save on interest costs.',
      illustrationUrl:
          'https://images.unsplash.com/photo-1579621970563-ebec7560ff3e?auto=format&fit=crop&w=800&q=80',
      audioSummaryUrl: '',
      iconData: Icons.trending_up,
      category: 'Strategy',
      duration: '5 min read',
    ),
  ];
}
