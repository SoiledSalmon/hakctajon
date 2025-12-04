class Course {
  final String id;
  final String title;
  final String description;
  final String illustrationUrl;
  final String audioSummaryUrl;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.illustrationUrl,
    required this.audioSummaryUrl,
  });

  static List<Course> sampleCourses = [
    Course(
      id: 'c1',
      title: 'What Is CIBIL?',
      description:
          'Learn about the CIBIL credit score, how it affects your loan approval chances, and ways to improve it.',
      illustrationUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=400&q=80',
      audioSummaryUrl: '',
    ),
    Course(
      id: 'c2',
      title: 'Why Banks Reject Loans',
      description:
          'Understand common reasons why banks reject loan applications and how you can avoid these pitfalls.',
      illustrationUrl:
          'https://images.unsplash.com/photo-1556740749-887f6717d7e4?auto=format&fit=crop&w=400&q=80',
      audioSummaryUrl: '',
    ),
    Course(
      id: 'c3',
      title: 'How EMI Works',
      description:
          'A detailed look at Equated Monthly Installments (EMI) and how they affect your loan repayment.',
      illustrationUrl:
          'https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=400&q=80',
      audioSummaryUrl: '',
    ),
    Course(
      id: 'c4',
      title: 'Simple vs Compound Interest',
      description:
          'Learn the difference between simple and compound interest and their impact on loan costs.',
      illustrationUrl:
          'https://images.unsplash.com/photo-1496307042754-b4aa456c4a2d?auto=format&fit=crop&w=400&q=80',
      audioSummaryUrl: '',
    ),
    Course(
      id: 'c5',
      title: 'Improve Approval Chances',
      description:
          'Tips and tricks on how to improve your chances of getting a loan approved by financial institutions.',
      illustrationUrl:
          'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=400&q=80',
      audioSummaryUrl: '',
    ),
  ];
}
