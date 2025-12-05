import 'package:ai_loan_buddy/models/chat_message.dart';
import 'package:ai_loan_buddy/providers/chat_provider.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/dummy_methods.dart';
import 'package:ai_loan_buddy/widgets/chat_bubble.dart';
import 'package:ai_loan_buddy/widgets/language_selector_dropdown.dart';
import 'package:ai_loan_buddy/widgets/typing_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AIChatScreen extends ConsumerStatefulWidget {
  const AIChatScreen({super.key});

  @override
  ConsumerState<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends ConsumerState<AIChatScreen> {
  String selectedLanguage = 'EN';
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _onLanguageChanged(String lang) {
    setState(() {
      selectedLanguage = lang;
    });
    detectLanguage(lang);
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    await ref.read(chatProvider.notifier).sendUserMessage(text);
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatProvider);
    final isSending = ref.read(chatProvider.notifier).isSending;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_5ngs2ksb.json',
                repeat: true,
                animate: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: Text('AI Loan Advisor')),
            LanguageSelectorDropdown(
              currentLanguage: selectedLanguage,
              onChanged: _onLanguageChanged,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 2,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat messages list
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: messages.length + (isSending ? 1 : 0),
                itemBuilder: (context, index) {
                  if (isSending && index == messages.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TypingIndicator(),
                    );
                  }
                  final message = messages[index];
                  final isUser = message.sender == Sender.user;
                  return ChatBubble(message: message, isUser: isUser);
                },
              ),
            ),
            const Divider(height: 1),
            // Quick Action Chips
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _QuickActionChip(
                      label: 'Check eligibility',
                      onTap: () {
                        Navigator.of(context).pushNamed('/eligibility');
                      },
                    ),
                    _QuickActionChip(
                      label: 'Required documents',
                      onTap: () {
                        Navigator.of(context).pushNamed('/checklist');
                      },
                    ),
                    _QuickActionChip(
                      label: 'Explain loan types',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Explain loan types tapped (dummy)'),
                          ),
                        );
                      },
                    ),
                    _QuickActionChip(
                      label: 'My next step',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('My next step tapped (dummy)'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Footer with input
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      startVoiceInput();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Voice input started (dummy)'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.mic),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: const InputDecoration.collapsed(
                        hintText: 'Type your message',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Attachment tapped (dummy)'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.attach_file),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickActionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ActionChip(
        label: Text(label),
        onPressed: onTap,
        backgroundColor: AppTheme.accent1.withOpacity(0.2),
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppTheme.primary1,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
