import 'package:flutter/material.dart';

class ProfileBubbleButton extends StatelessWidget {
  final VoidCallback? onTap;

  const ProfileBubbleButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
          return;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile action tapped (dummy)'),
          ),
        );
      },
      borderRadius: BorderRadius.circular(40),
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.grey.shade300,
        child: const Icon(
          Icons.person,
          color: Colors.black54,
          size: 28,
        ),
      ),
    );
  }
}
