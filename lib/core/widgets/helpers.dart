import 'package:flutter/material.dart';

mixin Helpers {
  void showSnackBar({
    required BuildContext context,
    required String message,
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              error ? Icons.error : Icons.check_circle, // Icon changes based on error
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: error ? Colors.redAccent : Colors.greenAccent[700], // Stylish colors
        behavior: SnackBarBehavior.floating, // Floating style
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        margin: EdgeInsets.all(15), // Padding around the SnackBar
        elevation: 6, // Adds shadow for a cool effect
        duration: const Duration(seconds: 2), // Auto-dismiss time
        action: SnackBarAction(
          label: "DISMISS",
          textColor: Colors.white,
          onPressed: () {}, // Optional action
        ),
      ),
    );
  }
}