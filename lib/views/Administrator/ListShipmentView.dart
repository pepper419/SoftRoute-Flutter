import 'package:flutter/material.dart';

class ListShipmentView extends StatefulWidget {
  const ListShipmentView({Key? key}) : super(key: key);

  @override
  State<ListShipmentView> createState() => _ListShipmentViewState();
}

class _ListShipmentViewState extends State<ListShipmentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Titulo"),
      ),
      body: Center(),
    );
  }
}
