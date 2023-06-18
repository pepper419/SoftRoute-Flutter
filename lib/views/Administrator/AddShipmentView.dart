import 'dart:convert';


import 'package:example_souf_route/models/Destination.dart';
import 'package:example_souf_route/models/DocumentType.dart';
import 'package:example_souf_route/models/Sender.dart';
import 'package:example_souf_route/models/TypeOfPackage.dart';
import 'package:flutter/material.dart';

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

  //Shipment
  TextEditingController weightShipmentController=TextEditingController();
  TextEditingController quantityShipmentController=TextEditingController();
  TextEditingController freightShipmentController=TextEditingController();
  TextEditingController dateShipmentController=TextEditingController();
  TextEditingController descriptionShipmentController=TextEditingController();

  int currentStep=0;
  List<TypeOfPackage> packageTypes = []; // Lista de tipos de paquete
  TypeOfPackage? selectedPackageType;

  List<DocumentType> documentType = []; // Lista de tipos de documento
  DocumentType? selectedDocumentType;

  List<Sender> senderInfo = []; // Lista de tipos de documento
  Sender? selectedSenderName;

  List<Consignee> consigneeInfo = []; // Consignee list name
  Consignee? selectedConsigneeName;

  List<Destination> destinationInfo = []; // Lista de tipos de documento
  Destination? selectedDestinationName;

  void initState() {
    super.initState();
    getConsigneerName();
    getSenderName();
  }



  Future<void> postShipment()async{
    String URL='http://20.150.216.134:7070/api/v1/shipments';
    int? selectedPackageId=selectedPackageType?.id;
    int? selectedSenderId=selectedSenderName?.id;
    int? selectedConsigneeId=selectedConsigneeName?.id;
    int? selectedDestinationId=selectedDestinationName?.id;
    int? selectedDocumentId=selectedDocumentType?.id;
    //input text
    String weight=weightShipmentController.text;
    String quantity =quantityShipmentController.text;
    String freight =quantityShipmentController.text;
    String date =dateShipmentController.text;
    String description=descriptionShipmentController.text;

    final url=Uri.parse(URL);
    var response =await http.post(
      url,
      headers: {
        'Content-Type':'application/json',
      },
      body: json.encode({
        'description':description,
        'quantity':int.parse(quantity),
        'freight':int.parse(freight),
        'weight':int.parse(weight),
        'date':date,
        'destinyId':selectedDestinationId,
        'consigneesId':selectedConsigneeId,
        'senderId':selectedSenderId,
        'typeOfPackageId':selectedPackageId,
        'documentId':selectedDocumentId
      })
    );

    if(response.statusCode==200){
      print('POST successfully completed');
    }else{
      print('POST request failed: ${response.statusCode}');
    }
    print('JULIAN TE AMO AAAA');

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
      List<Consignee> consigneeInfos = []; // Crear una lista de nombres de consignees
      for (var item in jsonData) {
        int id = item['id'];
        String dni = item['dni'];
        String address = item['address'];
        String name = item['name'];
        Consignee consigneeInfo=Consignee(id: id, dni: dni, name: name, address: address);
        consigneeInfos.add(consigneeInfo);
      }
      setState(() {
        this.consigneeInfo=consigneeInfos;
      });
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
      List<Sender> senderInfos = []; // Crear una lista de nombres de consignees
      for (var item in jsonData) {
        int id=item['id'];
        String name = item['name'];
        String email=item['email'];
        Sender senderInfo=Sender(id: id,name:name,email: email);
        senderInfos.add(senderInfo);
      }
      setState(() {
        this.senderInfo=senderInfos; // Asignar la lista de nombres de sender a senderName
      });
    } else {
      print('Request failed with status error: ${response.statusCode}');

    }
  }

  Future<void> getDestinationName() async {
    String URL = 'http://20.150.216.134:7070/api/v1/destinations';
    final url = Uri.parse(URL);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<Destination> destinationInfos = []; // Crear una lista de nombres de consignees
      for (var item in jsonData) {
        int id  = item['id'];
        String name = item['name'];
        Destination destinationInfo=Destination(id: id, name: name);
        destinationInfos.add(destinationInfo);
      }
      setState(() {
        this.destinationInfo=destinationInfos; // Asignar la lista de nombres de sender a senderName
      });
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
      List<DocumentType> documentTypes = []; // Crear una lista de nombres de document
      for (var item in jsonData) {
        int id = item['id'];
        String name = item['name'];
        DocumentType documentType=DocumentType(id:id,name:name);
        documentTypes.add(documentType);
      }
      setState(() {
        this.documentType=documentTypes; // Asignar la lista de nombres de document a documentType
      });
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> getTypePackageName() async {
    String URL = 'http://20.150.216.134:7070/api/v1/typeofpackage';
    final url = Uri.parse(URL);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      List<TypeOfPackage> packageTypes=[];
      for (var item in jsonData) {
        String name = item['name'];
        int id = item['id'];
        TypeOfPackage packageType = TypeOfPackage(name: name, id: id);
        packageTypes.add(packageType);
      }
      setState(() {
        this.packageTypes=packageTypes; // Asignar la lista de nombres de sender a senderName
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
              postShipment();
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
            DropdownButtonFormField<TypeOfPackage>(
              decoration: InputDecoration(
                labelText: 'Package Type',
              ),
              value: selectedPackageType,
              onChanged: (TypeOfPackage? value) {
                setState(() {
                  selectedPackageType = value!;
                });
              },
              items: packageTypes.map((TypeOfPackage packageType) {
                return DropdownMenuItem<TypeOfPackage>(
                  value: packageType,
                  child: Text(packageType.name),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            DropdownButtonFormField<Sender>(
              decoration: InputDecoration(
                labelText: 'Sender',
              ),
              value: selectedSenderName,
              onChanged: (value) {
                setState(() {
                  selectedSenderName = value!;
                });
              },
              items: senderInfo.map((Sender senderInfo) {
                return DropdownMenuItem<Sender>(
                  value: senderInfo,
                  child: Text(senderInfo.name),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            DropdownButtonFormField<Consignee>(
              decoration: InputDecoration(
                labelText: 'Consignee',
              ),
              // value: selectedConsigneeName,
              value:selectedConsigneeName,
              onChanged: (value) {
                setState(() {
                  selectedConsigneeName = value!;
                });
              },
              items: consigneeInfo.map((Consignee consigneeInfo) {
                return DropdownMenuItem<Consignee>(
                  value: consigneeInfo,
                  child: Text(consigneeInfo.name),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            TextField(
              controller: weightShipmentController,
              decoration: InputDecoration(
                labelText: 'Weight',
              ),
              onChanged: (value) {
                // Aquí puedes guardar el valor del nombre en alguna variable
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: quantityShipmentController,
              decoration: InputDecoration(
                labelText: 'Quantity',
              ),
              onChanged: (value) {
                // Aquí puedes guardar el valor del correo electrónico en alguna variable
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: freightShipmentController,
              decoration: InputDecoration(
                labelText: 'Freight',
              ),
              onChanged: (value) {
                // Aquí puedes guardar el valor del correo electrónico en alguna variable
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: dateShipmentController,
              decoration: InputDecoration(
                labelText: 'Date',
              ),
              onChanged: (value) {
                // Aquí puedes guardar el valor del correo electrónico en alguna variable
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: descriptionShipmentController,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) {
                // Aquí puedes guardar el valor del correo electrónico en alguna variable
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<Destination>(
              decoration: InputDecoration(
                labelText: 'Destination',
              ),
              value: selectedDestinationName,
              onChanged: (value) {
                setState(() {
                  selectedDestinationName = value!;
                });
              },
              items: destinationInfo.map((Destination destinationInfo) {
                return DropdownMenuItem<Destination>(
                  value: destinationInfo,
                  child: Text(destinationInfo.name),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            DropdownButtonFormField<DocumentType>(
              decoration: InputDecoration(
                labelText: 'Document Type',
              ),
              value: selectedDocumentType,
              onChanged: (value) {
                setState(() {
                  selectedDocumentType = value!;
                });
              },
              items: documentType.map((DocumentType documentType) {
                return DropdownMenuItem<DocumentType>(
                  value: documentType,
                  child: Text(documentType.name),
                );
              }).toList(),
            ),



          ],
        ),
      ),
    ),

  ];

}

