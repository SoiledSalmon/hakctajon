import 'package:ai_loan_buddy/models/chat_message.dart';
import 'package:ai_loan_buddy/providers/chat_provider.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/dummy_methods.dart';
import 'package:ai_loan_buddy/widgets/chat_bubble.dart';
import 'package:ai_loan_buddy/widgets/language_selector_dropdown.dart';
import 'package:ai_loan_buddy/widgets/typing_indicator.dart';
import 'package:file_picker/file_picker.dart';
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

  void _handleFilePicked(PlatformFile file) {
    // Check file size (limit to 10MB)
    const int maxFileSize = 10 * 1024 * 1024; // 10 MB
    if (file.size > maxFileSize) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('File is too large. Maximum size is 10MB.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    final sizeInKb = (file.size / 1024).toStringAsFixed(1);
    final fileInfo = "[File] ${file.name} ($sizeInKb KB)";

    ref.read(chatProvider.notifier).sendUserMessage(fileInfo);
    _scrollToBottom();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attached: ${file.name}')),
    );
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primary1.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.description, color: AppTheme.primary1),
              ),
              title: Text(
                'Upload Document',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              onTap: () async {
                Navigator.pop(context);
                try {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
                  );
                  
                  if (!mounted) return;

                  if (result != null && result.files.isNotEmpty) {
                    _handleFilePicked(result.files.first);
                  }
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error picking file: $e'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.accent1.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.image, color: AppTheme.accent1),
              ),
              title: Text(
                'Gallery',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              onTap: () async {
                Navigator.pop(context);
                try {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );

                  if (!mounted) return;

                  if (result != null && result.files.isNotEmpty) {
                    _handleFilePicked(result.files.first);
                  }
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error picking image: $e'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
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
            const Expanded(child: Text('AI Loan Advisor')),
            LanguageSelectorDropdown(
              currentLanguage: selectedLanguage,
              onChanged: _onLanguageChanged,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Theme.of(context).dividerColor.withOpacity(0.05),
            height: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              itemCount: messages.length + (isSending ? 1 : 0),
              itemBuilder: (context, index) {
                if (isSending && index == messages.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TypingIndicator(),
                    ),
                  );
                }
                final message = messages[index];
                final isUser = message.sender == Sender.user;
                return ChatBubble(message: message, isUser: isUser);
              },
            ),
          ),
          // Quick Action Chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
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
                ],
              ),
            ),
          ),
          // Footer with input
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
            child: Row(
              children: [
                IconButton(
                  onPressed: _showAttachmentOptions,
                  icon: const Icon(Icons.add_circle_outline, size: 28),
                  color: AppTheme.primary1,
                  tooltip: 'Add attachment',
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Theme.of(context).dividerColor.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _sendMessage(),
                            decoration: const InputDecoration(
                              hintText: 'Type your message...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            startVoiceInput();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Voice input started (dummy)'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.mic, size: 20),
                          color: AppTheme.primary1,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: AppTheme.primary1,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send, size: 20),
                    color: Colors.white,
                    tooltip: 'Send',
                  ),
                ),
              ],
            ),
          ),
        ],
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
      padding: const EdgeInsets.only(right: 8),
      child: ActionChip(
        label: Text(label),
        onPressed: onTap,
        backgroundColor: AppTheme.accent1.withOpacity(0.1),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppTheme.primary1,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}