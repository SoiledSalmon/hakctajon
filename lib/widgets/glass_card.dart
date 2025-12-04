import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ai_loan_buddy/theme/app_theme.dart';

class GlassCard extends StatefulWidget {
  final Widget? child;
  final Widget Function(BuildContext context, bool isPressed)? childBuilder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? splashColor;

  const GlassCard({
    super.key,
    this.child,
    this.childBuilder,
    this.onTap,
    this.padding,
    this.width,
    this.height,
    this.splashColor,
  }) : assert(child != null || childBuilder != null, 'Either child or childBuilder must be provided');

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isPressed = false;
  bool _isHovered = false;

  bool get _isActive => _isPressed || _isHovered;

  @override
  Widget build(BuildContext context) {
    // Gradient Border Implementation
    return AnimatedScale(
      scale: _isActive ? 1.02 : 1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: AppTheme.neonBorderGradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isActive ? 0.25 : 0.15),
              blurRadius: _isActive ? 35 : 30,
              offset: Offset(0, _isActive ? 15 : 10),
              spreadRadius: _isActive ? 4 : 2,
            ),
            BoxShadow(
              color: AppTheme.primary1.withOpacity(_isActive ? 0.3 : 0.2),
              blurRadius: _isActive ? 25 : 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(2.5), // Border width
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.5), // Adjust for border width
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: widget.padding ?? const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16.5),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.25),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
              ),
              child: widget.onTap != null
                  ? InkWell(
                      onTap: widget.onTap,
                      onHighlightChanged: (val) {
                        setState(() {
                          _isPressed = val;
                        });
                      },
                      onHover: (val) {
                        setState(() {
                          _isHovered = val;
                        });
                      },
                      splashColor: widget.splashColor,
                      borderRadius: BorderRadius.circular(16.5),
                      child: widget.childBuilder != null
                          ? widget.childBuilder!(context, _isActive)
                          : widget.child!,
                    )
                  : (widget.childBuilder != null
                      ? widget.childBuilder!(context, _isActive)
                      : widget.child!),
            ),
          ),
        ),
      ),
    );
  }
}
