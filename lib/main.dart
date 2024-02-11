import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logo_n_spinner/logo_n_spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASSISTAPP',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          dialogTheme: DialogTheme(

          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color.fromRGBO(38, 152, 207, 1.0),
            selectionColor: Color.fromRGBO(38, 152, 207, 1.0),
            selectionHandleColor: Color.fromRGBO(38, 152, 207, 1.0),

          )
      ),

      home: LoginPage(),
    );
  }
}

//*************************************************************
//LOGIN
//*************************************************************
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

/////////////////////////////////////////////////////////////////
// RESTABLECER CONTRASEÑA
/////////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////////
// REGISTRO DE USUARIO
////////////////////////////////////////////////////////////////////
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  final TextEditingController _repetirContrasenaController = TextEditingController();
  bool _isContrasenaVisible = false;
  bool _isRepetirContrasenaVisible = false;

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
                  onPressed: () {
                    print('Registrar');
                    Navigator.pop(context, true);
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

//////////////////////////////////////////////////////////////////////
// PANTALLA DE INICIO
/////////////////////////////////////////////////////////////////////

class HomeScreen extends StatelessWidget {
  final String username; // Variable para almacenar el nombre de usuario

  HomeScreen({required this.username}); // Constructor que recibe el nombre de usuario

  @override
  Widget build(BuildContext context) {
    // Obtener la inicial del nombre de usuario
    String initial = username.isNotEmpty ? username[0].toUpperCase() : '';

    return WillPopScope(
      onWillPop: () async {
        // Evitar el retroceso a la página de inicio de sesión
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(''), // Eliminamos el mensaje de bienvenida del AppBar
          automaticallyImplyLeading: false, // Quitar el botón de regresar
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
                // Mostrar menú emergente de notificaciones
              },
            ),
          ),
          actions: [
            if (_LoginPageState.authenticated)
              Builder(
                builder: (context) => Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications_active),
                      onPressed: () {
                        showNotificationsMenu(context);
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
        drawer: Sidebar(username: username), // Agregar el sidebar (debes definir tu propio Sidebar widget)
        body: Stack(
          children: [
            // Fondo difuminado con colores sólidos
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(100, 176, 243, 1.0).withOpacity(0.7), // Color del fondo superior
                    Color.fromRGBO(255, 255, 255, 1.0).withOpacity(0.9), // Color del fondo inferior
                  ],
                ),
              ),
            ),
            // Cuadro de otro color detrás del mensaje y CircleAvatar
            Container(
              //padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Color.fromRGBO(32, 145, 236, 1.0),
                    width: 150,
                    height: 100,
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Alineación a la izquierda
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Color.fromRGBO(252, 5, 5, 1.0), // Color del círculo
                          child: Text(
                            initial,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.white, // Color del texto
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Espacio entre el CircleAvatar y el Text
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.waving_hand_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                SizedBox(width: 5), // Espacio entre el icono y el texto
                                Text(
                                  'HOLA, "${username.toUpperCase()}"',
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true, // Permitir retorno de línea suave
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                  SizedBox(height: 20),
                  Expanded(
                    child: SearchableCardList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
//////////////////////////////////////////////////////////////////////
// BOTON DE NOTIFICACIONES
//////////////////////////////////////////////////////////////////////

  // Método para mostrar el menú emergente de notificaciones
  void showNotificationsMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notificaciones',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: Color.fromRGBO(28, 50, 128, 1.0)
            ),
          ),
          content: Text('Aquí puedes ver tus notificaciones.'),
          actions: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromRGBO(28, 50, 128, 1.0), // Color de fondo del contenedor
                borderRadius: BorderRadius.circular(14.0), // Borde del contenedor
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Color de la sombra
                    spreadRadius: 2, // Radio de expansión de la sombra
                    blurRadius: 8, // Radio de difuminado de la sombra
                    offset: Offset(0, 3), // Desplazamiento de la sombra
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cerrar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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

//////////////////////////////////////////////////////////////////////
// BARRA LATERAL
/////////////////////////////////////////////////////////////////////

class Sidebar extends StatelessWidget {
  final String username; // Variable para almacenar el nombre de usuario
  final Uri _url = Uri.parse('https://www.espoch.edu.ec/es/');

  Sidebar({required this.username}); // Constructor que recibe el nombre de usuario

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.fromLTRB(6, 10, 10, 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(32, 148, 239, 1.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromRGBO(252, 5, 5, 1.0),
                        child: Text(
                          username.isNotEmpty ? username[0].toUpperCase() : '',
                          style: TextStyle(
                            fontSize: 50,
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${username[0].toUpperCase()}${username.substring(1)}',
                          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0), fontSize: 30),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Profesor',
                          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0), fontSize: 15),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'jeferson.rivadeneria@espoch.edu.ec',
                          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0), fontSize: 10),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          // Agregar un espacio entre el DrawerHeader y el ListTile
          ListTile(
            leading: Icon(Icons.school,color: Color.fromRGBO(
                32, 145, 236, 1.0)),
            title: Text('Escuela Superior Politécnica de Chimborazo'),
            onTap: () => _launchUrl(_url),
          ),
          ListTile(
            leading: Icon(Icons.account_balance_sharp,color: Color.fromRGBO(
                32, 145, 236, 1.0)),
            title: Text('Facultad de Informática y Electrónica'),
            onTap: () => _launchUrl(Uri.parse('https://www.espoch.edu.ec/es/fie/')), // URL para la Facultad de Informática y Electrónica
          ),
          ListTile(
            leading: Icon(Icons.other_houses_rounded,color: Color.fromRGBO(
                32, 145, 236, 1.0)),
            title: Text('Escuela de Telecomunicaciones'),
            onTap: () => _launchUrl(Uri.parse('https://www.espoch.edu.ec/es/fie-t/')), // URL para la Escuela de Telecomunicaciones
          ),

          ListTile(
            leading: Icon(Icons.account_circle_rounded,color: Color.fromRGBO(
                32, 145, 236, 1.0)),
            title: Text('Oasis/Yankay ESPOCH'),
            onTap: () => _launchUrl(Uri.parse('https://yankay.espoch.edu.ec')), // URL para la Escuela de Telecomunicaciones
          ),
          ListTile(
            leading: Icon(Icons.laptop_rounded,color: Color.fromRGBO(
                32, 145, 236, 1.0)),
            title: Text('Elearning ESPOCH'),
            onTap: () => _launchUrl(Uri.parse('https://elearning.espoch.edu.ec')), // URL para la Escuela de Telecomunicaciones
          ),
          ListTile(
            leading: Icon(
                Icons.exit_to_app,color: Color.fromRGBO(
                32, 145, 236, 1.0)),
            title: Text('Cerrar Sesión',
            ),
            onTap: () {
              // Mostrar cuadro de diálogo para confirmar el log out
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Cerrar Sesión',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Color.fromRGBO(28, 50, 128, 1.0)
                      ),
                    ),
                    content: Text('¿Está seguro de que desea cerrar sesión?',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Color.fromRGBO(28, 50, 128, 1.0)
                          ),),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(28, 50, 128, 1.0), // Color de fondo del contenedor
                          borderRadius: BorderRadius.circular(15.0), // Borde del contenedor
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), // Color de la sombra
                              spreadRadius: 2, // Radio de expansión de la sombra
                              blurRadius: 5, // Radio de difuminado de la sombra
                              offset: Offset(0, 3), // Desplazamiento de la sombra
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Cerrar sesión y volver a la página de inicio de sesión
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                                  (route) => false,
                            );
                          },
                          child: Text(
                            'Aceptar',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                            ),
                          ),
                        ),
                      ),

                    ],
                  );
                },
              );
            },
          ),
          SizedBox(height: 16), // Espacio debajo de "Escuela de Telecomunicaciones"
          Expanded(child: SizedBox()), // Espacio expandible azul
          Container(
            color: Color.fromRGBO(32, 145, 236, 1.0),
            width: 350,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Assistapp © 2024. Derechos reservados.',
                    style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1.0)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////
// REDIRIJIR A LINKS
////////////////////////////////////////////////////////////////////////////////
Future<void> _launchUrl(Uri url) async {
  if (!await launch(url.toString())) {
    throw Exception("Could not launch $url");
  }
  await launch(url.toString());
}

// **********************************************************************
// **********************************************************************

// //////////////////////////////////////////////////////////////////////////
// CONFIGURACION DE CARDS
// /////////////////////////////////////////////////////////////////////////

class SelectableCard extends StatelessWidget {
  final VoidCallback onPressed;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final String text;
  final String aula;
  final double cardWidth;
  final double cardHeight;

  SelectableCard({
    required this.onPressed,
    required this.onDelete,
    required this.onEdit,
    required this.text,
    required this.aula,
    this.cardWidth = 150.0,
    this.cardHeight = 185.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: cardWidth,
          height: cardHeight,
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        text.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 33,
                          color: Color.fromRGBO(28, 50, 128, 1.0),
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Color.fromRGBO(255, 255, 255, 1.0),
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'FIE-$aula',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: onEdit,
                    color: Color.fromRGBO(28, 50, 128, 1.0),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: onDelete,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// //////////////////////////////////////////////////////////////////////////
// BUSCADOR DE CARDS
// /////////////////////////////////////////////////////////////////////////

class SearchableCardList extends StatefulWidget {
  @override
  _SearchableCardListState createState() => _SearchableCardListState();
}
class _SearchableCardListState extends State<SearchableCardList> {
  TextEditingController _searchController = TextEditingController();
  TextEditingController _aulaController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();

  List<Map<String, dynamic>> cardList = [];
  List<Map<String, dynamic>> filteredList = [];
  Color newCardColor = Color.fromRGBO(29, 207, 238, 0.6078431372549019);
  double newCardHeight = 150.0;

  @override
  void initState() {
    super.initState();
    filteredList = List.from(cardList);

    _searchFocusNode.addListener(() {
      setState(() {
        if (_searchController.text.isEmpty && !_searchFocusNode.hasFocus) {
          _searchFocusNode.canRequestFocus = true;
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _aulaController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        _searchFocusNode.canRequestFocus = false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                onChanged: (value) {
                  setState(() {
                    filteredList = cardList
                        .where((option) =>
                    option['nombre'].toLowerCase().startsWith(value.toLowerCase()) ||
                        option['aula'].toLowerCase().startsWith(value.toLowerCase()))
                        .toList();
                  });
                },
                onTap: () {
                  setState(() {
                    _searchFocusNode.canRequestFocus = true;
                  });
                },
                decoration: InputDecoration(
                  hintText: _searchFocusNode.canRequestFocus
                      ? 'Buscar Asignatura/Aula'
                      : '',
                  hintStyle: TextStyle(
                    // color:Color.fromRGBO(152, 172, 176, 0.9176470588235294),
                    color: _searchFocusNode.hasFocus ? Color.fromRGBO(
                        100, 176, 243, 1.0) : Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  prefixIcon: Icon(Icons.search,
                    size: 20,
                    color: _searchFocusNode.hasFocus ? Color.fromRGBO(
                        100, 176, 243, 1.0) : Colors.grey, // Cambia el color del icono cuando el campo está seleccionado
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear,
                      size: 20,
                      color: _searchFocusNode.hasFocus ? Color.fromRGBO(
                          100, 176, 243, 1.0) : Colors.grey,),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        filteredList = List.from(cardList);
                      });
                    },
                  )
                      : null,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(5, 47, 252, 1.0),
                        width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: filteredList.length,
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return SelectableCard(
                    onPressed: () {
                      _onCardTap(filteredList[index]);
                    },
                    onDelete: () {
                      _onDeleteCard(filteredList[index]);
                    },
                    onEdit: () {
                      _onEditCard(filteredList[index]);
                    },
                    text: filteredList[index]['nombre'],
                    aula: filteredList[index]['aula'],
                  );
                },
              ),
            ),
            SizedBox(height: 16),

// ///////////////////////////////////////////////////
// boton agregar
// ///////////////////////////////////////////////////
            FloatingActionButton(
              onPressed: () {
                _showNameDialog(context);
              },
              child: Icon(
                Icons.add,
                color: Color.fromRGBO(255, 255, 255, 1.0),
              ),
              backgroundColor: Color.fromRGBO(31, 142, 234, 1.0), // Cambia el color del botón aquí
              elevation: 4.0,
            ),

            ////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }


//////////////////////////////////////////////////////
//   REDERIGIR A LA VENTANA DE FECHA Y LISTADO
//////////////////////////////////////////////////////

  void _onCardTap(Map<String, dynamic> option) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewWindow1(option: option),
      ),
    );
  }

// ///////////////////////////////////////////////////////
//   ELIMINAR CARD
//   //////////////////////////////////////////////////
  void _onDeleteCard(Map<String, dynamic> option) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ELIMINAR',
            style: TextStyle(
              color: Color.fromRGBO(28, 50, 128, 1.0),
              fontWeight: FontWeight.w700,
              fontSize: 28,
            ),
          ),
          content:
          Text('¿Estás seguro de que deseas eliminar esta asignatura?',
            style: TextStyle(
                fontSize: 18
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  cardList.remove(option);
                  filteredList = List.from(cardList);
                });
                Navigator.pop(context);
              },
              child: Text('Aceptar',
                style: TextStyle(
                    color: Color.fromRGBO(28, 50, 128, 1.0),
                    fontSize: 16
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(28, 50, 128, 1.0), // Color de fondo
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Color de la sombra
                    spreadRadius: 2, // Extensión de la sombra
                    blurRadius: 4, // Desenfoque de la sombra
                    offset: Offset(0, 2), // Desplazamiento de la sombra
                  ),
                ],
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

///////////////////////////////////////////////////////
//   EDITAR LAS TARJETAS
//   /////////////////////////////////////////////////////
  void _onEditCard(Map<String, dynamic> option) {
    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text('EDITAR',
            style: TextStyle(
              color:Color.fromRGBO(28, 50, 128, 1.0),
              fontWeight: FontWeight.w600,
              fontSize: 28,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: option['nombre']),
                onChanged: (value) {
                  option['nombre'] = value;
                },
                decoration: InputDecoration(
                  hintText: 'Editar asignatura',
                  focusedBorder: UnderlineInputBorder(
                    borderSide:BorderSide(
                        width: 2,
                        color: Color.fromRGBO(28, 50, 128, 1)
                    ),
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[áéíóúÁÉÍÓÚüÜa-zA-Z\s]'))],
              ),
              TextField(
                controller: TextEditingController(text: option['aula']),
                onChanged: (value) {
                  option['aula'] = value;
                },
                decoration: InputDecoration(
                  hintText: 'Editar Aula',
                  focusedBorder: UnderlineInputBorder(
                    borderSide:BorderSide(
                        width: 2,
                        color: Color.fromRGBO(28, 50, 128, 1)
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar',
                style: TextStyle(
                  color: Color.fromRGBO(28, 50, 128, 1.0),
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(28, 50, 128, 1.0), // Color de fondo
                borderRadius: BorderRadius.circular(8), // Bordes redondeados
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Color y opacidad de la sombra
                    spreadRadius: 2, // Extensión de la sombra
                    blurRadius: 4, // Desenfoque de la sombra
                    offset: Offset(0, 2), // Desplazamiento de la sombra
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text(
                  'Aceptar',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1.0),
                    fontSize: 17,
                  ),
                ),
              ),
            ),

          ],
        );
      },
    );
  }

///////////////////////////////////////////////////////
// VENTANA PARA INGRESAR ASIGNATURA/AULA
// //////////////////////////////////////////////////////

  void _showNameDialog(BuildContext context) {
    _aulaController.clear();
    _searchController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Materia/Aula',
            style: TextStyle(
              color: Color.fromRGBO(28, 50, 128, 1.0), // Color azul marino
              fontSize: 25, // Tamaño de letra modificado
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Nombre de la Asignatura',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color:  Color.fromRGBO(
                            28, 50, 128, 1.0)), // Color del borde inferior cuando el campo de texto está enfocado
                  ),
                ),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[áéíóúÁÉÍÓÚüÜa-zA-Z\s]'))],
              ),
              TextField(
                controller: _aulaController,
                decoration: InputDecoration(
                  hintText: 'Número de Aula',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: Color.fromRGBO(
                            28, 50, 128, 1.0)), // Color del borde inferior cuando el campo de texto está enfocado
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar',
                style: TextStyle(
                  color: Color.fromRGBO(28, 50, 128, 1.0),
                  fontSize: 16, // Tamaño de letra modificado
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  String newName = _searchController.text;
                  String newAula = _aulaController.text;

                  if (newName.isNotEmpty) {
                    cardList.add({'nombre': newName, 'aula': newAula});
                    filteredList = List.from(cardList);
                  }
                  Navigator.pop(context);
                });
              },
              style: TextButton.styleFrom(
                backgroundColor: Color.fromRGBO(28, 50, 128, 1.0), // Color de fondo del botón
                shadowColor: Colors.black, // Color de la sombra
                elevation: 5, // Elevación para agregar sombra
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Bordes redondeados
                ),
              ),
              child: Text(
                'Aceptar',
                style: TextStyle(
                  fontSize: 16, // Tamaño de letra modificado
                  fontWeight: FontWeight.w600, // Texto en negrita
                  color: Colors.white, // Color blanco
                ),
              ),
            ),

          ],
        );
      },
    ).then((value) {
      _searchController.clear();
      _aulaController.clear();
    });
  }
}


// //////////////////////////////////////////////////////////////////////////
// VENTANA DE CALENDARIO Y LISTA
// /////////////////////////////////////////////////////////////////////////

class NewWindow1 extends StatefulWidget {
  final Map<String, dynamic> option;

  const NewWindow1({Key? key, required this.option}) : super(key: key);

  @override
  _NewWindow1State createState() => _NewWindow1State();
}

class _NewWindow1State extends State<NewWindow1> {
  DateTime? _selectedDate = DateTime.now(); // Inicializamos con la fecha actual

  // Lista de estudiantes (puedes cambiarla según necesites)
  List<String> students = [
    'Estudiante 1',
    'Estudiante 2',
    'Estudiante 3',
    'Estudiante 4',
    'Estudiante 5',
    'Estudiante 1',
    'Estudiante 2',
    'Estudiante 3',
    'Estudiante 4',
    'Estudiante 5',
    'Estudiante 4',
    'Estudiante 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LISTADO ESTUDIANTES'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue.shade400,
                  Colors.white,
                ],
                stops: [0.3, 1.0],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 0), // Espacio en la parte superior
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Image.asset(
                      'assets/unidos.PNG',
                      width: 500,
                      height: 300,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 18,
                      child: Container(
                        width: 260.5,
                        height: 159.25,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 500,
                              height: 50,
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'INFORMACIÓN',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 12), // Espacio entre los textos
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Tooltip(
                                        message: 'Asignatura.: ${widget.option['nombre']}',
                                        child: Text(
                                          'Asignatura: ${widget.option['nombre']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Color.fromRGBO(28, 50, 128, 1.0),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8), // Espacio entre los textos
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Aula: FIE-${widget.option['aula']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromRGBO(28, 50, 128, 1.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(245, 242, 248, 1.0),
                          textStyle: TextStyle(
                            color: Color.fromRGBO(28, 50, 128, 1.0),
                            fontSize: 16,
                          ),
                        ),
                        child: Text('Seleccionar Fecha',
                          style: TextStyle(
                            color: Color.fromRGBO(28, 50, 128, 1.0),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0), // Ajusta el valor según sea necesario
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('N° ESTUDIANTES: ',
                                style: TextStyle(
                                  color: Color.fromRGBO(1, 1, 1, 1),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 17,
                                ),
                              ), // Ajusta según tu lógica
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'FECHA: ',
                                      style: TextStyle(
                                        color: Color.fromRGBO(1, 1, 1, 1), // Color de la palabra "FECHA"
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${_selectedDate!.toString().split(' ')[0]}',
                                      style: TextStyle(
                                        color: Color.fromRGBO(
                                            255, 255, 255, 1.0), // Color de la fecha
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3), // Cambia la posición de la sombra
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: 300, // Altura máxima para el contenedor de la tabla
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              'Código',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Nombre Estudiante',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                        rows: List<DataRow>.generate(
                          students.length,
                              (index) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  '${index + 1}', // Código del estudiante
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  students[index], // Nombre del estudiante
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            left:100,
            right: 100,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7), // Color de la sombra
                        spreadRadius: 0, // Radio de propagación
                        blurRadius: 15, // Radio de desenfoque
                        offset: Offset(2, 10), // Desplazamiento de la sombra
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Lógica para descargar el PDF
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Color de fondo del botón
                      onPrimary: Color.fromRGBO(28, 50, 128, 1.0), // Color del texto del botón
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Espaciado interno del botón
                    ),
                    child: Text(
                      'Descargar PDF',
                      style: TextStyle(
                        color: Color.fromRGBO(28, 50, 128, 1.0), // Color del texto del botón
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          // Positioned(
          //   left: 10,
          //   right: 110,
          //   bottom: 340,
          //   child: Row(
          //     children: [
          //       Container(
          //         decoration: BoxDecoration(
          //           color: Colors.white, // Color de fondo del botón
          //           borderRadius: BorderRadius.circular(30), // Bordes redondeados del botón
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.grey.withOpacity(0.7), // Color de la sombra
          //               spreadRadius: 0, // Radio de propagación
          //               blurRadius: 15, // Radio de desenfoque
          //               offset: Offset(2, 10), // Desplazamiento de la sombra
          //             ),
          //           ],
          //         ),
          //         child: IconButton(
          //           onPressed: () {
          //             _searchStudents();
          //             _requestSearchFocus();
          //           },
          //           icon: Icon(
          //             Icons.search,
          //             color: Color.fromRGBO(28, 50, 128, 1.0), // Color del icono
          //             size: 30, // Tamaño del icono
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      // Eliminamos la selectableDayPredicate
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Color del botón seleccionar fecha
              onPrimary: Colors.white, // Color del texto del botón seleccionar fecha
            ),
            dialogBackgroundColor: Colors.white, // Color del fondo del selector de fecha
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

}


