import 'package:ai_loan_buddy/animations/ripple_mic_animation.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/dummy_methods.dart';
import 'package:ai_loan_buddy/utils/navigation.dart';
import 'package:ai_loan_buddy/widgets/glass_card.dart';
import 'package:ai_loan_buddy/widgets/language_selector_dropdown.dart';
import 'package:ai_loan_buddy/widgets/profile_bubble_button.dart';
import 'package:ai_loan_buddy/widgets/voice_detect_toggle.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const ctaCardsData = [
    {
      'title': 'Start a Loan Conversation',
      'icon': Icons.chat_bubble_rounded,
      'color': Color(0xFF4F47E5),
      'route': RouteNames.chat,
    },
    {
      'title': 'Check My Eligibility',
      'icon': Icons.verified_user_rounded,
      'color': Color(0xFF22D3C5),
      'route': RouteNames.eligibility,
    },
    {
      'title': 'Learn About Loans',
      'icon': Icons.school_rounded,
      'color': Color(0xFF6A5AE0),
      'route': RouteNames.education,
    },
    {
      'title': 'Smart Document Checklist',
      'icon': Icons.checklist_rtl_rounded,
      'color': Color(0xFFFF7A45),
      'route': RouteNames.checklist,
    },
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLanguage = 'EN';
  bool voiceDetectEnabled = false;

  void _onLanguageChanged(String lang) {
    setState(() {
      selectedLanguage = lang;
    });
  }

  void _onVoiceDetectToggle(bool enabled) {
    setState(() {
      voiceDetectEnabled = enabled;
    });
  }

  Widget _buildCTACard(String title, IconData icon, Color iconColor, VoidCallback onTap) {
    return GlassCard(
      onTap: onTap,
      width: double.infinity,
      height: 140,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  iconColor,
                  iconColor.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: iconColor.withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              // Top Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Hi! I'm your AI Loan Advisor 👋",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primary1,
                          ),
                    ),
                  ),
                  LanguageSelectorDropdown(
                    currentLanguage: selectedLanguage,
                    onChanged: _onLanguageChanged,
                  ),
                  const SizedBox(width: 8),
                  VoiceDetectToggle(
                    initialValue: voiceDetectEnabled,
                    onChanged: _onVoiceDetectToggle,
                  ),
                  const SizedBox(width: 12),
                  ProfileBubbleButton(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Profile tapped (dummy)')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Middle Section - CTA Cards
              Expanded(
                child: ListView.separated(
                  itemCount: HomeScreen.ctaCardsData.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final card = HomeScreen.ctaCardsData[index];
                    return _buildCTACard(
                      card['title'] as String,
                      card['icon'] as IconData,
                      card['color'] as Color,
                      () {
                        Navigator.of(context).pushNamed(card['route'] as String);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Bottom Section - Floating Mic Button with ripple animation
              Align(
                alignment: Alignment.center,
                child: RippleMicAnimation(
                  onTap: () {
                    startVoiceInput();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Voice input started (dummy)')),
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
