import 'package:ai_loan_buddy/providers/settings_provider.dart';
import 'package:ai_loan_buddy/providers/user_provider.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/navigation.dart';

import 'package:ai_loan_buddy/widgets/glass_card.dart';
import 'package:ai_loan_buddy/widgets/language_selector_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final user = ref.watch(userProvider); // UserProfile model

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'My Profile',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.primary1, AppTheme.backgroundBase],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // 🔥 GOOGLE PROFILE PICTURE
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    image: user?.profilePictureUrl != null
                        ? DecorationImage(
                            image: NetworkImage(user!.profilePictureUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                    gradient: user?.profilePictureUrl == null
                        ? const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppTheme.accent1, AppTheme.accent2],
                          )
                        : null,
                  ),
                  child: user?.profilePictureUrl == null
                      ? Center(
                          child: Text(
                            (user?.name ?? "U")[0],
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 36,
                                ),
                          ),
                        )
                      : null,
                ),

                const SizedBox(height: 16),

                // NAME
                Text(
                  user?.name ?? "User",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),

                const SizedBox(height: 8),

                // Premium Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Premium Member',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.accent1,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),

                const SizedBox(height: 32),

                // Profile Details Card
                GlassCard(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const Divider(height: 32, color: Colors.white24),

                      _buildProfileRow(
                        context,
                        Icons.email_outlined,
                        'Email',
                        user?.email ?? 'Not available',
                      ),

                      const SizedBox(height: 20),

                      _buildProfileRow(
                        context,
                        Icons.calendar_today_outlined,
                        'Member Since',
                        user?.createdAt.toString().split(" ").first ??
                            'Unknown',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // LANGUAGE + THEME
                Row(
                  children: [
                    Expanded(
                      child: GlassCard(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        child: Column(
                          children: [
                            Text(
                              'Language',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            LanguageSelectorDropdown(
                              currentLanguage: settings.languageCode,
                              onChanged: (val) {
                                settingsNotifier.setLanguage(val);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GlassCard(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        child: Column(
                          children: [
                            Text(
                              settings.themeMode == ThemeMode.light
                                  ? 'Light Mode'
                                  : 'Dark Mode',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Switch(
                              value: settings.themeMode == ThemeMode.dark,
                              activeThumbColor: AppTheme.accent1,
                              activeTrackColor: Colors.white24,
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: Colors.white12,
                              onChanged: (_) {
                                settingsNotifier.toggleTheme();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // LOGOUT BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await ref.read(userProvider.notifier).logout();

                      Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteNames.auth,
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      side: BorderSide(
                        color: AppTheme.warning.withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      'Log Out',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.warning,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Profile Row Widget
  Widget _buildProfileRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
