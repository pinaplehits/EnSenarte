import 'package:aprende_lsm/auth.dart';
import 'package:flutter/material.dart';

import 'rootPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      home: new RootPage(auth: new Auth(),), 
      title: "EnSeñarte");
  }
}