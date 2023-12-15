import 'package:flutter/material.dart';
import 'iconCard.dart';
import 'overlayScreen.dart';
import 'feedback.dart';
// Import the necessary widgets

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
         debugShowCheckedModeBanner: false   ,
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                title: const Text('AI EYE GUIDE'),
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
                      text: "Document Reading Change",
                      camera: CameraControl(), onPressed: () {  },
                    ),
                  ),
                  Expanded(
                    child: IconCard(
                      text: "Object Detection",
                      icon: Icons.data_object,
                      camera: CameraControl(), onPressed: () {  }, // Provide the camera widget
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
                      camera: CameraControl(), onPressed: () {  }, // Provide the camera widget
                    ),
                  ),
                  Expanded(
                    child: IconCard(
                      text: "Feedback",
                      icon: Icons.feedback,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                        );
                      },
                      camera: Container(), // Provide a dummy widget since Feedback doesn't need a camera
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
