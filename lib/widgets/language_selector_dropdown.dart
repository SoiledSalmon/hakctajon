import 'package:ai_loan_buddy/utils/dummy_methods.dart';
import 'package:flutter/material.dart';

class LanguageSelectorDropdown extends StatefulWidget {
  final String currentLanguage;
  final ValueChanged<String> onChanged;

  const LanguageSelectorDropdown({
    super.key,
    required this.currentLanguage,
    required this.onChanged,
  });

  @override
  State<LanguageSelectorDropdown> createState() =>
      _LanguageSelectorDropdownState();
}

class _LanguageSelectorDropdownState extends State<LanguageSelectorDropdown> {
  late String selectedLanguage;

  static const languages = ['EN', 'HI', 'KN'];

  @override
  void initState() {
    super.initState();
    selectedLanguage = widget.currentLanguage.toUpperCase();
  }

  @override
  void didUpdateWidget(covariant LanguageSelectorDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentLanguage.toUpperCase() != selectedLanguage) {
      setState(() {
        selectedLanguage = widget.currentLanguage.toUpperCase();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedLanguage,
      underline: const SizedBox.shrink(),
      dropdownColor: Colors.white.withOpacity(0.9),
      items: languages
          .map((lang) => DropdownMenuItem(value: lang, child: Text(lang)))
          .toList(),
      onChanged: (value) {
        if (value != null && value != selectedLanguage) {
          setState(() {
            selectedLanguage = value;
          });
          detectLanguage(value);
          widget.onChanged(value);
        }
      },
    );
  }
}
