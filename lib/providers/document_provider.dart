import 'package:ai_loan_buddy/models/document_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final documentProvider = StateNotifierProvider<DocumentNotifier, List<DocumentItem>>((ref) {
  return DocumentNotifier();
});

class DocumentNotifier extends StateNotifier<List<DocumentItem>> {
  DocumentNotifier() : super(List<DocumentItem>.from(DocumentItem.sampleDocuments));

  void toggleCheck(String id) {
    state = [
      for (final doc in state)
        if (doc.id == id)
          DocumentItem(
            id: doc.id,
            title: doc.title,
            iconData: doc.iconData,
            description: doc.description,
            isChecked: !doc.isChecked,
          )
        else
          doc,
    ];
  }

  double get progress {
    if (state.isEmpty) return 0.0;
    final checkedCount = state.where((doc) => doc.isChecked).length;
    return checkedCount / state.length;
  }
}
