import 'package:flutter/material.dart';

import '../../widgets/trackingCard.dart';


class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {

  late String codeSended;
  final code=TextEditingController();

  @override
  void initState() {
    super.initState();
    codeSended = '';
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
      child: Column(
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
          Text("Tracking"),
          TrackingCard(searchQuery: codeSended),
        ],
      ),
    );
  }
}