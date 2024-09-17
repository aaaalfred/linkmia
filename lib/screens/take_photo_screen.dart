// Path: lib/screens/take_photo_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import '../services/google_vision_service.dart';
import '../services/app_state.dart';
import './general_info_screen.dart';

class TakePhotoScreen extends StatefulWidget {
  const TakePhotoScreen({Key? key}) : super(key: key);

  @override
  _TakePhotoScreenState createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Limpiar datos extraídos anteriormente si es necesario
    AppState.clearExtractedData();
  }

  Future<void> _takePhoto() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        File _image = File(photo.path);
        Uint8List imageBytes = await _image.readAsBytes();
        Map<String, String> extractedData = await GoogleVisionService.extractDataFromImage(imageBytes);

        if (extractedData.containsKey("Error")) {
          setState(() {
            _errorMessage = extractedData["Error"];
            _isLoading = false;
          });
        } else {
          // Guardar los datos extraídos en AppState si es necesario
          await AppState.saveExtractedData(extractedData);

          // Navegar a GeneralInfoScreen con los datos extraídos
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => GeneralInfoScreen(extractedData: extractedData),
            ),
          );
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = "No se seleccionó ninguna imagen";
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Error al procesar la imagen: $e";
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red[300], fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}