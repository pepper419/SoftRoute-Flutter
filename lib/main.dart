import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:example_souf_route/views/addShipment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:example_souf_route/Login.dart';
import 'views/adminHome.dart';
import 'widgets/destinationCard.dart';

import 'models/Destination.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Soft Route App",
      debugShowCheckedModeBanner: false,
      home:HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:AssetImage('images/wallpaper_home.png'),
            fit: BoxFit.cover
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset('images/boxlogo.png'),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 180, // <-- Your width
                  height: 50, // <-- Your height
                  child:
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminPage()));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },child: Text("ADMINISTRATORS"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF6200EE)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFF6200EE))
                            )
                        )
                    ),
                  )
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: 180, // <-- Your width
                  height: 50, // <-- Your height
                  child:
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientPage()));
                  },child: Text("CLIENT"),
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Color(0xFF6200EE)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFF6200EE))
                            )
                        )
                    ),
                  )
              ),
            ],
          ),
        ),
      )
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF6200EE),
      flexibleSpace: Container(
        height: 120, // Ajusta la altura deseada
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/boxlogo.png',
              width: 50,
              height: 50,
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://assets.mycast.io/actor_images/actor-chris-cornell-654145_large.jpg?1673761823'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Welcome James!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () {
            // Acción al presionar el ícono de configuración
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.0); // Ajusta la altura deseada
}


class ClientPage extends StatefulWidget {

  const ClientPage({Key? key}) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {


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
    return SafeArea(
      child: Scaffold(
          appBar: CustomAppBar(),
          body:Padding(
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
          )
      ),
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  final items=[
    Icon(Icons.home, color: Colors.white),
    Icon(Icons.book, color: Colors.white),
    Icon(Icons.car_crash, color: Colors.white),
    Icon(Icons.comment, color: Colors.white),
    Icon(Icons.person, color: Colors.white),
  ];

  int index=0;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: Colors.transparent,
          color: Colors.deepPurple,
          items: items,
          index: index,
          onTap: (index){
            setState(() {
              this.index=index;
            });
          },
          animationDuration: Duration(milliseconds: 300),
        ),
        body: Container(
/*          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,*/
          child: getSelectedWidget(index:index),
        )
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch(index){
      case 0:
        widget= AdminHome();
        break;
      case 1:
        widget= AddShipment();
        break;
      default:
        widget= AdminHome();
        break;
    }
    return widget;
  }
}
//
// class DestinationCard extends StatefulWidget {
//   const DestinationCard({Key? key}) : super(key: key);
//
//   @override
//   State<DestinationCard> createState() => _DestinationCardState();
// }
//
// class _DestinationCardState extends State<DestinationCard> {
//
//   // Map<String, dynamic>? destinationData={};
//   List<Destination> destinationList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDestination();
//   }
//
//   Future<void> fetchDestination() async{
//     String base_url='http://20.150.216.134:7070/api/v1/destinations';
//     final url=Uri.parse(base_url);
//     var response =await http.get(url);
//     if(response.statusCode==200){
//       final jsonData = jsonDecode(response.body);
//       List<Destination> destinations = [];
//       for (var item in jsonData) {
//         Destination destination = Destination(
//           name: item['name']
//         );
//         destinations.add(destination);
//     }
//       setState(() {
//         destinationList = destinations;
//       });
//     }else {
//       print('Request failed with status: ${response.statusCode}');
//     }
//   }
//
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }


class TrackingCard extends StatefulWidget {

  String? searchQuery;

  TrackingCard({Key? key,this.searchQuery}):super(key:key);

  @override
  State<TrackingCard> createState() => _TrackingCardState();
}

class _TrackingCardState extends State<TrackingCard> {

  Map<String, dynamic>? trackingData={}; //Se utiliza para asignar un objeto JSON al mismo
  //Como el JSON tiene propiedades como string o int entonces tiene que ser dynamic
  String consigneeName='';
  String date='';
  bool firstVisit=true;
  bool isLoading=true;

  @override
  void initState() {
    super.initState();
    fetchTrackingData();
  }

  @override
  void didUpdateWidget(TrackingCard oldWidget){
    firstVisit=false;
    super.didUpdateWidget(oldWidget);
    if(widget.searchQuery!=oldWidget.searchQuery){
      consigneeName='';
      trackingData={};
      fetchTrackingData();
    }
  }

  Future<void> fetchDeliveryData(int shipmentId) async {
    String URL = 'http://20.150.216.134:7070/api/v1/deliveries';
    final url = Uri.parse(URL);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var deliveriesData = json.decode(response.body);
      if (deliveriesData is List<dynamic> && deliveriesData.isNotEmpty) {
        var filteredDelivery = deliveriesData.firstWhere(
                (delivery) => delivery['shipmentId'] == shipmentId,
            orElse: () => null);
        date=filteredDelivery['date'];
      }
    }
    return;
  }

  Future<void> fetchConsigneerData(int consigneerId) async {
    String URL = 'http://20.150.216.134:7070/api/v1/consignees/$consigneerId';
    final url = Uri.parse(URL);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var consigneeData = json.decode(response.body);

      if (consigneeData is List<dynamic> && consigneeData.isNotEmpty) {
        var onlyConsigneer = consigneeData[0];
        consigneeName=onlyConsigneer['name'];
        return onlyConsigneer;
      }
    } else {
      print("Error al obtener los datos del consignee");
    }
  }

  Future<void> fetchTrackingData() async {

    setState(() {
      isLoading = true; // Mostrar el CircularProgressIndicator
    });

    String? searchQuery = widget.searchQuery;
    if (searchQuery != null && searchQuery.isNotEmpty) {
      print("Se entró al url");
      String URL = 'http://20.150.216.134:7070/api/v1/shipments/$searchQuery';
      final url = Uri.parse(URL);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData is List<dynamic> && jsonData.isNotEmpty) { // Verificar si es una lista no vacía
          setState(() {
            trackingData = jsonData[0]; // Obtener el primer elemento de la lista
          });

          if(trackingData!.isNotEmpty || trackingData!=null){
            int consigneeId=trackingData?['consigneesId'];
            await fetchConsigneerData(consigneeId);
            await fetchDeliveryData(int.parse(searchQuery));
          }
          setState(() {
            isLoading = false; // Ocultar el CircularProgressIndicator
          });

        } else {
          print("La respuesta no es una lista válida o está vacía");
        }
      } else {
        print("Error en la solicitud");
      }
    }

    setState(() {
      isLoading = false; // Ocultar el CircularProgressIndicator
    });
  }


  @override
  Widget build(BuildContext context) {

    if (firstVisit) {
      return Row( // Agregado: Envuelve el Card con Row
        children: [
          Expanded(
            child: Card(
              color: Color(0xFFF0E5FF),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.search_sharp,
                    color: Color(0xFF6200EE),
                    size: 24,
                    semanticLabel: "Search Progress",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Busca algún paquete..."),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }else if (trackingData!.isNotEmpty ) {
      return Row(
        children: [
          Expanded(
            child: Card(
              color: Color(0xFFF0E5FF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: isLoading
                  ? Column(

                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )
                  : GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientPage()));
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
                                        'Order #${widget.searchQuery.toString()}',
                                        style: TextStyle(
                                          color: Color(0xFF6200EE),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  Card(
                                    color: Color(0xFF6200EE),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 5, // Espaciado vertical
                                        horizontal: 10, // Espaciado horizontal
                                      ),
                                      child: Text(
                                        'Processing',
                                        style: TextStyle(
                                          color: Colors.white,
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
            ),
          ),
        ],
      );

    }else{
      return Row( // Agregado: Envuelve el Card con Row
        children: [
          Expanded(
            child: Card(
              color: Color(0xFFF0E5FF),
              child: isLoading? Column(
                mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
              )
              : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.error_sharp,
                    color: Color(0xFF6200EE),
                    size: 24,
                    semanticLabel: "Shipment not found!",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Tarjeta no habida"),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      );
    }

  }


}
