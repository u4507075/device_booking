import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class Cancelled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: const Text('Cancelled', style: TextStyle(fontSize: 25.0,
        fontWeight: FontWeight.bold,
    )),
    ),);}}