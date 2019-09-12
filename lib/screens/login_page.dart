import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voters/Database/DBHelperRepresentatives.dart';
import 'package:voters/Database/DBHelperAdmin.dart';
import 'package:voters/main.dart';
import 'package:voters/model/Admin.dart';
import 'package:voters/screens/admin_page.dart';
import 'package:voters/screens/create_admin.dart';
import 'package:voters/screens/representative_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class loginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return loginPageState();
  }
}

class loginPageState extends State<loginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Admin admin;

  bool adminStatus = false;
  bool repStatus = false;

  var numberController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.purple],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )),
            )),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Center(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(12),
                      child: Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Form(
                            key: _formKey,
                            child: Column(children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(0),
                                child: image(),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15, bottom: 10, right: 15, left: 15),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText: 'Mobile Number',
                                      hintText: 'Enter Your Mobile Number',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                  controller: numberController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please Enter your Number';
                                    } else if (value.length != 10) {
                                      return 'Please Enter 10 Digits';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 10),
                                child: TextFormField(
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      hintText: 'Enter Your Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                  controller: passwordController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please Enter your Password';
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, bottom: 30, top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(top: 10),
                                          height: 45,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                            colors: [
                                              Colors.pinkAccent,
                                              Colors.purple
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          )),
                                          child: GestureDetector(
                                            child: Center(
                                              child: Text(
                                                'Admin Login',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                            onTap: () {
                                              onButtonClick('admin');
                                            },
                                          )),
                                    ),
                                    Container(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Container(
                                          padding: EdgeInsets.all(8),
                                          margin: EdgeInsets.only(top: 10),
                                          height: 45,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                            colors: [
                                              Colors.pinkAccent,
                                              Colors.purple
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          )),
                                          child: GestureDetector(
                                            child: Center(
                                              child: Text(
                                                'Representative Login',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                textScaleFactor: 0.9,
                                              ),
                                            ),
                                            onTap: () {
                                              onButtonClick('rep');
                                            },
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                  child: Padding(
                                padding: EdgeInsets.only(bottom: 8, top: 5),
                                child: Text(
                                  'Don\'t Have an Account?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15),
                                ),
                              )),
                              Center(
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom: 25),
                                      child: InkWell(
                                        child: Text(
                                          'Create Admin',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.pink,
                                          ),
                                        ),
                                        onTap: () {
                                          createAdminAccount();
                                        },
                                      )))
                            ]),
                          )))
                ],
              ),
            )
          ],
        ));
  }

  Image image() {
    AssetImage assetImage = AssetImage('images/vote.png');
    Image image = Image(
      image: assetImage,
      width: 150,
      height: 150,
    );
    return image;
  }

  void createAdminAccount() {
    numberController.text = null;
    passwordController.text = null;

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CreateAdmin();
    }));
  }

  void onButtonClick(String btn) {
    setState(() {
      if (_formKey.currentState.validate()) {
        if (btn == 'admin') {
          DBHelperAdmin dbHelper = DBHelperAdmin();
          var result = dbHelper.adminLogin(
              numberController.text, passwordController.text);
          result.then((onValue) {
            if (onValue != null) {
              saveData(Admin.fromMap(onValue[0]));
              Fluttertoast.showToast(
                  msg: 'Login Successfull!',
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.white,
                  textColor: Colors.pinkAccent);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                this.admin = Admin.fromMap(onValue[0]);
                return AdminLogin(admin.number);
              }));
            } else {
              Fluttertoast.showToast(
                  msg: 'Account Does not exist!',
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.white,
                  textColor: Colors.pinkAccent);
            }
          });
        } else if (btn == 'rep') {
          DBHelper dbHelper = DBHelper();
          var result =
              dbHelper.repLogin(numberController.text, passwordController.text);
          result.then((onValue) {
            if (onValue != null) {
              saveDataRep(Admin.fromMap(onValue[0]));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                var convert = Admin.fromMap(onValue[0]);
                return RepLogin(convert.number);
              }));
            } else {
              Fluttertoast.showToast(
                  msg: 'Account Does not exist!',
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: Colors.white,
                  textColor: Colors.pinkAccent);
            }
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    loadData().then((onValue) {
      if (onValue != null) {
        DBHelperAdmin dbHelper = DBHelperAdmin();
        var result = dbHelper.adminLogin(onValue.number, onValue.password);
        result.then((onValue) {
          if (onValue != null) {
            Fluttertoast.showToast(
                msg: 'Login Successfull!',
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.white,
                textColor: Colors.pinkAccent);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              this.admin = Admin.fromMap(onValue[0]);
              return AdminLogin(admin.number);
            }));
          }
        });
      }
      return Fluttertoast.showToast(
          msg: 'Welcome', toastLength: Toast.LENGTH_SHORT);
    });

    loadDataRep().then((onValue) {
      if (onValue != null) {
        DBHelper dbHelper = DBHelper();
        var result = dbHelper.repLogin(onValue.number, onValue.password);
        result.then((onValue) {
          if (onValue != null) {
            Fluttertoast.showToast(
                msg: 'Login Successfull!',
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.white,
                textColor: Colors.pinkAccent);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              var convert = Admin.fromMap(onValue[0]);
              return RepLogin(convert.number);
            }));
          }
        });
      }
      return Fluttertoast.showToast(
          msg: 'Welcome', toastLength: Toast.LENGTH_SHORT);
    });
  }

  Future<bool> saveData(Admin admin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('login', json.encode(admin.toMap()));
  }

  Future<bool> saveDataRep(Admin admin) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString('rep', json.encode(admin.toMap()));
  }

  Future<Admin> loadDataRep() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String result = await preferences.getString('rep');
    if(result != null)
    return Admin.fromMap(await json.decode(result));
  }

  Future<Admin> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String result = await preferences.getString('login');
    if(result != null)
    return Admin.fromMap(await json.decode(result));
  }
}
