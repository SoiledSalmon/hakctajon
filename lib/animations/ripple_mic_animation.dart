import 'package:ai_loan_buddy/theme/app_theme.dart';
import 'package:flutter/material.dart';

class RippleMicAnimation extends StatefulWidget {
  final VoidCallback? onTap;

  const RippleMicAnimation({super.key, this.onTap});

  @override
  State<RippleMicAnimation> createState() => _RippleMicAnimationState();
}

class _RippleMicAnimationState extends State<RippleMicAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _radiusAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _radiusAnimation = Tween<double>(
      begin: 30,
      end: 60,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _opacityAnimation = Tween<double>(
      begin: 0.4,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return Container(
                  width: _radiusAnimation.value * 2,
                  height: _radiusAnimation.value * 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primary1.withOpacity(
                      _opacityAnimation.value,
                    ),
                  ),
                );
              },
            ),
            const GlassMicButton(),
          ],
        ),
      ),
    );
  }
}

class GlassMicButton extends StatelessWidget {
  const GlassMicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary1.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Icon(Icons.mic, color: Colors.white, size: 36),
    );
  }
}
