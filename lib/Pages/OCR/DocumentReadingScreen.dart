import 'dart:io';

import 'package:AI_EYE_GUIDE/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class DocumentReadingScreen extends StatefulWidget {
  const DocumentReadingScreen(
      {super.key, required this.selectedFile, required this.extractedText});
  final XFile selectedFile;
  final String extractedText;

  @override
  State<DocumentReadingScreen> createState() => _DocumentReadingScreenState();
}

class _DocumentReadingScreenState extends State<DocumentReadingScreen> {
  FlutterTts flutterTts = FlutterTts();
  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    speak(widget.extractedText);
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
          'Document Reading',
          style: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: _buildUI(),
    );
  }

  _buildUI() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Image.file(
              File(widget.selectedFile.path),
              height: 200,
            ),
          ),
          Text(
            widget.extractedText,
            style: TextStyle(
                color: textColor, fontSize: 10, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Future<String?> extractedText(File file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;

    textRecognizer.close();
    speak(text);
    return text;
  }

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  // FutureBuilder(
  //                 future: extractedText(File(selectedFile1!.path)),
  //                 builder: (context, snapshot) {
  //                   return Text(snapshot.data ?? "");
  //                 },
  //               )
}
