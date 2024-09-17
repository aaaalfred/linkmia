import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class DocumentUploadScreen extends StatefulWidget {
  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  File? _selectedFile;
  bool _isFileValid = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      int fileSizeInBytes = await file.length();
      double fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB <= 5) {
        setState(() {
          _selectedFile = file;
          _isFileValid = true;
        });
      } else {
        _showErrorDialog('El archivo es demasiado grande. El tamaño máximo permitido es de 5 MB.');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadFile() async {
    if (_selectedFile != null && _isFileValid) {
      // Aquí iría la lógica para subir el archivo al servidor
      print('Subiendo archivo: ${_selectedFile!.path}');
      // Simulación de subida exitosa
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Archivo subido exitosamente')),
      );
    } else {
      _showErrorDialog('Por favor, seleccione un archivo válido antes de subirlo.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subir Documento',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _pickFile,
            child: Text('Seleccionar Archivo'),
          ),
          SizedBox(height: 20),
          if (_selectedFile != null)
            Text('Archivo seleccionado: ${_selectedFile!.path.split('/').last}'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _uploadFile,
            child: Text('Subir Archivo'),
          ),
        ],
      ),
    );
  }
}