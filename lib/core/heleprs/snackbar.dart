import 'package:flutter/material.dart';
import 'package:home_widget_4/core/globals/globals_var.dart';
import 'package:home_widget_4/core/heleprs/print_helper.dart';

void showSnackbar(String title, String message, bool isError) {
  if (navigatorKey.currentState != null) {
    final context = navigatorKey.currentState!.context;
    final snackBar = SnackBar(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isError ? Icons.error_outline : Icons.check_circle_outline, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      backgroundColor: isError ? Colors.red.withOpacity(0.8) : Colors.green.withOpacity(0.8),
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } else {
    pr('Navigator state is not available.', 'showSnackBar helper');
  }
}
