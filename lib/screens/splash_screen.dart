import 'dart:async';
import 'package:ai_loan_buddy/providers/user_provider.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // -------------------------------------------------------
    // ANIMATIONS
    // -------------------------------------------------------
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    _animController.forward();

    // -------------------------------------------------------
    // AFTER ANIMATION: CHECK IF USER IS LOGGED IN
    // -------------------------------------------------------
    Timer(const Duration(seconds: 2), () async {
      if (!mounted) return;

      // Load user data if logged in
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update the Riverpod userProvider with Firebase User
         ref.read(userProvider.notifier).setUser(user);

        if (!mounted) return;
        NavigationUtils.pushReplacementNamed(context, RouteNames.home);
      } else {
        // Not logged in
        if (!mounted) return;
        NavigationUtils.pushReplacementNamed(context, RouteNames.auth);
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primary1, AppTheme.accent1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            transform: GradientRotation(3.1415926 * 3 / 4),
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: size.width * 0.4,
                    height: size.width * 0.4,
                    child: Lottie.network(
                      'https://assets1.lottiefiles.com/packages/lf20_touohxv0.json',
                      controller: _animController,
                      onLoaded: (composition) {
                        // Run your animation smoothly ONCE
                        _animController.duration = composition.duration;
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your Loan Buddy. In Your Language.',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.neutralWhite,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
