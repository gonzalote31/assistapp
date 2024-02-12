import 'package:assistapp/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Sidebar extends StatelessWidget {

  final String username; // Variable para almacenar el nombre de usuario
  final Uri _url = Uri.parse('https://www.espoch.edu.ec/es/');

  // Constructor que recibe el nombre de usuario
  Sidebar(
    {super.key, required this.username}
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.fromLTRB(6, 10, 10, 10),
            decoration: const BoxDecoration(
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
                        backgroundColor: const Color.fromRGBO(252, 5, 5, 1.0),
                        child: Text(
                          username.isNotEmpty ? username[0].toUpperCase() : '',
                          style: const TextStyle(
                            fontSize: 50,
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nombres
                        Text(
                          // TODO: Hacer que cuando se desborde poner los 3 puntos
                          '${username.split('.')[0].capitalize()} ${username.split('.')[1].capitalize()}',
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            fontSize: 28
                          ),
                          textAlign: TextAlign.left,
                        ),
                        // Profesión
                        const Text(
                          // TODO: Analizar que tipo de usuarios van a ingresar
                          'Profesor',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            fontSize: 15
                          ),
                          textAlign: TextAlign.left,
                        ),
                        // Correo
                        Text(
                          FirebaseAuth.instance.currentUser?.email ?? '',
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1.0),
                            fontSize: 10
                          ),
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
          const SizedBox(height: 10),
          // Agregar un espacio entre el DrawerHeader y el ListTile
          ListTile(
            leading: const Icon(
              Icons.school,
              color: Color.fromRGBO(32, 145, 236, 1.0)
            ),
            title: const Text('Escuela Superior Politécnica de Chimborazo'),
            onTap: () => _launchUrl(_url),
          ),
          ListTile(
            title: const Text('Facultad de Informática y Electrónica'),
            leading: const Icon(
              Icons.account_balance_sharp,
              color: Color.fromRGBO(32, 145, 236, 1.0)
            ),
            onTap: () => _launchUrl(Uri.parse('https://www.espoch.edu.ec/es/fie/')), // URL para la Facultad de Informática y Electrónica
          ),
          ListTile(
            leading: const Icon(
              Icons.other_houses_rounded,
              color: Color.fromRGBO(32, 145, 236, 1.0)
            ),
            title: const Text('Escuela de Telecomunicaciones'),
            onTap: () => _launchUrl(Uri.parse('https://www.espoch.edu.ec/es/fie-t/')), // URL para la Escuela de Telecomunicaciones
          ),

          ListTile(
            leading: const Icon(
              Icons.account_circle_rounded,
              color: Color.fromRGBO(32, 145, 236, 1.0)
            ),
            title: const Text('Oasis/Yankay ESPOCH'),
            onTap: () => _launchUrl(Uri.parse('https://yankay.espoch.edu.ec')), // URL para la Escuela de Telecomunicaciones
          ),
          ListTile(
            leading: const Icon(
              Icons.laptop_rounded,
              color: Color.fromRGBO(32, 145, 236, 1.0)
            ),
            title: const Text('Elearning ESPOCH'),
            onTap: () => _launchUrl(Uri.parse('https://elearning.espoch.edu.ec')), // URL para la Escuela de Telecomunicaciones
          ),
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              color: Color.fromRGBO(32, 145, 236, 1.0)
            ),
            title: const Text('Cerrar Sesión',),
            onTap: () {
              // Mostrar cuadro de diálogo para confirmar el log out
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: Color.fromRGBO(28, 50, 128, 1.0)
                      ),
                    ),
                    content: const Text(
                      '¿Está seguro de que desea cerrar sesión?',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await FirebaseAuth.instance
                            .signOut()
                            .then((value) => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage()
                                )
                              )
                            }
                          );
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Color.fromRGBO(28, 50, 128, 1.0)
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(28, 50, 128,
                              1.0), // Color de fondo del contenedor
                          borderRadius: BorderRadius.circular(
                              15.0), // Borde del contenedor
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.2), // Color de la sombra
                              spreadRadius:
                                  2, // Radio de expansión de la sombra
                              blurRadius: 5, // Radio de difuminado de la sombra
                              offset: const Offset(
                                  0, 3), // Desplazamiento de la sombra
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Cerrar sesión y volver a la página de inicio de sesión
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false,
                            );
                          },
                          child: const Text(
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
          const SizedBox(height: 16), // Espacio debajo de "Escuela de Telecomunicaciones"
          const Expanded(child: SizedBox()), // Espacio expandible azul
          Container(
            color: const Color.fromRGBO(32, 145, 236, 1.0),
            width: 350,
            height: 50,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Assistapp© 2024. Derechos Reservados.',
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

Future<void> _launchUrl(Uri url) async {
  if (!await launch(url.toString())) {
    throw Exception("Could not launch $url");
  }
  await launch(url.toString());
}

extension StringExtensions on String { 
  String capitalize() { 
    return "${this[0].toUpperCase()}${this.substring(1)}"; 
  } 
}
