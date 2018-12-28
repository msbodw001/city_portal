import 'dart:core';
import 'package:city_portal/MainScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "City of Cape Town Unofficial App", initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
        },
      )
  );
}

