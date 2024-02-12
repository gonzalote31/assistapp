import 'package:assistapp/Pages/LoginPage.dart';
import 'package:assistapp/Pages/SearchableCardList.dart';
import 'package:assistapp/Pages/Sidebar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  final String username; // Variable para almacenar el nombre de usuario

  const HomeScreen({super.key, required this.username}); // Constructor que recibe el nombre de usuario

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
          title: const Text(''), // Eliminamos el mensaje de bienvenida del AppBar
          automaticallyImplyLeading: false, // Quitar el botón de regresar
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Mostrar menú emergente de notificaciones
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: [
            if (LoginPageState.authenticated)
              Builder(
                builder: (context) => Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_active),
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
                    const Color.fromRGBO(100, 176, 243, 1.0).withOpacity(0.7), // Color del fondo superior
                    const Color.fromRGBO(255, 255, 255, 1.0).withOpacity(0.9), // Color del fondo inferior
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
                    color: const Color.fromRGBO(32, 145, 236, 1.0),
                    width: 150,
                    height: 100,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Alineación a la izquierda
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: const Color.fromRGBO(252, 5, 5, 1.0), // Color del círculo
                          child: Text(
                            initial,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white, // Color del texto
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10), // Espacio entre el CircleAvatar y el Text
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.waving_hand_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const SizedBox(width: 5), // Espacio entre el icono y el texto
                                Text(
                                  ' Hola, ${username.split('.')[0].capitalize()}',
                                  style: const TextStyle(
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
                  const SizedBox(height: 20),
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
          title: const Text('Notificaciones',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: Color.fromRGBO(28, 50, 128, 1.0)
            ),
          ),
          content: const Text('Aquí puedes ver tus notificaciones.'),
          actions: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(28, 50, 128, 1.0), // Color de fondo del contenedor
                borderRadius: BorderRadius.circular(14.0), // Borde del contenedor
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Color de la sombra
                    spreadRadius: 2, // Radio de expansión de la sombra
                    blurRadius: 8, // Radio de difuminado de la sombra
                    offset: const Offset(0, 3), // Desplazamiento de la sombra
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
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
