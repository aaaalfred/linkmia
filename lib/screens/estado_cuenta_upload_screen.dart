import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EstadoCuentaUploadScreen extends StatefulWidget {
  @override
  _EstadoCuentaUploadScreenState createState() => _EstadoCuentaUploadScreenState();
}

class _EstadoCuentaUploadScreenState extends State<EstadoCuentaUploadScreen> {
  File? _image;
  final picker = ImagePicker();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Estado de Cuenta', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/guide_image_3.png',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Selecciona la forma de subir tu estado de cuenta',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            _buildOptionButton(
              icon: Icons.camera_alt,
              text: 'Tomar foto',
              onTap: () => getImage(ImageSource.camera),
            ),
            _buildOptionButton(
              icon: Icons.file_upload,
              text: 'Elegir documento',
              onTap: () => getImage(ImageSource.gallery),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                child: Text('Enviar'),
                onPressed: _image != null ? () {
                  // Aquí iría la lógica para enviar el documento
                  print('Enviando estado de cuenta');
                } : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900],
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({required IconData icon, required String text, required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        elevation: 2,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: Colors.deepPurple),
                SizedBox(width: 16),
                Text(text, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}