import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/appBar.dart';

class ConsigneesView extends StatefulWidget {
  const ConsigneesView({Key? key}) : super(key: key);

  @override
  State<ConsigneesView> createState() => _ConsigneesViewState();
}

class _ConsigneesViewState extends State<ConsigneesView> {

  late Future<List<dynamic>> consigneesFuture;

  @override
  void initState() {
    super.initState();
    consigneesFuture = fetchConsignees();
  }

  String URL = 'http://20.150.216.134:7070/api/v1/consignees';

  Future<List<dynamic>> fetchConsignees() async {
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      return decodedResponse;
    } else {
      throw Exception('Failed to load consignees');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(username: "Consignees"),
        body: FutureBuilder<List<dynamic>>(
          future: consigneesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              List<dynamic> consignees = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: consignees.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(consignees[index]['name'],
                            style: TextStyle(
                                color: Color(0xffA262FF),
                                fontSize: 15, fontWeight: FontWeight.bold)),
                        subtitle: Text(consignees[index]['address']),
                        trailing: Icon(Icons.arrow_forward_ios),
                        tileColor: Color(0xfF0E5FF),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                  );
                },
              );
            } else {
              return Center(
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
    );
  }
}
