import 'dart:core';
import 'package:flutter/material.dart';
import 'package:city_portal/RFQListScreen.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "City of Cape Town Unofficial App", initialRoute: '/',
        routes: {
          '/': (context) => RFQListScreen(),
        },
      )
  );
}

