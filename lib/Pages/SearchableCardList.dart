import 'package:assistapp/Pages/NewWindow1.dart';
import 'package:assistapp/Pages/SelectableCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

