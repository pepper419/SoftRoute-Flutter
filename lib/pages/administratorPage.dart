import 'dart:convert';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:http/http.dart' as http;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../widgets/appBar.dart';
import '../views/Administrator/AddShipmentView.dart';
import '../views/Administrator/AdminHomeView.dart';


class AdminPage extends StatefulWidget {

  final String username;

  AdminPage({required this.username});

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
          appBar: CustomAppBar(username: widget.username),
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
        widget= AdminHomeView();
        break;
      case 1:
        widget= AddShipmentView();
        break;
      default:
        widget= AdminHomeView();
        break;
    }
    return widget;
  }
}