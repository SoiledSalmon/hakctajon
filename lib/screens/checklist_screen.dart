import 'package:ai_loan_buddy/models/document_item.dart';
import 'package:ai_loan_buddy/providers/document_provider.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/widgets/custom_checkbox.dart';
import 'package:ai_loan_buddy/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SmartDocumentChecklistScreen extends ConsumerWidget {
  const SmartDocumentChecklistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(documentProvider);
    final notifier = ref.read(documentProvider.notifier);
    final progress = notifier.progress;
    final checkedCount = notifier.checkedCount;
    final totalCount = notifier.totalCount;

    // Group documents by category
    final Map<DocumentCategory, List<DocumentItem>> groupedDocs = {};
    for (var doc in documents) {
      if (!groupedDocs.containsKey(doc.category)) {
        groupedDocs[doc.category] = [];
      }
      groupedDocs[doc.category]!.add(doc);
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundBase,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar with Progress
          SliverAppBar(
            expandedHeight: 220.0,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.backgroundBase,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppTheme.primary1.withOpacity(0.2),
                      AppTheme.backgroundBase,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Progress',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white70,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '$checkedCount',
                                        style: GoogleFonts.poppins(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.accent1,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '/$totalCount',
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          color: Colors.white54,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' Completed',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.primary1.withOpacity(0.1),
                                border: Border.all(
                                  color: AppTheme.primary1.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                '${(progress * 100).toInt()}%',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.accent1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.black.withOpacity(0.3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.05),
                                offset: const Offset(0, 1),
                                blurRadius: 0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: progress,
                              backgroundColor: Colors.transparent,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppTheme.accent1,
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
            title: Text(
              'Document Checklist',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
          ),

          // Document Lists by Category
          ...DocumentCategory.values.map((category) {
            final docs = groupedDocs[category] ?? [];
            if (docs.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());

            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppTheme.primary1,
                              borderRadius: BorderRadius.circular(2),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primary1.withOpacity(0.5),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _getCategoryTitle(category),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppTheme.neutralWhite,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                          ),
                        ],
                      ),
                    );
                  }

                  final doc = docs[index - 1];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: GlassCard(
                      onTap: () => notifier.toggleCheck(doc.id),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: doc.isChecked
                                  ? AppTheme.accent1.withOpacity(0.2)
                                  : AppTheme.primary1.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              doc.iconData,
                              size: 24,
                              color: doc.isChecked
                                  ? AppTheme.accent1
                                  : AppTheme.primary1,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doc.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: doc.isChecked
                                            ? AppTheme.neutralWhite.withOpacity(0.7)
                                            : AppTheme.neutralWhite,
                                        decoration: doc.isChecked
                                            ? TextDecoration.lineThrough
                                            : null,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  doc.description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Colors.white54,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          CustomAnimatedCheckbox(
                            value: doc.isChecked,
                            onChanged: (_) => notifier.toggleCheck(doc.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: docs.length + 1, // +1 for header
              ),
            );
          }),
          
          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
      floatingActionButton: progress == 1.0
          ? TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('All documents ready! Processing...')),
                      );
                    },
                    backgroundColor: AppTheme.accent1,
                    icon: const Icon(Icons.check_circle, color: Colors.white),
                    label: Text(
                      'Submit All',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            )
          : null,
    );
  }

  String _getCategoryTitle(DocumentCategory category) {
    switch (category) {
      case DocumentCategory.identity:
        return 'Identity Proof';
      case DocumentCategory.income:
        return 'Income Proof';
      case DocumentCategory.property:
        return 'Property & Assets';
      case DocumentCategory.other:
        return 'Additional Documents';
    }
  }
}