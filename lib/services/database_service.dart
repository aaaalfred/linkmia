import 'package:mysql1/mysql1.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: '72.167.45.26',
      port: 3306,
      user: 'alfred',
      password: 'aaabcde1409',
      db: 'agencia_app',
    );

    return await MySqlConnection.connect(settings);
  }

  Future<bool> verificarCURP(String curp) async {
    final conn = await getConnection();
    try {
      var results = await conn.query(
        'SELECT * FROM usuarios_demo WHERE curp = ?',
        [curp],
      );
      await conn.close();
      return results.isNotEmpty;
    } catch (e) {
      print('Error al verificar CURP: $e');
      await conn.close();
      return false;
    }
  }

  Future<bool> insertarUsuario(String nombre, String app, String apm, String curp, String rfc) async {
    final conn = await getConnection();
    try {
      var result = await conn.query(
        'INSERT INTO usuarios_demo (nombre, app, apm, curp, rfc) VALUES (?, ?, ?, ?, ?)',
        [nombre, app, apm, curp, rfc],
      );
      await conn.close();
      return result.affectedRows! > 0;
    } catch (e) {
      print('Error al insertar usuario: $e');
      await conn.close();
      return false;
    }
  }
}