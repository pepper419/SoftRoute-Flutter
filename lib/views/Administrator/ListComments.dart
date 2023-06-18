import 'dart:convert';
import 'package:example_souf_route/models/FeedbackModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListCommentsView extends StatefulWidget {
  const ListCommentsView({Key? key}) : super(key: key);

  @override
  State<ListCommentsView> createState() => _ListCommentsViewState();
}

class _ListCommentsViewState extends State<ListCommentsView> {
  String url = "http://20.150.216.134:7070/api/v1/feedback";
  List<FeedbackModel> comments = [];

  Future<void> fetchComments() async {
    final response = await http.get(Uri.parse('http://20.150.216.134:7070/api/v1/feedback'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        comments = data
            .map((json) => FeedbackModel(
          id: json['id'],
          date: json['date'],
          description: json['description'],
          typeOfComplaintId: json['typeOfComplaintId'],
            shipmentId: json['shipmentId'],
        ))
            .toList();
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    this.fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: comments == null ? 0 : comments.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            // Mostrar el card del filtro en el primer índice
            return Card(
              color: Colors.grey,
              child: ListTile(
                leading: Icon(Icons.filter_list),
                title: Text(
                  'Filtro',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  // Acción cuando se hace clic en el card de filtro
                  // Puedes agregar aquí la lógica para mostrar el menú desplegable de filtros
                },
              ),
            );
          } else {
            // Mostrar las tarjetas de comentarios
            final commentIndex = index - 1;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Color(0xFFFFFFFF),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      color: Colors.purpleAccent,
                      child: Text(
                        'Nombre del usuario',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(comments[commentIndex].description),
                      subtitle: Text(comments[commentIndex].date),
                      contentPadding: EdgeInsets.all(16.0),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          // Acción cuando se presiona el botón "responder"
                          // Puedes agregar aquí la lógica para responder al comentario
                        },
                        child: Text(
                          'Responder',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}