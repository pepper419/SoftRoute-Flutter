import 'dart:convert';

import 'package:flutter/material.dart';
import '../main.dart';
import 'package:http/http.dart' as http;


class AddShipment extends StatefulWidget {
  const AddShipment({Key? key}) : super(key: key);

  @override
  State<AddShipment> createState() => _AddShipmentState();
}

class _AddShipmentState extends State<AddShipment> {
  //sender
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  //consignee
  TextEditingController nameConsigneeController=TextEditingController();
  TextEditingController dniConsigneeController=TextEditingController();
  TextEditingController addressConsigneeController=TextEditingController();

  int currentStep=0;
  List<String> packageTypes = ['Package 1', 'Package 2', 'Package 3']; // Lista de tipos de paquete
  String selectedPackageType = 'Package 1';

  List<String> documentTypes = ['Document 1', 'Document 2', 'Document 3']; // Lista de tipos de documento
  String selectedDocumentType = 'Document 1';

  List<String> senderName = ['Sender 1', 'Sender 2', 'Sender 3']; // Lista de tipos de documento
  String selectedSenderName = 'Sender 1';

  List<String> consigneeName = ['Consignee 1', 'Consignee 2', 'Consignee 3']; // Lista de tipos de documento
  String selectedConsigneeName = 'Consignee 1';

  List<String> destinationName = ['Destination 1', 'Destination 2', 'Destination 3']; // Lista de tipos de documento
  String selectedDestinationName = 'Destination 1';

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
        appBar: CustomAppBar(),
        bottomNavigationBar: BottomBar(),
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
            }
            if(isConsigneeStep){
              postConsignee();
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
                // Aquí puedes guardar el valor del nombre en alguna variable
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                // Aquí puedes guardar el valor del correo electrónico en alguna variable
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
                  // Aquí puedes guardar el valor del nombre en alguna variable
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: dniConsigneeController,
                decoration: InputDecoration(
                  labelText: 'DNI',
                ),
                onChanged: (value) {
                  // Aquí puedes guardar el valor del correo electrónico en alguna variable
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: addressConsigneeController,
                decoration: InputDecoration(
                  labelText: 'Address',
                ),
                onChanged: (value) {
                  // Aquí puedes guardar el valor del correo electrónico en alguna variable
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
              value: selectedPackageType,
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
              value: selectedSenderName,
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
              value: selectedConsigneeName,
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
                labelText: 'Document Type',
              ),
              value: selectedDestinationName,
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
              value: selectedDocumentType,
              onChanged: (value) {
                setState(() {
                  selectedDocumentType = value!;
                });
              },
              items: documentTypes.map((String type) {
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

