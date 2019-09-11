import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voters/Database/DBHelperRepresentatives.dart';
import 'package:voters/model/Admin.dart';




class EditPage extends StatefulWidget{
  String name, number,password;
  int id;

  @override
  State<StatefulWidget> createState() {

    return EditPageState(id,name,number,password);
  }

  EditPage(this.id,this.name,this.number,this.password);
}

class EditPageState extends State<EditPage>{

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String name, number,password;
  int id;

  EditPageState(this.id,this.name,this.number,this.password);

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
        title: Text(
        "Edit Representative",
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
              body: Center(
              child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  hintText: 'Enter your Name*',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              controller: nameController,
                              validator: (value) {
                                if(value.isEmpty)
                                  return 'Please Enter your Name*';
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Number',
                                  hintText: 'Enter your Number*',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              controller: numberController,
                              validator: (value) {
                                if(value.isEmpty)
                                  return 'Please Enter your Number*';
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  hintText: 'Enter your Password*',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              controller: passwordController,
                              validator: (value) {
                                if(value.isEmpty)
                                  return 'Please Enter your password*';
                              },
                            )),
                        Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(top: 10),
                            height: 45,
                            width: 140,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.pinkAccent,Colors.purple],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: GestureDetector(
                              child: Center(
                                child: Text(
                                  'Update',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textScaleFactor: 0.9,
                                ),
                              ),
                              onTap: () {
                                submitContact();
                              },
                            )
                        ),
                      ]),
                    ))


                ]
              )
              )
    );
  }

  submitContact(){

    setState(() {

      var dbHelper = DBHelper();
      String name = nameController.text;
      String number = numberController.text;
      String password = passwordController.text;

      if(_formKey.currentState.validate()){

        dbHelper.editContact(Admin(name,number,password,null));
        Fluttertoast.showToast(msg: 'Updated Successful');
      }
    });

  }

  @override
  void initState() {
    super.initState();

    nameController.text = name;
    numberController.text = number;
    passwordController.text = password;
  }
}