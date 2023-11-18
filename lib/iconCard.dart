// iconCard.dart
import 'package:flutter/material.dart';
import 'overlayScreen.dart'; // Import the necessary widgets

class IconCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget camera;

  const IconCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.camera,
  }) : super(key: key);

  void _showOverlay(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => camera,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 1000,
            height: 280,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 0.0,
              ),
            ),
            child: Semantics(
              value: text,
              label: text,
              child: ElevatedButton.icon(
                onPressed: () => _showOverlay(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 80,
                    ),
                  ],
                ),
                label: Text(
                  text,
                  style: const TextStyle(fontSize: 14.6),
                ),
              ),
            ),
          ),
          Container(
            width: 180,
            height: 4,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}