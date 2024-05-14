import 'package:AI_EYE_GUIDE/Constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RecordFeeBackScreen extends StatefulWidget {
  const RecordFeeBackScreen({Key? key}) : super(key: key);

  @override
  State<RecordFeeBackScreen> createState() => _RecordFeeBackScreenState();
}

class _RecordFeeBackScreenState extends State<RecordFeeBackScreen> {
  final SpeechToText _speechToText = SpeechToText();
  FlutterTts flutterTts = FlutterTts();
  bool giveFeedBack = true;
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
  void dispose() {
    flutterTts.stop();
    super.dispose();
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
          giveFeedBack ? 'Give your feedback' : 'All feedbacks',
          style: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      giveFeedBack = !giveFeedBack;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: giveFeedBack ? color30 : color60),
                    child: Text(
                      'Record Feedback',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      giveFeedBack = !giveFeedBack;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: !giveFeedBack ? color30 : color60),
                    child: Text(
                      'All Feedbacks',
                      style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            giveFeedBack
                ? Expanded(
                    child: giveFeedBacTrueWidget(),
                  )
                : giveFeedBackFalseWidget()
          ],
        ),
      ),
    );
  }

  Widget giveFeedBacTrueWidget() {
    return Column(
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
                color: textColor, fontSize: 13, fontWeight: FontWeight.w500),
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
                      onPressed: () {
                        if (wordsSpoken.trim().isNotEmpty) {
                          addFeedbackToFirebase(wordsSpoken);
                        } else {
                          debugPrint('Please Record your feedback first');
                          speak('Please Record your feedback first');
                        }
                      },
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
    );
  }

  Widget giveFeedBackFalseWidget() {
    return Expanded(
        child: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('feedbacks').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<QueryDocumentSnapshot> feedbackDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: feedbackDocs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> feedbackData = {
                'feedbackText': feedbackDocs[index]['feedbackText'],
                'recordedAt': feedbackDocs[index]['recordedAt'],
              };
              return ListTile(
                leading: IconButton(
                    onPressed: () {
                      speak(feedbackDocs[index]['feedbackText']);
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      color: textColor,
                    )),
                subtitle: Text(feedbackData['recordedAt'].toString()),
              );
            },
          );
        }
      },
    ));
  }

  void addFeedbackToFirebase(String feedbackText) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      Timestamp timestamp = Timestamp.now();
      await firestore.collection('feedbacks').add({
        'feedbackText': feedbackText,
        'recordedAt': timestamp,
      });

      debugPrint('Feedback added to Firestore');
      speak('Your feedback has been recorded.');
      setState(() {
        wordsSpoken = '';
      });
    } catch (e) {
      debugPrint('Error adding feedback to Firestore: $e');
    }
  }

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  Future<List<Map<String, dynamic>>> fetchFeedbackData() async {
    List<Map<String, dynamic>> feedbackDataList = [];

    try {
      // Get a reference to the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch all documents from the 'feedbacks' collection
      QuerySnapshot querySnapshot =
          await firestore.collection('feedbacks').get();

      // Loop through the documents and extract data
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> feedbackData = {
          'feedbackText': doc['feedbackText'],
          'recordedAt': doc['recordedAt'],
        };
        feedbackDataList.add(feedbackData);
      });

      return feedbackDataList;
    } catch (e) {
      print('Error fetching feedback data: $e');
      return [];
    }
  }
}
