import 'dart:convert';
import 'package:example_souf_route/models/Destination.dart';
import 'package:example_souf_route/widgets/destinationCard.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:http/http.dart' as http;


class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  late String codeSended='17';

  List<Destination> destinationList = [];
  @override
  void initState() {
    super.initState();
    fetchDestination();
  }

  Future<void> fetchDestination() async{
    String base_url='http://20.150.216.134:7070/api/v1/destinations';
    final url=Uri.parse(base_url);
    var response =await http.get(url);
    if(response.statusCode==200){
      final jsonData = jsonDecode(response.body); //decodificacion del cuerpo
      List<Destination> destinations = [];
      for (var item in jsonData) {
        Destination destination = Destination(
            name: item['name']
        );
        destinations.add(destination);
      }
      setState(() {
        destinationList = destinations;
      });
    }else {
      print('Request failed with status: ${response.statusCode}');
    }
    print ('HOLAAAAAAAAA JULIAN TE AMO');
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientPage()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC8A1FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Search Tracking',
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ],

            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tracking',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TrackingCard(searchQuery: '17'),

            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Destinations',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            if (destinationList.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: destinationList.length,
                itemBuilder: (BuildContext context, int index) {
                  return DestinationCard(
                    name: destinationList[index].name,
                  );
                },
              ),
            if (destinationList.isEmpty)
              CircularProgressIndicator(),

          ],
        ),
      ),
    );
  }
}
