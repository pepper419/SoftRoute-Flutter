import 'package:flutter/material.dart';

import '../../widgets/appBar.dart';

class DeliveriesView extends StatelessWidget {
  const DeliveriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(username: "Deliveries"),
        body: const Center(
          child: Text('Deliveries'),
        ),
      ),
    );
  }
}
