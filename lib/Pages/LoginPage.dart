import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  static bool authenticated = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.blue],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform(
                  transform: Matrix4.rotationZ(0),
                  child: Text('ASSISTAPP',
                    style: TextStyle(
                      color: Color.fromRGBO(37, 151, 206, 1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'Scriptorama Markdown JF',),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: LogoandSpinner(
                      imageAssets: 'assets/logo.PNG',
                      reverse: true,
                      arcColor: Color.fromRGBO(38, 156, 210, 1.0),
                      spinSpeed: Duration(milliseconds: 5000),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Usuario',
                    hintStyle: TextStyle(color: Color.fromRGBO(38, 156, 210, 0.4)),
                    prefixIcon: Icon(Icons.person, color: Color.fromRGBO(38, 156, 210, 1.0)),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(38, 156, 210, 1.0), width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    hintStyle: TextStyle(color: Color.fromRGBO(38, 156, 210, 0.4)),
                    prefixIcon: Icon(Icons.lock, color: Color.fromRGBO(38, 156, 210, 1.0)),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(38, 156, 210, 1.0), width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Color.fromRGBO(38, 156, 210, 1.0),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 1),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    '¿Olvidó su contraseña?',
                    style: TextStyle(color: Color.fromRGBO(25, 50, 218, 1.0),fontWeight: FontWeight.bold,),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String username = _usernameController.text;
                    String password = _passwordController.text;

                    if (username == 'jeferson' && password == '123') {
                      setState(() {
                        authenticated = true;
                      });

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen(username:username)),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Credenciales Inválidas',
                              style: TextStyle(
                                color: Color.fromRGBO(28, 50, 128, 1.0),
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                            content: Text('Por favor, verifique su nombre de usuario y/o contraseña.',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            actions: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(28, 50, 128, 1.0), // Color de fondo del botón
                                  borderRadius: BorderRadius.circular(10), // Bordes redondeados
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5), // Color de la sombra
                                      spreadRadius: 2, // Extensión de la sombra
                                      blurRadius: 5, // Difuminado de la sombra
                                      offset: Offset(0, 3), // Desplazamiento de la sombra
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Aceptar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],

                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(fontSize: 18, color: Color.fromRGBO(38, 156, 210, 1.0)),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                SizedBox(height: 100),
                Text(
                  '¿No estás registrado?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold , color: Color.fromRGBO(
                      0, 55, 255, 1.0)),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    bool result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );

                    if (result == true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Usuario registrado'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Registrar',
                      style: TextStyle(fontSize: 14, color: Color.fromRGBO(38, 156, 210, 1.0)),
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
