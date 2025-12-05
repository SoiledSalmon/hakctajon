import 'package:ai_loan_buddy/models/chat_message.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isUser;

  const ChatBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(20),
      topRight: const Radius.circular(20),
      bottomLeft: Radius.circular(isUser ? 20 : 4),
      bottomRight: Radius.circular(isUser ? 4 : 20),
    );

    // Enhanced colors for readability
    final bgColor = isUser
        ? AppTheme.primary1
        : (isDark ? const Color(0xFF2D2D44) : const Color(0xFFF5F5F7));

    final textColor = isUser
        ? AppTheme.neutralWhite
        : (isDark ? Colors.white : Colors.black87);

    final bubble = Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * (isUser ? 0.75 : 0.80),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
        border: !isUser
            ? Border.all(color: AppTheme.accent1.withOpacity(0.2), width: 1)
            : null,
        boxShadow: [
          if (isUser)
            BoxShadow(
              color: AppTheme.primary1.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          else
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: SelectableText(
        message.message,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: isUser ? 15 : 16,
          color: textColor,
          height: isUser ? 1.4 : 1.5,
        ),
      ),
    );

    if (isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: bubble,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8, bottom: 4),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppTheme.primary1.withOpacity(0.1),
              child: const Icon(Icons.smart_toy_outlined,
                  size: 18, color: AppTheme.primary1),
            ),
          ),
          Flexible(child: bubble),
        ],
      ),
    );
  }
}