enum Sender { user, ai }

class ChatMessage {
  final String id;
  final Sender sender;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.message,
    required this.timestamp,
  });
}
