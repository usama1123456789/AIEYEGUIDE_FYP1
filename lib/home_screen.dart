import 'package:flutter/material.dart';
import 'iconCard.dart';
import 'overlayScreen.dart';
import 'feedback.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}):super(key: key);
  var kColorScheme =ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(useMaterial3:true,
          colorScheme: kColorScheme,


      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                title: const Text('AI EYE GUIDE',style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.red,
              ),
              Container(
                height: 1,
                color: const Color.fromARGB(255, 255, 66, 77),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Select type to proceed",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: IconCard(
                      icon: Icons.credit_card,
                      text: "Document Reading ",
                      camera: const CameraControl(),
                      onPressed: () {},
                    ),
                  ),
                  Expanded(
                    child: IconCard(
                      text: "Object Detection ",
                      icon: Icons.data_object,
                      camera: const CameraControl(),
                      onPressed: () {}, // Provide the camera widget
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: IconCard(
                      text: "Currency Detection",
                      icon: Icons.currency_exchange_outlined,
                      camera: const CameraControl(),
                      onPressed: () {}, // Provide the camera widget
                    ),
                  ),
                  Expanded(
                    child: IconCard(
                      text: "Feedback",
                      icon: Icons.feedback,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const FeedbackOverlayScreen()),
                        );
                      },
                      camera:
                          Container(), // Provide a dummy widget since Feedback doesn't need a camera
                    ),
                  ), // Added missing closing parenthesis
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
