import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Consignee{
  final String name;
  final String address;
  final String dni;

  Consignee({
    required this.name,
    required this.address,
    required this.dni
  });

}