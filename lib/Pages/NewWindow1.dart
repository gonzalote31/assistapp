import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

