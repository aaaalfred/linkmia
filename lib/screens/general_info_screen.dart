import 'package:flutter/material.dart';
import '../services/database_service.dart';

class GeneralInfoScreen extends StatefulWidget {
  const GeneralInfoScreen({Key? key}) : super(key: key);

  @override
  _GeneralInfoScreenState createState() => _GeneralInfoScreenState();
}

class _GeneralInfoScreenState extends State<GeneralInfoScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DatabaseService _databaseService = DatabaseService();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _appController = TextEditingController();
  final TextEditingController _apmController = TextEditingController();
  final TextEditingController _curpController = TextEditingController();
  final TextEditingController _rfcController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nombreController.dispose();
    _appController.dispose();
    _apmController.dispose();
    _curpController.dispose();
    _rfcController.dispose();
    super.dispose();
  }

  Future<void> _guardarDatos() async {
    String nombre = _nombreController.text.trim();
    String app = _appController.text.trim();
    String apm = _apmController.text.trim();
    String curp = _curpController.text.trim();
    String rfc = _rfcController.text.trim();

    if (nombre.isEmpty || app.isEmpty || apm.isEmpty || curp.isEmpty || rfc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    bool insertado = await _databaseService.insertarUsuario(nombre, app, apm, curp, rfc);
    if (insertado) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Datos guardados exitosamente')),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Generales'),
            Tab(text: 'Example 2'),
            Tab(text: 'Example 3'),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGeneralInfoForm(),
          Center(child: Text('Example 2 Content')),
          Center(child: Text('Example 3 Content')),
        ],
      ),
    );
  }

  Widget _buildGeneralInfoForm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Nombre', 'Ingresa tu nombre', _nombreController),
          _buildTextField('Apellido Materno', 'Ingresa tu Apellido Materno', _appController),
          _buildTextField('Apellido Paterno', 'Ingresa tu Apellido Paterno', _apmController),
          _buildTextField('CURP', 'Ingresa tu CURP', _curpController),
          _buildTextField('RFC', 'Ingresa tu RFC', _rfcController),
          _buildTextField('Edad', 'Ingresa tu edad'),
          _buildTextField('Género', 'Ingresa tu género'),
          _buildTextField('Fecha de nacimiento', 'Ingresa tu fecha de nacimiento'),
          _buildTextField('Calle', 'Ingresa tu calle'),
          _buildTextField('No.', 'Ingresa tu número'),
          _buildTextField('Colonia', 'Ingresa tu colonia'),
          _buildTextField('CP', 'Ingresa tu código postal'),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Guardar'),
            onPressed: _guardarDatos,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, [TextEditingController? controller]) {
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
}