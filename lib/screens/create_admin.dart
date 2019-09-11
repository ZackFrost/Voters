import 'package:flutter/material.dart';
import 'package:voters/Database/DBHelperAdmin.dart';
import 'package:voters/model/Admin.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CreateAdminState();
  }
}

class CreateAdminState extends State<CreateAdmin> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Create Account",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [ Colors.pinkAccent,
                      Colors.purple],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
            )),
        body: Container(
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
                                  labelText: 'Name*',
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
                                  labelText: 'Mobile Number*',
                                  hintText: 'Enter your Number*',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              controller: numberController,
                              validator: (value) {
                                if(value.isEmpty)
                                  return 'Please Enter your Number*';
                                else if(value.length != 10)
                                  return 'Please Enter 10 digits';
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: 'Password*',
                                  hintText: 'Enter your Password*',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              controller: passwordController,
                              validator: (value) {
                                if(value.isEmpty){
                                  return 'Please Enter your password*';
                                }
                                else if(value.length <5){
                                  return 'Please enter more than 5 characters';
                                }

                              }
                              ,
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
                                  'Submit',
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
              ],
            )));
  }

  void submitContact() {

    setState(() {
      if (_formKey.currentState.validate()) {
        var dbHelper = DBHelperAdmin();
        dbHelper.addNewContact(Admin.admin( nameController.text,numberController.text,passwordController.text));
        Fluttertoast.showToast(
            msg: 'Successfully Created',
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.white,
            textColor: Colors.pinkAccent);

        Navigator.pop(context);
      }


    });


  }

}
