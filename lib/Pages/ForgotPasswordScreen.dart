import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Desenfocar el teclado al tocar fuera del campo de texto
        FocusScope.of(context).unfocus();

      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Restablecer Contraseña',style: TextStyle(color: Color.fromRGBO(
              11, 21, 63, 1.0),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Bebas Neue'),),

        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.blueAccent],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ingrese su correo electrónico:',
                  style: TextStyle(fontSize: 18, color: Color.fromRGBO(
                      11, 24, 159, 1.0),fontWeight: FontWeight.bold,),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'example@espoch.edu.ec',
                    hintStyle: TextStyle(color: Colors.blue.withOpacity(0.4)),
                    prefixIcon: Icon(Icons.email, color: Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la lógica para enviar un correo de restablecimiento de contraseña
                    // Puedes usar _emailController.text para obtener la dirección de correo electrónico
                    _sendPasswordResetEmail(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Cambia el color del fondo del botón
                    // onPrimary: Colors.white, // Cambia el color del texto del botón
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Ajusta el radio del borde del botón
                      // side: BorderSide(color: Colors.blue, width: 2), // Añade un borde azul al botón
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Enviar',
                      style: TextStyle(fontSize: 18, color: Color.fromRGBO(
                          38, 156, 210, 1.0)), // Cambia el tamaño y el color del texto del botón
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

  void _sendPasswordResetEmail(BuildContext context) {
    // Aquí deberías implementar la lógica para enviar el correo de restablecimiento
    // Puedes usar _emailController.text para obtener la dirección de correo electrónico

    // Muestra un cuadro de diálogo para indicar que el correo se ha enviado exitosamente
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Correo Enviado',
            style: TextStyle(
              color: Color.fromRGBO(28, 50, 128, 1.0),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text('Se ha enviado el correo exitosamente. Revise su bandeja de entrada.',
            style: TextStyle
              (fontSize:15,
            ),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Color de la sombra
                    spreadRadius: 0, // Radio de expansión de la sombra
                    blurRadius: 8, // Radio de difuminado de la sombra
                    offset: Offset(0.5, 4), // Desplazamiento de la sombra
                  ),
                ],
                borderRadius: BorderRadius.circular(8.0), // Borde del contenedor
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromRGBO(28, 50, 128, 1.0),
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Cerrar el cuadro de diálogo
                  Navigator.pop(context); // Volver a la pantalla de inicio de sesión
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
