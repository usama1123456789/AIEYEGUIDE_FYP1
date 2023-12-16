import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraControl extends StatefulWidget {
  const CameraControl({Key? key}) : super(key: key);

  @override
  _CameraControlState createState() => _CameraControlState();
}

class _CameraControlState extends State<CameraControl> {
  late CameraController _cameraController;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();

    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    try {
      await _cameraController.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Widget _buildCameraPreview() {
    if (!_isCameraInitialized) {
      return const CircularProgressIndicator();
    }

    return Expanded(
      child: AspectRatio(
        aspectRatio: _cameraController.value.aspectRatio,
        child: CameraPreview(_cameraController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _isCameraInitialized
                ? _buildCameraPreview()
                : const CircularProgressIndicator(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
