
import 'package:example_souf_route/pages/LoginAndRegister.dart';
import 'package:example_souf_route/pages/registro.dart';
import 'package:example_souf_route/views/Client/AddCommentView.dart';
import 'package:flutter/material.dart';
import 'pages/Login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pages/administratorPage.dart';
import 'pages/clientPage.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(), // Ruta inicial (home)
        '/registro': (context) => RegistroScreen(),
        '/admin': (context) => AdminPage(username: '',),
        // Agrega otras rutas si es necesario
      },
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginandRegisterView()),
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
/*                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ClientPage()));*/
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => ClientPage(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 500),
                      ),
                    );
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

