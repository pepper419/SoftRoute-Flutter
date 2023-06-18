import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../widgets/appBar.dart';

class SendersView extends StatefulWidget {
  const SendersView({super.key});

  @override
  State<SendersView> createState() => _SendersViewState();
}

class _SendersViewState extends State<SendersView> {

  late Future<List<dynamic>> sendersFuture;

  void initState() {
    super.initState();
    sendersFuture = fetchSenders();
  }

  String URL = 'http://20.150.216.134:7070/api/v1/sender';

  Future<List<dynamic>> fetchSenders() async {
    final response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      return decodedResponse;
    } else {
      throw Exception('Failed to load senders');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(username: "Senders"),
        body: FutureBuilder<List<dynamic>>(
          future: sendersFuture,
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
              List<dynamic> senders = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: senders.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(senders[index]['name'],
                          style: TextStyle(
                              color: Color(0xffA262FF),
                              fontSize: 15, fontWeight: FontWeight.bold)),
                      subtitle: Text(senders[index]['email']),
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
