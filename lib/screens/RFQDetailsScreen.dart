import 'package:flutter/material.dart';
import 'package:city_portal/screens/RFQListScreen.dart';

class RFQDetailsScreen extends StatefulWidget {
  final RFQ item;
  const RFQDetailsScreen({Key key, this.item}) : super(key: key);
  @override
  RFQDetailsScreenState createState() => new RFQDetailsScreenState();
}

class RFQDetailsScreenState extends State<RFQDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("${widget.item.detailsLink}")));
  }
}