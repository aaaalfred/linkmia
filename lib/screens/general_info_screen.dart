import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../services/app_state.dart';
import '../screens/document_selection_screen.dart';

class GeneralInfoScreen extends StatefulWidget {
  final Map<String, String> extractedData;

  const GeneralInfoScreen({Key? key, this.extractedData = const {}}) : super(key: key);

  @override
  _GeneralInfoScreenState createState() => _GeneralInfoScreenState();
}

class _GeneralInfoScreenState extends State<GeneralInfoScreen> {
  final DatabaseService _databaseService = DatabaseService();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _appController = TextEditingController();
  final TextEditingController _apmController = TextEditingController();
  final TextEditingController _curpController = TextEditingController();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _coloniaController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppState.saveLastRoute('/general_info');
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await AppState.getUserData();
    if (userData != null) {
      setState(() {
        _nombreController.text = userData['Nombre'] ?? '';
        _appController.text = userData['Apellido Paterno'] ?? '';
        _apmController.text = userData['Apellido Materno'] ?? '';
        _curpController.text = userData['CURP'] ?? '';
        _calleController.text = userData['Calle'] ?? '';
        _coloniaController.text = userData['Colonia'] ?? '';
        _cpController.text = userData['Codigo Postal'] ?? '';
        _fechaNacimientoController.text = userData['Fecha de Nacimiento'] ?? '';
        _sexoController.text = userData['Sexo'] ?? '';
      });
    } else {
      _fillFormWithExtractedData();
    }
  }

  void _fillFormWithExtractedData() {
    _nombreController.text = widget.extractedData['Nombre'] ?? '';
    _appController.text = widget.extractedData['Apellido Paterno'] ?? '';
    _apmController.text = widget.extractedData['Apellido Materno'] ?? '';
    _curpController.text = widget.extractedData['CURP'] ?? '';
    _calleController.text = widget.extractedData['Calle'] ?? '';
    _coloniaController.text = widget.extractedData['Colonia'] ?? '';
    _cpController.text = widget.extractedData['Codigo Postal'] ?? '';
    _fechaNacimientoController.text = widget.extractedData['Fecha de Nacimiento'] ?? '';
    _sexoController.text = widget.extractedData['Sexo'] ?? '';
  }

  Future<void> _guardarDatos() async {
    String nombre = _nombreController.text.trim();
    String app = _appController.text.trim();
    String apm = _apmController.text.trim();
    String curp = _curpController.text.trim();

    if (nombre.isEmpty || app.isEmpty || apm.isEmpty || curp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    bool insertado = await _databaseService.insertarUsuario(nombre, app, apm, curp, '');
    if (insertado) {
      final userData = {
        'Nombre': _nombreController.text,
        'Apellido Paterno': _appController.text,
        'Apellido Materno': _apmController.text,
        'CURP': _curpController.text,
        'Calle': _calleController.text,
        'Colonia': _coloniaController.text,
        'Codigo Postal': _cpController.text,
        'Fecha de Nacimiento': _fechaNacimientoController.text,
        'Sexo': _sexoController.text,
      };
      await AppState.saveUserData(userData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Datos guardados exitosamente')),
      );

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DocumentSelectionScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar los datos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/guide_image_3.png",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    'Documentos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
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
                    'Ingresa tu información general',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 20),
                  _buildTextField('Nombre', 'Ingresa tu nombre', _nombreController),
                  _buildTextField('Apellido Paterno', 'Ingresa tu Apellido Paterno', _appController),
                  _buildTextField('Apellido Materno', 'Ingresa tu Apellido Materno', _apmController),
                  _buildTextField('CURP', 'Ingresa tu CURP', _curpController),
                  _buildTextField('Calle', 'Ingresa tu calle', _calleController),
                  _buildTextField('Colonia', 'Ingresa tu colonia', _coloniaController),
                  _buildTextField('CP', 'Ingresa tu código postal', _cpController),
                  _buildTextField('Fecha de nacimiento', 'Ingresa tu fecha de nacimiento', _fechaNacimientoController),
                  _buildTextField('Sexo', 'Ingresa tu género', _sexoController),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('Guardar'),
                    onPressed: _guardarDatos,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _appController.dispose();
    _apmController.dispose();
    _curpController.dispose();
    _calleController.dispose();
    _coloniaController.dispose();
    _cpController.dispose();
    _fechaNacimientoController.dispose();
    _sexoController.dispose();
    super.dispose();
  }
}