import 'package:ai_loan_buddy/models/course.dart';
import 'package:ai_loan_buddy/widgets/course_card.dart';
import 'package:flutter/material.dart';

class FinancialEducationScreen extends StatelessWidget {
  const FinancialEducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = Course.sampleCourses;

    return Scaffold(
      appBar: AppBar(title: const Text('Financial Education')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: courses.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 3 / 4,
            ),
            itemBuilder: (context, index) {
              final course = courses[index];
              return CourseCard(
                course: course,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CourseDetailScreen(course: course),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Image.network(
              course.illustrationUrl,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(height: 200, color: Colors.grey.shade300),
            ),
            const SizedBox(height: 20),
            Text(
              course.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Audio summary played (dummy)')),
                );
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('Play Audio Summary'),
            ),
          ],
        ),
      ),
    );
  }
}
