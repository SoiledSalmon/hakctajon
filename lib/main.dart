import 'package:ai_loan_buddy/screens/chat_screen.dart';
import 'package:ai_loan_buddy/screens/checklist_screen.dart';
import 'package:ai_loan_buddy/screens/education_screen.dart';
import 'package:ai_loan_buddy/screens/eligibility_screen.dart';
import 'package:ai_loan_buddy/screens/home_screen.dart';
import 'package:ai_loan_buddy/screens/pdf_preview_screen.dart';
import 'package:ai_loan_buddy/screens/profile_screen.dart';
import 'package:ai_loan_buddy/screens/settings_screen.dart';
import 'package:ai_loan_buddy/screens/splash_screen.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const ProviderScope(child: AILoanBuddyApp()));
}

class AILoanBuddyApp extends ConsumerWidget {
  const AILoanBuddyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Loan Buddy',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: RouteNames.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteNames.chat:
        return MaterialPageRoute(builder: (_) => const AIChatScreen());
      case RouteNames.eligibility:
        return MaterialPageRoute(builder: (_) => const EligibilityCheckerScreen());
      case RouteNames.education:
        return MaterialPageRoute(builder: (_) => const FinancialEducationScreen());
      case RouteNames.checklist:
        return MaterialPageRoute(builder: (_) => const SmartDocumentChecklistScreen());
      case RouteNames.pdfPreview:
        return MaterialPageRoute(builder: (_) => const PDFPreviewScreen());
      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case RouteNames.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
