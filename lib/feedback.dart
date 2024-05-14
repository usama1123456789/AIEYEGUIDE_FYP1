import 'package:flutter/material.dart';


class FeedbackOverlayScreen extends StatefulWidget {
  const FeedbackOverlayScreen({Key? key}) : super(key: key);

  @override
  _FeedbackOverlayScreenState createState() => _FeedbackOverlayScreenState();
}

class _FeedbackOverlayScreenState extends State<FeedbackOverlayScreen> {
  late Microphone _microphone;

  @override
  void initState() {
    super.initState();
    _microphone = Microphone();
  }

  @override
  void dispose() {
    _microphone.closeAudioStream();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      await _microphone.openAudioStream();
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _microphone.closeAudioStream();
      // Here you can handle the recorded audio data as needed
    } catch (e) {
      print('error stopping Recording: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'provide your feedback here!',
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 50),
          ElevatedButton.icon(
            onPressed: _startRecording,
            style: ElevatedButton.styleFrom(
              elevation: 30,
              backgroundColor: Colors.white,
              minimumSize: const Size(300, 300),
              foregroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            icon: const Icon(Icons.mic, size: 200),
            label: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Feedback',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _stopRecording,
            child: const Text('Stop Recording'),
          ),
        ],
      ),
    );
  }
}
