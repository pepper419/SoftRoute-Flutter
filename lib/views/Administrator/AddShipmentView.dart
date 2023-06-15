import 'dart:convert';

import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

import '../../models/Consignee.dart';


class AddShipmentView extends StatefulWidget {
  const AddShipmentView({Key? key}) : super(key: key);

  @override
  State<AddShipmentView> createState() => _AddShipmentViewState();
}

class _AddShipmentViewState extends State<AddShipmentView> {
  //sender
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //consignee
  TextEditingController nameConsigneeController=TextEditingController();
  TextEditingController dniConsigneeController=TextEditingController();
  TextEditingController addressConsigneeController=TextEditingController();
  List<String> consigneeList = [];

  int currentStep=0;
  List<String> packageTypes = ['']; // Lista de tipos de paquete
  String selectedPackageType = '';

  List<String> documentType = ['']; // Lista de tipos de documento
  String selectedDocumentType = '';

  List<String> senderName = ['']; // Lista de tipos de documento
  String selectedSenderName = '';

  List<String> consigneeName = ['']; // Consignee list name
  String selectedConsigneeName = '';

  List<String> destinationName = ['']; // Lista de tipos de documento
  String selectedDestinationName = '';

  void initState() {
    super.initState();
    getConsigneerName();
    getSenderName();
  }




  Future<void> postSender()async{
    String base_url = 'http://20.150.216.134:7070/api/v1/sender';
    String name = nameController.text;
    String email = emailController.text;

    final url=Uri.parse(base_url);
    var response=await http.post(
      url,
        headers: {
          'Content-Type': 'application/json', // establish json content
        },
      body: json.encode({
        'name': name,
        'email': email,
      }),
    );

    if(response.statusCode==200){
      print('POST request successful');
    }else {
      // La solicitud no fue exitosa
      print('POST request failed: ${response.statusCode}');
    }
  }

  Future<void> postConsignee()async{
    String base_url = 'http://20.150.216.134:7070/api/v1/consignees';
    String name=nameConsigneeController.text;
    String dni=dniConsigneeController.text;
    String address=addressConsigneeController.text;

    final url=Uri.parse(base_url);
    var response=await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name':name,
        'dni':dni,
        'address':address,
      })
    );

    if(response.statusCode==200||response.statusCode==201){
      print('POST request successful');
    }else {
      // La solicitud no fue exitosa
      print('POST request failed: ${response.statusCode}');
    }


  }

  Future<void> getConsigneerName() async {
    String URL = 'http://20.150.216.134:7070/api/v1/consignees';
    final url = Uri.parse(URL);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> consigneeNames = []; // Crear una lista de nombres de consignees
      for (var item in jsonData) {
        String name = item['name'];
        consigneeNames.add(name);
      }
      setState(() {
        consigneeList = consigneeNames; // Asignar la lista de nombres de consignees a consigneeList
        consigneeName=consigneeNames;
      });
      print(consigneeList);
      print(consigneeName);
    } else {
      print('Request failed with status: ${response.statusCode}');

    }
  }

  Future<void> getSenderName() async {
    String URL = 'http://20.150.216.134:7070/api/v1/sender';
    final url = Uri.parse(URL);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> senderNames = []; // Crear una lista de nombres de consignees
      for (var item in jsonData) {
        String name = item['name'];
        senderNames.add(name);
      }
      setState(() {
        senderName=senderNames; // Asignar la lista de nombres de sender a senderName
      });
      print(senderName);
    } else {
      print('Request failed with status: ${response.statusCode}');

    }
  }

  Future<void> getDestinationName() async {
    String URL = 'http://20.150.216.134:7070/api/v1/destinations';
    final url = Uri.parse(URL);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> destinationNames = []; // Crear una lista de nombres de consignees
      for (var item in jsonData) {
        String name = item['name'];
        destinationNames.add(name);
      }
      setState(() {
        destinationName=destinationNames; // Asignar la lista de nombres de sender a senderName
      });
      print(destinationName);
    } else {
      print('Request failed with status: ${response.statusCode}');

    }
  }

  Future<void> getDocumentType() async {
    String URL = 'http://20.150.216.134:7070/api/v1/documents';
    final url = Uri.parse(URL);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> documentTypes = []; // Crear una lista de nombres de document
      for (var item in jsonData) {
        String name = item['name'];
        documentTypes.add(name);
      }
      setState(() {
        documentType=documentTypes; // Asignar la lista de nombres de document a documentType
      });
      print(documentType);
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('JULIAN T AMOOOOOOOOOOOO');

    }
  }

  Future<void> getTypePackageName() async {
    String URL = 'http://20.150.216.134:7070/api/v1/typeofpackage';
    final url = Uri.parse(URL);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<String> packageNames = []; // Crear una lista de nombres de consignees
      for (var item in jsonData) {
        String name = item['name'];
        packageNames.add(name);
      }
      setState(() {
        packageTypes=packageNames; // Asignar la lista de nombres de sender a senderName
      });
      print(packageTypes);
    } else {
      print('Request failed with status: ${response.statusCode}');

    }
  }


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    nameConsigneeController.dispose();
    dniConsigneeController.dispose();
    addressConsigneeController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context)=>
      Scaffold(
        body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: (){
            final isLastStep=currentStep==getSteps().length-1;
            final isSenderStep=currentStep==getSteps().length-3;
            final isConsigneeStep=currentStep==getSteps().length-2;

            if(isSenderStep){
              postSender();
              getDestinationName();
              getDocumentType();
              getTypePackageName();
            }
            if(isConsigneeStep){
              postConsignee();
              getConsigneerName();
              getSenderName();
            }
            if(isLastStep){
              print('complete');
            }else{
              setState(()=>currentStep+=1);
            }
          },
          onStepCancel:
          currentStep==0?null: ()=>setState(()=>currentStep-=1),
        ),
      );

  List<Step> getSteps()=>[
    Step(
      isActive: currentStep>=0,
      title: Text('Senders'),
      content: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) {

              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {

              },
            ),
          ],
        ),
      )
    ),
    Step(
      isActive: currentStep>=1,
      title: Text('Consigness'),
        content: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: nameConsigneeController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onChanged: (value) {

                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: dniConsigneeController,
                decoration: InputDecoration(
                  labelText: 'DNI',
                ),
                onChanged: (value) {

                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: addressConsigneeController,
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
                onChanged: (value) {

                },
              ),
            ],
          ),
        ),
    ),
    Step(
      isActive: currentStep>=2,
      title: Text('Package'),
      content: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Package Type',
              ),
              value: selectedPackageType=packageTypes.isNotEmpty? packageTypes[0]:'',
              onChanged: (value) {
                setState(() {
                  selectedPackageType = value!;
                });
              },
              items: packageTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Sender',
              ),
              value: selectedSenderName=senderName.isNotEmpty?senderName[0]:'',
              onChanged: (value) {
                setState(() {
                  selectedSenderName = value!;
                });
              },
              items: senderName.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Consignee',
              ),
              // value: selectedConsigneeName,
              value:selectedConsigneeName = consigneeName.isNotEmpty ? consigneeName[0] : '',
              onChanged: (value) {
                setState(() {
                  selectedConsigneeName = value!;
                });
              },
              items: consigneeName.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Weight',
              ),
              onChanged: (value) {
                // Aquí puedes guardar el valor del nombre en alguna variable
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
              onChanged: (value) {
                // Aquí puedes guardar el valor del correo electrónico en alguna variable
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Freight',
              ),
              onChanged: (value) {
                // Aquí puedes guardar el valor del correo electrónico en alguna variable
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Date',
              ),
              onChanged: (value) {
                // Aquí puedes guardar el valor del correo electrónico en alguna variable
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) {
                // Aquí puedes guardar el valor del correo electrónico en alguna variable
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Destination',
              ),
              value: selectedDestinationName=destinationName.isNotEmpty? destinationName[0]:'',
              onChanged: (value) {
                setState(() {
                  selectedDestinationName = value!;
                });
              },
              items: destinationName.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Document Type',
              ),
              value: selectedDocumentType=documentType.isNotEmpty? documentType[0]:'',
              onChanged: (value) {
                setState(() {
                  selectedDocumentType = value!;
                });
              },
              items: documentType.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
            ),

          ],
        ),
      ),
    ),

  ];

}

