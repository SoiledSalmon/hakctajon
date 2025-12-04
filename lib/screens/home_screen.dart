import 'package:ai_loan_buddy/animations/ripple_mic_animation.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/dummy_methods.dart';
import 'package:ai_loan_buddy/utils/navigation.dart';
import 'package:ai_loan_buddy/widgets/glass_card.dart';
import 'package:ai_loan_buddy/widgets/language_selector_dropdown.dart';
import 'package:ai_loan_buddy/widgets/profile_bubble_button.dart';
import 'package:ai_loan_buddy/widgets/voice_detect_toggle.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const ctaCardsData = [
    {
      'title': 'Start a Loan Conversation',
      'lottieUrl': 'https://assets5.lottiefiles.com/packages/lf20_1pxqjqps.json',
      'route': RouteNames.chat,
    },
    {
      'title': 'Check My Eligibility',
      'lottieUrl': 'https://assets8.lottiefiles.com/packages/lf20_lq5r1hzy.json',
      'route': RouteNames.eligibility,
    },
    {
      'title': 'Learn About Loans',
      'lottieUrl': 'https://assets3.lottiefiles.com/packages/lf20_wldn4cgm.json',
      'route': RouteNames.education,
    },
    {
      'title': 'Smart Document Checklist',
      'lottieUrl': 'https://assets8.lottiefiles.com/packages/lf20_q4bm7x9p.json',
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

  Widget _buildCTACard(String title, String lottieUrl, VoidCallback onTap) {
    return GlassCard(
      onTap: onTap,
      width: double.infinity,
      height: 140,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Lottie.network(
              lottieUrl,
              fit: BoxFit.contain,
              repeat: true,
              animate: true,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppTheme.primary1,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                      card['lottieUrl'] as String,
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
