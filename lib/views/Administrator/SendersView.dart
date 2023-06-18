import 'package:flutter/material.dart';

import '../../widgets/appBar.dart';

class SendersView extends StatelessWidget {
  const SendersView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(username: "Senders"),
        body: const Center(
          child: Text('Senders'),
        ),
      ),
    );
  }
}
