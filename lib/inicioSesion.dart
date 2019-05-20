import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Widgets/SocialIcons.dart';
import 'auth.dart';
import 'authGoogle.dart';
import 'CustomIcons.dart';

class InicioSesion extends StatefulWidget {
  InicioSesion({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new _InicioSesion();
}

enum FormType { login, register }

String _email, _password;
FormType _formType = FormType.login;

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Es necesario un correo electrónico.' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    if (value.length < 6)
      return "La contraseña debe contener por lo menos 6 carácteres";
    return value.isEmpty ? 'Es necesaria una contraseña.' : null;
  }
}

class _InicioSesion extends State<InicioSesion> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
        } else {
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
        }
      } catch (e) {
        print("Error: $e");
      }
      widget.onSignedIn();
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.white.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Image.asset("assets/inicio_portada.png"),
              ),
              Expanded(
                child: Container(),
              ),
              Image.asset("assets/inicio_bottom.png")
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/logo.png",
                        width: ScreenUtil.getInstance().setWidth(110),
                        height: ScreenUtil.getInstance().setHeight(110),
                      ),
                      Text("Aprende LSM",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              color: Colors.white,
                              fontSize: ScreenUtil.getInstance().setSp(60),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ), //Aqui empieza el FormCard
                  Container(
                    width: double.infinity,
                    height: ScreenUtil.getInstance().setHeight(500),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 15.0),
                              blurRadius: 15.0),
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, -10.0),
                              blurRadius: 10.0),
                        ]),
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: buildInputs(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: ScreenUtil.getInstance()
                          .setHeight(40)), //Termina FormCard
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buildSubmitButtons(),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      Text("Iniciar sesion con",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: "Poppins-Medium")),
                      horizontalLine()
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        colors: [
                          Color(0xFF102397),
                          Color(0xFF187adf),
                          Color(0xFF00eaf8),
                        ],
                        iconData: CustomIcons.facebook,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFFff4f38),
                          Color(0xFFff355d),
                        ],
                        iconData: CustomIcons.googlePlus,
                        onPressed: () => authService.googleSignIn(),
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF17ead9),
                          Color(0xFF6078ea),
                        ],
                        iconData: CustomIcons.twitter,
                        onPressed: () => authService.signOut(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: textInicio(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> textInicio() {
    if (_formType == FormType.login) {
      return <Widget>[
        InkWell(
          onTap: moveToRegister,
          child: Text("¿Nuevo usuario?  Registrarse",
              style:
                  TextStyle(color: Colors.white, fontFamily: "Poppins-Bold")),
        )
      ];
    } else {
      return <Widget>[
        InkWell(
          onTap: moveToLogin,
          child: Text("¿Ya tienes una cuenta? Inicia Sesión",
              style:
                  TextStyle(color: Colors.white, fontFamily: "Poppins-Bold")),
        )
      ];
    }
  }

  List<Widget> buildInputs() {
    if (_formType == FormType.login) {
      return <Widget>[
        Text("Iniciar Sesión",
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(45),
                fontFamily: "Poppins-Bold",
                letterSpacing: .6)),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        TextFormField(
          style: TextStyle(
              fontFamily: "Poppins-Medium",
              fontSize: ScreenUtil.getInstance().setSp(26)),
          key: Key("email"),
          decoration: InputDecoration(labelText: 'Correo electrónico'),
          validator: EmailFieldValidator.validate,
          onSaved: (String value) => _email = value,
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        TextFormField(
          style: TextStyle(
              fontFamily: "Poppins-Medium",
              fontSize: ScreenUtil.getInstance().setSp(26)),
          key: Key("password"),
          decoration: InputDecoration(labelText: "Contraseña"),
          obscureText: true,
          validator: PasswordFieldValidator.validate,
          onSaved: (String value) => _password = value,
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(35),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: <Widget>[
        //     Text(
        //       "¿Contraseña olvidada?",
        //       style: TextStyle(
        //           color: Colors.blue,
        //           fontFamily: "Poppins-Medium",
        //           fontSize:
        //               ScreenUtil.getInstance().setSp(28)),
        //     ),
        //   ],
        // ),
      ];
    } else {
      return <Widget>[
        Text("Registrate",
            style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(45),
                fontFamily: "Poppins-Bold",
                letterSpacing: .6)),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        TextFormField(
          style: TextStyle(
              fontFamily: "Poppins-Medium",
              fontSize: ScreenUtil.getInstance().setSp(26)),
          key: Key("email"),
          decoration: InputDecoration(labelText: 'Correo electrónico'),
          validator: EmailFieldValidator.validate,
          onSaved: (String value) => _email = value,
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        TextFormField(
          style: TextStyle(
              fontFamily: "Poppins-Medium",
              fontSize: ScreenUtil.getInstance().setSp(26)),
          key: Key("password"),
          decoration: InputDecoration(labelText: "Contraseña"),
          obscureText: true,
          validator: PasswordFieldValidator.validate,
          onSaved: (String value) => _password = value,
        ),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(35),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: <Widget>[
        //     Text(
        //       "¿Contraseña olvidada?",
        //       style: TextStyle(
        //           color: Colors.blue,
        //           fontFamily: "Poppins-Medium",
        //           fontSize:
        //               ScreenUtil.getInstance().setSp(28)),
        //     ),
        //   ],
        // ),
      ];
    }
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        InkWell(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(330),
            height: ScreenUtil.getInstance().setHeight(100),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF6078ea).withOpacity(.3),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0)
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: validateAndSubmit,
                child: Center(
                  child: Text("INICIAR SESIÓN",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins-Bold",
                          fontSize: 18,
                          letterSpacing: 1.0)),
                ),
              ),
            ),
          ),
        )
      ];
    } else {
      return <Widget>[
        InkWell(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(330),
            height: ScreenUtil.getInstance().setHeight(100),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF6078ea).withOpacity(.3),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0)
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: validateAndSubmit,
                child: Center(
                  child: Text("REGISTRATE",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins-Bold",
                          fontSize: 18,
                          letterSpacing: 1.0)),
                ),
              ),
            ),
          ),
        )
      ];
    }
  }
}
