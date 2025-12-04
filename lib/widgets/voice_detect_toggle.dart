import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:ai_loan_buddy/utils/dummy_methods.dart';
import 'package:flutter/material.dart';

class VoiceDetectToggle extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const VoiceDetectToggle({
    super.key,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<VoiceDetectToggle> createState() => _VoiceDetectToggleState();
}

class _VoiceDetectToggleState extends State<VoiceDetectToggle> {
  late bool isEnabled;

  @override
  void initState() {
    super.initState();
    isEnabled = widget.initialValue;
  }

  void _toggle() {
    setState(() {
      isEnabled = !isEnabled;
    });
    widget.onChanged?.call(isEnabled);
    if (isEnabled) {
      startVoiceInput();
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = isEnabled ? AppTheme.accent1 : Colors.grey.shade400;
    return IconButton(
      onPressed: _toggle,
      icon: Icon(Icons.mic, color: color),
      tooltip: isEnabled ? 'Voice Detect ON' : 'Voice Detect OFF',
    );
  }
}
