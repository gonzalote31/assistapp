import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
