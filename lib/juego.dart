import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'menu/menu.dart';

const backgroundColor = Color(0xFF2d3447);

class Juego extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Menu();
                }));
              },
            )
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 50.0, top: 80),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset("assets/a_juego.png",
                  width: 296.0, height: 222.0),
            ),
          ),
          const SizedBox(
            width: 100.0,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 50.0,
              ),
              const SizedBox(height: 20.0),
              RaisedButton(
                onPressed: () {},
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(40.0),
                  child: const Text('A', style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(width: 20.0),
              RaisedButton(
                onPressed: () {},
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(40.0),
                  child: const Text('B', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    /*return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.close,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Menu();
                }));
              },
            )
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      body: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 50.0, top: 80),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset("assets/a_juego.png",
                  width: 296.0, height: 222.0),
            ),
          )
        ],
      ),
    );*/
  }
}
