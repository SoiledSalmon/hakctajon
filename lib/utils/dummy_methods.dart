import 'dart:developer';

Future<void> sendMessageToAI(String message) async {
  log('sendMessageToAI called with message: $message');
  await Future.delayed(const Duration(seconds: 2));
  log('Dummy AI response ready for message: $message');
}

Future<Map<String, dynamic>> runEligibilityCheck(
  Map<String, dynamic> formData,
) async {
  // Dummy logic - always approve with fixed amount range
  await Future.delayed(const Duration(seconds: 1));
  return {
    'approved': true,
    'eligibleAmountMin': 50000,
    'eligibleAmountMax': 200000,
    'missingDocuments': <String>[],
  };
}

Future<void> generatePDF() async {
  log('generatePDF called - dummy implementation');
  await Future.delayed(const Duration(seconds: 1));
}

void detectLanguage(String languageCode) {
  log('Language changed to: $languageCode');
}

Future<void> startVoiceInput() async {
  log('startVoiceInput called - dummy implementation');
  await Future.delayed(const Duration(seconds: 1));
}
