// home_screen.dart
import 'package:flutter/material.dart';
import 'iconCard.dart';
import 'overlayScreen.dart'; // Import the necessary widgets

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppBar(
                title: const Text('AI EYE GUIDE'),
                backgroundColor: Colors.red,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu),
                  ),
                ],
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
              const Row(
                children: [
                  Expanded(
                    child: IconCard(
                      icon: Icons.credit_card,
                      text: "Document Reading ", camera: CameraControl(),
                    ),
                  ),
                  Expanded(
                    child: IconCard(
                      text: "Object Detection",
                      icon: Icons.data_object,
                      camera: CameraControl(), // Provide the camera widget
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  Expanded(
                    child: IconCard(
                      text: "Currency Detection",
                      icon: Icons.currency_exchange_outlined,
                      camera: CameraControl(), // Provide the camera widget
                    ),
                  ),
                  Expanded(
                    child: IconCard(
                      text: "FeedBack",
                      icon: Icons.feedback,
                      camera: CameraControl(), // Provide the camera widget
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}