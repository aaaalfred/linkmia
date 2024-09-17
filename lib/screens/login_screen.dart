import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../services/app_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _curpController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();

  Future<void> _verificarCURP() async {
    String curp = _curpController.text.trim();
    if (curp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingresa tu CURP')),
      );
      return;
    }

    bool curpValido = await _databaseService.verificarCURP(curp);
// En login_screen.dart, dentro del método _verificarCURP
    if (curpValido) {
      await AppState.setLoggedIn(true);
      Navigator.of(context).pushReplacementNamed('/profile');
    } else {
      await AppState.setLoggedIn(false);
      Navigator.of(context).pushReplacementNamed('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.blue],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LINKMI',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Hola 👋 si ya estás registrado, ingresa tu CURP',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _curpController,
                          decoration: InputDecoration(
                            hintText: 'CURP',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          child: Text('Comenzar'),
                          onPressed: _verificarCURP,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[900],
                            minimumSize: Size(double.infinity, 50),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('ó'),
                        SizedBox(height: 20),
                        InkWell(
                          child: Text(
                            'Si es la primera vez que te registras Ingresa aquí',
                            style: TextStyle(color: Colors.blue),
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed('/welcome');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}