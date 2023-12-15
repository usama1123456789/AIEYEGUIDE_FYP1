import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Provide your feedback here!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            VoiceRecordingButton(),
          ],
        ),
      ),
    );
  }
}

class VoiceRecordingButton extends StatelessWidget {
  const VoiceRecordingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {

      },
      tooltip: 'Start Recording',
      child: const Icon(Icons.mic, size: 36),
    );
  }
}
