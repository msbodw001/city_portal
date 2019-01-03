import 'dart:core';
import 'package:city_portal/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "City of Cape Town Unofficial App",
    initialRoute: '/',
    routes: {
      '/': (_) => LoginScreen(),
    },
  ));
}

