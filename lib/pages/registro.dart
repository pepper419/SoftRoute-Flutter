import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'administratorPage.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Usuario {
  @HiveField(0)
  final String nombre;
  @HiveField(1)
  final String correo;
  @HiveField(2)
  final String contrasena;
  @HiveField(3)
  final String telefono;
  @HiveField(4)
  final String dni;
  @HiveField(5)
  final String domicilio;

  Usuario({
    required this.nombre,
    required this.correo,
    required this.contrasena,
    required this.telefono,
    required this.dni,
    required this.domicilio,
  });
}

class UsuarioAdapter extends TypeAdapter<Usuario> {
  static int _nextTypeId = 1; // Variable estática para el contador de typeId

  @override
  final int typeId; // No se establece un valor inicial aquí

  UsuarioAdapter() : typeId = _nextTypeId++ {
    // Incrementar el contador para el próximo typeId
  }

  @override
  Usuario read(BinaryReader reader) {
    return Usuario(
      nombre: reader.readString(),
      correo: reader.readString(),
      contrasena: reader.readString(),
      telefono: reader.readString(),
      dni: reader.readString(),
      domicilio: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Usuario obj) {
    writer.writeString(obj.nombre);
    writer.writeString(obj.correo);
    writer.writeString(obj.contrasena);
    writer.writeString(obj.telefono);
    writer.writeString(obj.dni);
    writer.writeString(obj.domicilio);
  }
}

class RegistroScreen extends StatefulWidget {
  static const routeName = '/registro';

  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _dniController = TextEditingController();
  final _domicilioController = TextEditingController();

  Future<void> _guardarUsuario(BuildContext context) async {
    final nombre = _nombreController.text;
    final correo = _correoController.text;
    final contrasena = _contrasenaController.text;
    final telefono = _telefonoController.text;
    final dni = _dniController.text;
    final domicilio = _domicilioController.text;

    Hive.registerAdapter<Usuario>(UsuarioAdapter());

    try {
      final box = await Hive.openBox<Usuario>('usuarios');
      final usuario = Usuario(
        nombre: nombre,
        correo: correo,
        contrasena: contrasena,
        telefono: telefono,
        dni: dni,
        domicilio: domicilio,
      );
      await box.add(usuario);
      await box.close();
    } catch (e) {
      print('Error al abrir o cerrar la caja de Hive: $e');

      return;
    }

    Navigator.pushNamed(
      context,
      AdminPage.routeName,
      arguments: {
        'username': nombre, // Pasar solo el nombre de usuario
      },
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _correoController.dispose();
    _contrasenaController.dispose();
    _telefonoController.dispose();
    _dniController.dispose();
    _domicilioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wallpaper_home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'images/boxlogo.png',
                    height: 150,
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Registro',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                          ),
                          controller: _nombreController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su nombre';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Correo',
                          ),
                          controller: _correoController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su correo';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                          ),
                          controller: _contrasenaController,
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su contraseña';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Teléfono',
                          ),
                          controller: _telefonoController,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su número de teléfono';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'DNI',
                          ),
                          controller: _dniController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su DNI';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Domicilio',
                          ),
                          controller: _domicilioController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese su domicilio';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _guardarUsuario(context);
                            }
                          },
                          child: Text('Registrarse'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}