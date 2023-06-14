import 'dart:convert';
import 'package:example_souf_route/models/Destination.dart';
import 'package:example_souf_route/widgets/destinationCard.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../pages/administratorPage.dart';
import '../../pages/clientPage.dart';
import '../../widgets/trackingCard.dart';
import 'package:http/http.dart' as http;




class AdminHomeView extends StatefulWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {

  String? previosSearchQuery;
  late String codeSended;
  final code=TextEditingController();

  List<Destination> destinationList = [];
  @override
  void initState() {
    super.initState();
    codeSended = '';
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
  }

  void updateSearchQuery(String query) {
    setState(() {
      codeSended = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                TextField(
                  controller: code,
                  style: const TextStyle(color:Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffC8A1FF),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none
                    ),
                    hintText: "Enter tracking number",
                    hintStyle: const TextStyle(
                        color:Colors.white
                    ),
                    prefixIcon: IconButton(
                      icon:Icon(Icons.search),
                      color:Colors.white,
                      onPressed: (){
                        codeSended=code.text;
                        updateSearchQuery(code.text);
                        print("Boton presionado!");
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tracking',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                TrackingCard(searchQuery: codeSended),
              ],
            ),
            SizedBox(height: 40),
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
