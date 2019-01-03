import 'package:flutter/material.dart';


class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")
      ),
      body: RegistrationFormView(),
    );
  }
}



class RegistrationFormView extends StatefulWidget {
  @override
  RegistrationFormViewState createState() => new RegistrationFormViewState();
}

class RegistrationFormViewState extends State<RegistrationFormView> {

  final GlobalKey<FormState> _registrationFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _registrationFormKey,
        child: ListView(
            children: <Widget>[
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new TextFormField(),
              new RaisedButton(child: Text("Submit"), onPressed: null)
            ],
          ),
      ),
    );
  }
}