import 'package:flutter/material.dart';

// Import the FeedbackOverlayScreen
import 'feedback.dart';


class IconCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget camera;

  final VoidCallback onPressed;

  const IconCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.camera,
    required this.onPressed,
  }) : super(key: key);

  // Update the _showOverlay method to accept a bool parameter
  void _showOverlay(BuildContext context, bool isFeedback) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        if (isFeedback) {
          return const FeedbackOverlayScreen();
        } else {
          return camera;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 1000,
            height: 280,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 0.0,
              ),
            ),
            child: Semantics(
              value: text,
              label: text,
              child: ElevatedButton.icon(
                onPressed: () => _showOverlay(context, text == "Feedback"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 5,
                  foregroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 80,
                    ),
                  ],
                ),
                label: Text(
                  text,
                  style: const TextStyle(fontSize: 13.9),
                ),
              ),
            ),
          ),
          Container(
            width: 180,
            height: 4,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}
