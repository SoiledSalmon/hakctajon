import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/navigation.dart';
import 'package:ai_loan_buddy/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.primary1, AppTheme.accent1],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or App Name
                Text(
                  'AI Loan Buddy',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: AppTheme.neutralWhite,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your Financial Companion',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.neutralWhite.withOpacity(0.8),
                      ),
                ),
                const SizedBox(height: 48),

                // Signup Card
                GlassCard(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppTheme.neutralWhite,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 32),

                      // Google Sign Up Button
                      _buildGoogleButton(context, 'Sign up with Google', () {
                        NavigationUtils.pushReplacementNamed(context, RouteNames.home);
                      }),
                      
                      const SizedBox(height: 24),
                      
                      // Divider
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'OR',
                              style: TextStyle(color: Colors.white.withOpacity(0.5)),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.white.withOpacity(0.3))),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Login Link
                      TextButton(
                        onPressed: () {
                          NavigationUtils.pushNamed(context, RouteNames.login);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Already signed up? ',
                            style: TextStyle(color: Colors.white.withOpacity(0.7)),
                            children: const [
                              TextSpan(
                                text: 'Log in',
                                style: TextStyle(
                                  color: AppTheme.accent1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton(BuildContext context, String label, VoidCallback onPressed) {
    const String googleLogoSvg = '''<svg viewBox="0 0 48 48"><path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/><path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/><path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"/><path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"/><path fill="none" d="M0 0h48v48H0z"/></svg>''';

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.string(
                googleLogoSvg,
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
