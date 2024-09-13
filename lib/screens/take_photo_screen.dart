// Path: lib/screens/take_photo_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import '../services/google_vision_service.dart';  // Asegúrate de crear este archivo

class TakePhotoScreen extends StatefulWidget {
  const TakePhotoScreen({Key? key}) : super(key: key);

  @override
  _TakePhotoScreenState createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  File? _image;
  Map<String, String>? _extractedData;
  bool _isLoading = false;

  Future<void> _takePhoto() async {
    setState(() {
      _isLoading = true;
    });

    final ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });

      // Extraer datos de la imagen
      Uint8List imageBytes = await _image!.readAsBytes();
      Map<String, String> extractedData = await GoogleVisionService.extractDataFromImage(imageBytes);

      setState(() {
        _extractedData = extractedData;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4A3AFF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                '¡Empecemos!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Es hora de tomar una foto de tu INE',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                child: Text('Tomar Foto'),
                onPressed: _isLoading ? null : _takePhoto,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xFF4A3AFF),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              if (_isLoading)
                CircularProgressIndicator(color: Colors.white),
              if (_extractedData != null)
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _extractedData!.entries.map((e) =>
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: Text('${e.key}: ${e.value}', style: TextStyle(color: Colors.white)),
                            )
                        ).toList(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}