import 'package:flutter/material.dart';
import './csf_upload_screen.dart';
import './nss_upload_screen.dart';
import './curp_upload_screen.dart';
import './estado_cuenta_upload_screen.dart';
import './comprobante_estudios_upload_screen.dart';
import './carta_recomendacion_upload_screen.dart';

class DocumentSelectionScreen extends StatelessWidget {
  const DocumentSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Documentos', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              "assets/guide_image_3.png",
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Selecciona el tipo de documento a subir',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Introduction',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  _buildDocumentOption(context, 'Constancia de Situación Fiscal', CSFUploadScreen()),
                  _buildDocumentOption(context, 'NSS', NSSUploadScreen()),
                  _buildDocumentOption(context, 'CURP', CURPUploadScreen()),
                  _buildDocumentOption(context, 'Estado de cuenta', EstadoCuentaUploadScreen()),
                  _buildDocumentOption(context, 'Comprobante de estudios', ComprobanteEstudiosUploadScreen()),
                  _buildDocumentOption(context, 'Carta de recomendación', CartaRecomendacionUploadScreen()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentOption(BuildContext context, String title, Widget screen) {
    return Card(
      elevation: 0,
      color: Colors.grey[100],
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}