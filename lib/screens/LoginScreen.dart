import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: LoginFormView(),
    );
  }
}

class LoginFormView extends StatefulWidget {
  @override
  LoginFormViewState createState() => new LoginFormViewState();
}

class LoginFormViewState extends State<LoginFormView> {
  final GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();

  String _userName;
  String _password;

  void validateAndAuthenticate() {
    final form = _loginFormKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        print(
            "You have entered $_userName as your username and $_password as your password");
      });
    }
  }

  Future<Response> authenticate(String userName, String password) async {
    Client client = new Client();
    Response response = await client.post(
        "http://web1.capetown.gov.za/web1/ProcurementPortal/Account/LogOn",
        body: {'UserName': '$userName', 'Password': '$password'});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: <Widget>[
            new TextFormField(
              initialValue: "",
              validator: (value) =>
                  value.isEmpty ? 'Please enter email address' : null,
              decoration: InputDecoration(labelText: "Email Address"),
              onSaved: (value) => _userName = value,
            ),
            new TextFormField(
              initialValue: "",
              validator: (value) =>
                  value.isEmpty ? 'Please enter password' : null,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
              onSaved: (value) => _password = value,
            ),
            new RaisedButton(
              child: Text("Submit"),
              onPressed: validateAndAuthenticate,
            ),
          ],
        ),
      ),
    );
  }
}

//useCase() async {
//  var auth = authenticate("msbodw001@gmail.com", "adcorp@123456#");
//  auth.then((response) {
//    print(response.body);
//  });
//}

class RFQ {
  String id, userName, accountPassword;
  RFQ({this.id, this.userName, this.accountPassword});
}
