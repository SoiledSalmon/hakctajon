import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/navigation.dart';
import 'package:ai_loan_buddy/widgets/glass_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {
               Navigator.of(context).pushNamed(RouteNames.settings);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.primary1,
              AppTheme.backgroundBase,
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Avatar Section
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppTheme.accent1, AppTheme.accent2],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'JD',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 32,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'John Doe',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

                // Profile Details Section
                GlassCard(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Personal Information',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          TextButton(
                            onPressed: () {}, // Dummy action
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Edit',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.accent1,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32, color: Colors.white24),
                      _buildProfileRow(context, Icons.email_outlined, 'Email', 'john.doe@example.com'),
                      const SizedBox(height: 20),
                      _buildProfileRow(context, Icons.phone_outlined, 'Phone', '+1 (555) 123-4567'),
                      const SizedBox(height: 20),
                      _buildProfileRow(context, Icons.calendar_today_outlined, 'Member Since', 'Dec 2023'),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Account Stats Section
                Row(
                  children: [
                    Expanded(
                      child: GlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              '12',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: AppTheme.accent1,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Loans Checked',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: GlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              '5',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    color: AppTheme.warning,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Docs Uploaded',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {}, // Dummy action
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      side: BorderSide(color: AppTheme.warning.withOpacity(0.5)),
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

  Widget _buildProfileRow(BuildContext context, IconData icon, String label, String value) {
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
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
