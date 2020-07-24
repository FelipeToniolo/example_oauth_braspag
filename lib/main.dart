import 'package:braspag_oauth_dart/oauth.dart';
import 'package:exampleoauthbraspag/tokenPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo OAuth Braspag',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controllerId =
      TextEditingController(text: "eeb1230a-d756-4bc4-bf92-87ce18a00d2f");

  final _controllerSecret = TextEditingController(
      text: "RdhID4KOY1HsSsuCFU3pmtJO2DhYqwJo5xNkxNATOh8=");

  var showProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Braspag OAuth'),
        centerTitle: true,
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.body2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: TextFormField(
                              controller: _controllerId,
                              decoration: InputDecoration(
                                labelText: "Client Id",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.zero)),
                                labelStyle: TextStyle(fontSize: 25),
                                hintStyle: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Center(
                              child: TextFormField(
                                controller: _controllerSecret,
                                decoration: InputDecoration(
                                  labelText: "Client Secret",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.zero)),
                                  labelStyle: TextStyle(fontSize: 25),
                                  hintStyle: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              _getToken();
                              setState(() {});
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: 200, minHeight: 50),
                              alignment: Alignment.center,
                              child: showProgress
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _getToken({String clientId, String clientSecret}) async {
    try {
      showProgress = true;

      print("chamando braspag");

      clientId = _controllerId.text;
      clientSecret = _controllerSecret.text;

      var response = (await BraspagOAuth.getToken(
          clientId: clientId,
          clientSecret: clientSecret,
          enviroment: OAuthEnviroment.SANDBOX));

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TokenPage(
            response: response,
          ),
        ),
      );
    } on ErrorResponseOAuth catch (e) {
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {
          setState(() {
            showProgress = false;
          });
          Navigator.pop(context);
        },
      );

      WillPopScope alert = WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text("OAuth"),
          content: Text(e.message),
          actions: [
            okButton,
          ],
        ),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

      print("--------------------------------------");
      print('Code => ${e.code}');
      print('Message: ${e.message}');
      print("--------------------------------------");
    }
    showProgress = false;
  }
}
