import 'package:flutter/material.dart';

class DestinationCard extends StatelessWidget {

  final String name;

  DestinationCard({
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientPage()));
              },
              child: Card(
                color: Color(0xFFF0E5FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 120,
                            height: 120, // Ajusta el tamaño según tus necesidades
                            // Agrega aquí la vista de Google Maps o cualquier otro widget que desees mostrar
                            // Puedes utilizar el widget `GoogleMap` de la biblioteca `google_maps_flutter` para mostrar el mapa
                            // Ejemplo: GoogleMap(...),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Card(
                                  color: Color(0xFFFFFFFF),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5, // Espaciado vertical
                                      horizontal: 10, // Espaciado horizontal
                                    ),
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        color: Color(0xFF6200EE),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Icon(Icons.arrow_forward),

                          Card(
                            color:Color(0xFFBA8EFC),
                            child: IconButton(
                              onPressed: (){
                                print("julian t amo");
                              },
                              icon: Icon(Icons.arrow_forward_ios_sharp),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
        )
      ],
    );
  }
}
