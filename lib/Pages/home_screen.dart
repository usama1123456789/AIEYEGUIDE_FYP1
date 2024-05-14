import 'dart:io';

import 'package:AI_EYE_GUIDE/Constants/constants.dart';

import 'package:AI_EYE_GUIDE/Pages/FeedBack/record_feedback.dart';
import 'package:AI_EYE_GUIDE/Pages/FeedBack/speech_sample.dart';
import 'package:AI_EYE_GUIDE/Pages/OCR/DocumentReadingScreen.dart';
import 'package:AI_EYE_GUIDE/Pages/DetectionScreens/object_detection_screen.dart'
    as obj;

import 'package:AI_EYE_GUIDE/Pages/DetectionScreens/currency_detection_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    List<Map<String, dynamic>> sliderContainerData = [
      {
        'heading': 'Currency Detection',
        'icon': Icons.attach_money,
        'onTap': () {
          navigationFunctions.nextScreen(
            context,
            const CurrencyDetectionScreen(),
          );
        },
        "detail":
            "Our advanced AI algorithms swiftly recognize and provide details about the currency, including denomination and country of origin. Whether you're traveling abroad, handling foreign currencies, or simply curious about the value of banknotes, our Currency Detection functionality ensures seamless and accurate identification."
      },
      {
        'heading': 'Object Detection',
        'icon': Icons.emoji_objects,
        'onTap': () {
          navigationFunctions.nextScreen(
            context,
            const obj.YoloVideo(),
          );
        },
        "detail":
            "Our AI-driven technology adeptly discerns various objects, providing insights into their presence and context. Whether you're curious about the contents of a scenic photograph, need to identify items in a room, or wish to explore the intricacies of a complex scene."
      },
      {
        'heading': 'Document Reading',
        'icon': Icons.book_rounded,
        'onTap': () {
          pickImage();
        },
        "detail":
            "Our app provides a convenient feature that allows you to select any image from your gallery. Once you've selected an image, our powerful AI technology extracts text from it. This means you can easily extract text from images of documents, notes, or any other text-containing image. After the text is extracted, our app will read it out loud to you, making it easier for you to access the information without needing to read it yourself. Whether you want to listen to important documents, review notes, or simply enjoy the convenience of having text read aloud, our image text extraction feature has you covered!"
      },
      {
        'heading': 'FeedBack',
        'onTap': () {
          navigationFunctions.nextScreen(
            context,
            const RecordFeeBackScreen(),
          );
        },
        'icon': Icons.mic,
        "detail": "Tell us about you'r app experience by recording your voice."
      }
    ];
    return Scaffold(
      backgroundColor: color60,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: color60,
        title: Text(
          'AI EYE GUIDE',
          style: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 10, right: 10, bottom: 60),
              child: Text(
                'Kindly choose from the following options and let our AI base application help you.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            CarouselSlider.builder(
              itemCount: 4,
              itemBuilder: (context, index, realIndex) {
                return detailContainer(
                  screenHeight,
                  sliderContainerData[index]['heading'],
                  sliderContainerData[index]['icon'],
                  sliderContainerData[index]['detail'],
                  sliderContainerData[index]['onTap'],
                );
              },
              options: CarouselOptions(
                  height: screenHeight * 0.6,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    debugPrint(index.toString());
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget detailContainer(double screenHeight, String heading, IconData icon,
      String detail, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color30),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                heading,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Icon(
                icon,
                color: textColor,
                size: 100,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                detail,
                style: TextStyle(
                  color: textColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickImage() async {
    XFile? selectedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (selectedFile != null) {
      extractedText(File(selectedFile.path)).then(
        (value) => setState(
          () {
            debugPrint(value.toString());
            navigationFunctions.nextScreen(
              context,
              DocumentReadingScreen(
                selectedFile: selectedFile,
                extractedText: value.toString(),
              ),
            );
          },
        ),
      );
    }
  }

  Future<String?> extractedText(File file) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(file);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    String text = recognizedText.text;

    textRecognizer.close();

    return text;
  }
}
