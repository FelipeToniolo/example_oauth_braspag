import 'package:braspag_oauth_dart/oauth.dart';
import 'package:flutter/material.dart';

class TokenPage extends StatelessWidget {
  final BraspagOAuth response;
  TokenPage({this.response});

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
                          Text(
                            'AccessToken => ${response.accessToken}',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                          Text(
                            'Type => ${response.tokenType}',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 16),
                          ),
                          Text(
                            'ExpireIn => ${response.expiresIn}',
                            style:
                                TextStyle(color: Colors.black87, fontSize: 16),
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
}
