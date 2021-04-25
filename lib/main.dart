import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:password_wallet/colors.dart';
import 'package:password_wallet/passwordpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Manager',
      theme: ThemeData(
        accentColor: dark,
        primaryColor: deeppurple,
        textTheme: TextTheme().apply(
          fontFamily: "customFont",
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void check() {
    if(formKey.currentState.validate()) {
      print("Validated");
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => PasswordPage(),
        ),
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      body: Center(
        child : Form(
          key : formKey,
          child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                // FontAwesomeIcons.laptopCode,
                FontAwesomeIcons.userLock,
                color : lightpurple,
                size : 100.0,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextFormField(
                  style : TextStyle(
                    color : Colors.white,
                    fontSize: 20.0,
                    fontFamily: "customFont"
                  ),
                  decoration: InputDecoration(
                    labelText: "Enter Password",
                    labelStyle: TextStyle(
                      color : dark,
                      fontFamily: "customFontBold",
                    ),
                    filled : true,
                    fillColor : lightpurple,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 8.0,
                    )
                  ),

                  validator: (_val) {
                    if(_val == "shubh") {
                      return null;
                    }else {
                      return "Password doesn't match";
                    }
                  },
                  
                ),
              ),
              // ignore: deprecated_member_use
              RaisedButton(
                padding: EdgeInsets.symmetric(
                  horizontal : 50.0,
                  vertical : 10.0,
                ),
                onPressed: check,
                child : Text(
                "Enter",
                style : TextStyle(
                    color : Colors.white,
                    fontSize: 20.0,
                    fontFamily: "customFontBold",
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                color : lightpurple,
                textColor: Colors.white,
                
              )
            ],
          )
        )
      ),
    );
  }
}