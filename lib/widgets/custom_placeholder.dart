import 'package:dcd_flut_restaurant/common/styles.dart';
import 'package:flutter/material.dart';

class CustomPlaceholder extends StatelessWidget {
  String message;
  
  CustomPlaceholder({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Icon(
            Icons.restaurant_menu_rounded,
            size: 40,
            color: primaryColor,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: secondaryText,
                ),
          ),
        ],
      ),
    );
  }
}
