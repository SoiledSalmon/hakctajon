import 'package:ai_loan_buddy/providers/document_provider.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SmartDocumentChecklistScreen extends ConsumerWidget {
  const SmartDocumentChecklistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(documentProvider);
    final notifier = ref.read(documentProvider.notifier);
    final progress = notifier.progress;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Document Checklist'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey.shade300,
                color: AppTheme.primary1,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: documents.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final doc = documents[index];
                    return GlassCard(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Icon(
                            doc.iconData,
                            size: 36,
                            color: AppTheme.primary1,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc.title,
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: AppTheme.primary1,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  doc.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Checkbox(
                            value: doc.isChecked,
                            onChanged: (_) {
                              notifier.toggleCheck(doc.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
