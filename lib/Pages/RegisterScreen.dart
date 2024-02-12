import 'package:assistapp/AuthServices/firebase_authentication.dart';
import 'package:assistapp/Pages/HomeScreen.dart';
import 'package:assistapp/Pages/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  // final TextEditingController _repetirContrasenaController = TextEditingController();
  bool _isContrasenaVisible = false;
  // bool _isRepetirContrasenaVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Registrar Usuario',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 8),
            Icon(Icons.person_add, color: Color.fromRGBO(255, 255, 255, 1.0)),
          ],
        ),
        backgroundColor: Color.fromRGBO(38, 156, 210, 1.0),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 150),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromRGBO(38, 156, 210, 1.0), Colors.white],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  onChanged: (value) {
                    // Hacer que la etiqueta desaparezca cuando se escribe en el cuadro de texto
                  },
                  decoration: InputDecoration(
                    hintText: 'Nombre',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(5, 47, 252, 1.0).withOpacity(0.4),
                    ),
                    prefixIcon: Icon(Icons.person, size: 22, color: Color.fromRGBO(28, 50, 128, 1.0)),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(5, 47, 252, 1.0), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: _nombreController,
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(fontSize: 18),
                  onChanged: (value) {
                    // Hacer que la etiqueta desaparezca cuando se escribe en el cuadro de texto
                  },
                  decoration: InputDecoration(
                    hintText: 'Apellido',
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(5, 47, 252, 1.0).withOpacity(0.4),
                    ),
                    prefixIcon: Icon(Icons.person_outline, size: 22, color: Color.fromRGBO(28, 50, 128, 1.0)),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromRGBO(5, 47, 252, 1.0), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: _nombreController,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 18),
                        onChanged: (value) {
                          // Hacer que la etiqueta desaparezca cuando se escribe en el cuadro de texto
                        },
                        decoration: InputDecoration(
                          hintText: 'Usuario',
                          hintStyle: TextStyle(color: Color.fromRGBO(
                              5, 47, 252, 1.0).withOpacity(0.4)),
                          prefixIcon: Icon(Icons.email, size: 22, color: Color.fromRGBO(28, 50, 128, 1.0)),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(
                                5, 47, 252, 1.0), width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        controller: _correoController,
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 150,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(225, 225, 225, 1.0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '@espoch.edu.ec',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(101, 99, 99, 1.0),
                            fontWeight: FontWeight.bold,
                            shadows: [
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(fontSize: 18),
                  onChanged: (value) {
                    // Hacer que la etiqueta desaparezca cuando se escribe en el cuadro de texto
                  },
                  obscureText: !_isContrasenaVisible,
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    hintStyle: TextStyle(color: Color.fromRGBO(5, 47, 252, 1.0).withOpacity(0.4)),
                    prefixIcon: Icon(Icons.lock, size: 22, color: Color.fromRGBO(28, 50, 128, 1.0)),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isContrasenaVisible
                            ? Icons.visibility : Icons.visibility_off,
                        color: Color.fromRGBO(28, 50, 128, 1.0),
                      ),
                      onPressed: () {
                        setState(() {
                          _isContrasenaVisible = !_isContrasenaVisible;
                        });
                      },
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(
                          5, 47, 252, 1.0), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: _contrasenaController,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    print('Registrar');
                    String username = _correoController.text;
                    String password = _contrasenaController.text;

                    String email = '$username@espoch.edu.ec';
                    print(email);

                    dynamic result = await FirebaseAuthentication().registerWithEmailAndPassword(email, password);

                    if (result != null) {
                      print(result);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    } else {
                      print("Error al registrar el usuario");
                    }
                    // Navigator.pop(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(28, 50, 128, 1.0),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromRGBO(255, 255, 255, 1.0)),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tiene una cuenta?',
                      style: TextStyle(color: Color.fromRGBO(28, 50, 128, 1.0), fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navegar a la pantalla de inicio de sesión
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                blurRadius: 2.0,
                                color: Color.fromRGBO(255, 255, 255, 1.0),
                                offset: Offset(1.0, 1.0),
                              )
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
