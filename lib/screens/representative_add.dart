import 'package:flutter/material.dart';
import 'package:voters/Database/DBHelperRepresentatives.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:voters/model/Admin.dart';

class AddRep extends StatefulWidget {
  String number;

  AddRep(this.number);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RepAddState(number);
  }
}

class RepAddState extends State<AddRep> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String repNumber;

  RepAddState(this.repNumber);

  String name, number, password;

  var nameController = TextEditingController();
  var numberController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Add Representative",
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
                            if (value.isEmpty) return 'Please Enter your Name*';
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
                            if (value.isEmpty)
                              return 'Please Enter your Number*';
                            else if(value.length != 10)
                              return 'Enter 10 digit mobile number';
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
                            if (value.isEmpty)
                              return 'Please Enter your password*';
                            else if(value.length <5)
                              return 'Password must have than 5 characters';
                          },
                        )),
                    Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(top: 10),
                        height: 45,
                        width: 140,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.pinkAccent, Colors.purple],
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
                        )),
                  ]),
                ))
          ],
        )));
  }

  void submitContact() {
    if (_formKey.currentState.validate()) {
      this.name = nameController.text;
      this.number = numberController.text;
      this.password = passwordController.text;
    } else {
      return null;
    }

    var dbHelper = DBHelper();
    dbHelper.addNewContact(Admin(name, number, password, repNumber));
    Fluttertoast.showToast(
        msg: 'Successfully Added Representative',
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        textColor: Colors.pinkAccent);

    Navigator.pop(context);
  }
}
