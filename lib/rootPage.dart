import 'package:aprende_lsm/menu/menu.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'inicioSesion.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  Widget build (BuildContext context) {
    switch(authStatus){
      case AuthStatus.notSignedIn:
        return new InicioSesion(
          auth: widget.auth,
          onSignedIn: _signedIn);
      case AuthStatus.signedIn:
        return new Menu(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }
}