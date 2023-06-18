import 'dart:convert';
import 'package:example_souf_route/models/Shipment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListShipmentView extends StatefulWidget {
  const ListShipmentView({Key? key}) : super(key: key);

  @override
  State<ListShipmentView> createState() => _ListShipmentViewState();
}

class _ListShipmentViewState extends State<ListShipmentView> {
  String url = "http://20.150.216.134:7070/api/v1/shipments";
  List<Shipment> shipments = [];

  Future<void> fetchShipments() async {
    final response = await http
        .get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        shipments = data
            .map((json) => Shipment(
                id: json['id'],
                description: json['description'],
                quantity: json['quantity'],
                freight: json['freight'],
                weight: json['weight'],
                date: json['date'],
                destinyId: json['destinyId'],
                consigneesId: json['consigneesId'],
                senderId: json['senderId'],
                typeOfPackageId: json['typeOfPackageId'],
                documentId: json['documentId']))
            .toList();
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    this.fetchShipments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: shipments == null ? 0 : shipments?.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Color(0xFFF0E5FF),
              margin: EdgeInsets.all(5),
              elevation: 10,
              child: ListTile(
                    leading: Text((index+1).toString()),
                    title: Text(shipments[index].description),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget> [
                        Text('Fecha: '+ shipments[index].date),
                        Text('Flete: '+ shipments[index].freight.toString() ),
                        Text('Peso: '+ shipments[index].weight.toString()),
                        Text('Cantidad:'+ shipments[index].quantity.toString()),
                      ],
                    ),
                    trailing: Icon(Icons.edit ),
                onTap: (){

                },
                  ),
              );
          }),
    );
  }
}
