import 'package:flutter/material.dart';
import 'graph_widget.dart';
import 'package:aprende_lsm/menu/menu.dart';

const backgroundColor = Color(0xFF2d3447);

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
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
        children: <Widget>[
          userWidget(),
          pointsWidget(),
          GraphWidget(),
          friendsWidget(),
        ],
      ),
    );
  }

  Widget userWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, top: 24.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.account_circle,
            color: Colors.white,
            size: 80.0,
          ),
          SizedBox(width: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Roberto",
                style: TextStyle(
                    fontFamily: "Calibre-Semibold",
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Piña Olivas",
                style: TextStyle(
                    fontFamily: "Calibre-Semibold",
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget pointsWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, top: 24.0, right: 16.0),
      child: Container(
        width: double.infinity,
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: CustomPaint(
          painter: PointsPainter(),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "6",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Lecciones terminadas",
                        style: TextStyle(
                            fontFamily: "Calibre-Semibold",
                            fontSize: 16.0,
                            color: Colors.deepPurpleAccent),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "8,500",
                        style: TextStyle(
                            fontFamily: "Calibre-Semibold",
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "puntos",
                        style: TextStyle(
                            fontFamily: "Calibre-Semibold",
                            fontSize: 16.0,
                            letterSpacing: 0.6,
                            color: Colors.deepPurpleAccent),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget friendsWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Container(
        height: 175.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Logros",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage('assets/logro_experto.png'),
                      ),
                    ),
                  ),
                  Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage('assets/logro_intermedio.png'),
                      ),
                    ),
                  ),
                  Container(
                    width: 75.0,
                    height: 75.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage('assets/logro_principiante.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Container(
                      width: 75.0,
                      height: 75.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.yellow),
                      child: Center(child: Text("12")),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PointsPainter extends CustomPainter {
  Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = Colors.deepPurpleAccent.withOpacity(0.15);

    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width / 2 - 40, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
