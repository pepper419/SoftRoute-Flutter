import 'package:example_souf_route/pages/registro.dart';
import 'package:flutter/material.dart';

import 'Login.dart';

class LoginandRegisterView extends StatelessWidget {
  const LoginandRegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wallpaper_home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'images/boxlogo.png',
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(),
                              ),
                            );
                          },
                          child: Text('Iniciar sesión'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistroScreen(),
                              ),
                            );
                          },
                          child: Text('Registrarse'),
                        ),
                      ],
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