import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:password_wallet/dbhelper.dart';
import 'colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final dbhelper = Databasehelper.instance;
  String type;
  String user;
  String pass;
  var allrows = [];

  TextStyle titlestyle = TextStyle(
    fontSize: 18.0,
    fontFamily: "customFont",
    color: Colors.white,
  );

  TextStyle subtitlestyle = TextStyle(
    fontSize: 16.0,
    fontFamily: "customFont",
    color: Colors.white70,
  );

  String validateempty(_val) {
    if(_val.isEmpty) {
      return "Required field";
    }else {
      return null;
    }
  }

  void insertdata() async {
    Navigator.pop(context);
    Map<String, dynamic> row = {
      Databasehelper.columnType: type,
      Databasehelper.columnUser: user,
      Databasehelper.columnPass: pass,
    };

    final id = await dbhelper.insert(row);
    print(id);
    setState(() {});
  }

  Future queryall() async {
    allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      print(row);
    });
    print(allrows);
  }
  

  @override
  Widget build(BuildContext context) {
    void addpassword(){
      showDialog(
      context: context,
       builder: (context) => 
       Theme(
            data : ThemeData(
              primaryColor: dark,
              accentColor: deeppurple,
            ),
           child: SimpleDialog(
           backgroundColor: deeppurple,
           contentPadding: EdgeInsets.symmetric(
             horizontal: 15.0,
             vertical: 10.0,
           ),
          title: Text("ADD DATA",
            textAlign: TextAlign.center,
            style: titlestyle,
          ),
          children: <Widget>[
            Form(
              key : formstate,
              child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color : dark,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color : dark,
                        ),
                      ),
                      labelText: "Select Type",
                      labelStyle: subtitlestyle,
                    ),
                    style: titlestyle,
                    validator: validateempty,
                    onChanged : (_val) {
                      type = _val;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter Username / Email",
                      labelStyle: subtitlestyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color : dark,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color : dark,
                        ),
                      ),
                    ),
                    
                    style: titlestyle,
                    validator: validateempty,
                    onChanged : (_val) {
                      user = _val;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Enter Password",
                      labelStyle: subtitlestyle,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color : dark,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color : dark,
                        ),
                      ),
                    ),
                    style: titlestyle,
                    validator: validateempty,
                    onChanged : (_val) {
                      pass = _val;
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: (){
                      if (formstate.currentState.validate()) {
                          print("Ready To Enter Data");
                          insertdata();
                        }
                    },
                    child: Text("ADD",
                    style: titlestyle,
                    ),
                    color : deeppurple,
                    padding: EdgeInsets.symmetric(
                      horizontal: 35.0,
                      vertical: 10.0
                    ),
                    elevation: 5.0,
                  ),
                ],
              ),
            )
          ],
         ),
       )
       );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark,
        title : Text(
          "Saved Passwords",
          style : TextStyle(
            color: Colors.white,
            fontFamily: "customFont",
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            ),
          ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: deeppurple,
        onPressed: addpassword,
        child : FaIcon(FontAwesomeIcons.plus),
      ),
      backgroundColor: dark,
      body : FutureBuilder(
        builder: (context, snapshot){
          if(snapshot.hasData != null) {
            if(allrows.length == 0) {
              return Center(
                child : Text(
                  "No Data Available 😢\nClick on the Add Button to enter some !",
                  textAlign: TextAlign.center,
                  style : TextStyle(
                    color : lightpurple,
                    fontSize: 25.0,
                    fontFamily: 'ccustomFont',
                  ),
                ),
              );
            }else {
              return Center(
              child: Container(
                width: MediaQuery.of(context).size.width *0.95,
                child: ListView.builder(
                  itemCount: allrows.length,
                  itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.only(
                        top : 15.0,
                      ),
                      decoration: BoxDecoration(
                        color : deeppurple,
                        borderRadius: BorderRadius.circular(8.0),
                        ),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top :5.0),
                            child: Text(
                              allrows[index]["type"],
                              style : TextStyle(
                                fontSize: 20.0,
                                color : Colors.white,
                                fontFamily: "customFont",
                              ),
                              textAlign : TextAlign.center,
                            ),
                          ),
                          ListTile(
                            leading: FaIcon(FontAwesomeIcons.userSecret,
                            size : 40.0,
                            color : Colors.white,
                            ),
                            title : Text(
                              allrows[index]['user'],
                              style : titlestyle,
                            ),
                            subtitle: Text(
                              allrows[index]['pass'],
                              style : subtitlestyle,
                              ),
                          ),
                        ],
                      ),
                    );
                  }),
              ),
            );
            }
          }else {
            return Center(
              child : CircularProgressIndicator(),
            );
          }
        },
      future : queryall(),
      ),
    
    );
  }
}