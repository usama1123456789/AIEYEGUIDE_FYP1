import 'package:flutter/material.dart';

class FeedbackOverlayScreen extends StatelessWidget {
  const FeedbackOverlayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Provide your feedback here!',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          // Add your feedback form widgets here
          // For example, you can use TextFields, Buttons, etc.
          ElevatedButton(
            onPressed: () {
              // Add logic to handle feedback submission
              Navigator.pop(context); // Close the overlay after submitting
            },
            child: const Text('Submit Feedback'),
          ),
        ],
      ),
    );
  }
}
