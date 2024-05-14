import 'package:AI_EYE_GUIDE/Constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextScreen extends StatefulWidget {
  const SpeechToTextScreen({super.key});

  @override
  State<SpeechToTextScreen> createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String wordsSpoken = '';
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  startListening() async {
    await _speechToText.listen(onResult: onResult);
    setState(() {});
  }

  stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  onResult(SpeechRecognitionResult result) async {
    setState(() {
      wordsSpoken = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color60,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: color60,
        title: Text(
          'Speech To Text',
          style: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _speechToText.isListening
                ? Center(
                    child: Text(
                      'Listening your voice',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Tap mic icon to record your voice',
                        style: TextStyle(
                            color: textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                wordsSpoken,
                style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _speechToText.isListening
                      ? IconButton(
                          onPressed: () {
                            stopListening();
                          },
                          icon: const Icon(Icons.stop, size: 50),
                          color: textColor,
                        )
                      : IconButton(
                          onPressed: () {
                            startListening();
                          },
                          icon: Icon(
                            Icons.mic,
                            size: 50,
                            color: textColor,
                          ),
                        ),
                  _speechToText.isListening
                      ? IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.stop,
                            size: 50,
                            color: color60,
                          ))
                      : IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.send,
                            size: 40,
                            color: textColor,
                          ),
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
