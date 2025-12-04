import 'dart:async';
import 'package:ai_loan_buddy/models/chat_message.dart';
import 'package:ai_loan_buddy/utils/dummy_methods.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatProvider =
    StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) => ChatNotifier());

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super(_initialMessages);

  static final _uuid = const Uuid();

  static final List<ChatMessage> _initialMessages = [];

  bool _isSending = false;

  bool get isSending => _isSending;

  Future<void> sendUserMessage(String text) async {
    if (text.trim().isEmpty) return;
    final userMessage = ChatMessage(
      id: _uuid.v4(),
      sender: Sender.user,
      message: text.trim(),
      timestamp: DateTime.now(),
    );
    state = [...state, userMessage];
    _isSending = true;
    state = [...state];
    await sendMessageToAI(text);
    // Add dummy AI response after delay
    final aiMessage = ChatMessage(
      id: _uuid.v4(),
      sender: Sender.ai,
      message: 'This is a dummy AI response to: "$text"',
      timestamp: DateTime.now(),
    );
    _isSending = false;
    state = [...state, aiMessage];
  }

  void clearConversation() {
    state = [];
  }
}
