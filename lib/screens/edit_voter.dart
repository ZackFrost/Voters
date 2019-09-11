import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:voters/Database/DBHelperVoters.dart';
import 'package:voters/model/Voter.dart';

class editVoter extends StatefulWidget{

  Voter voter;

  editVoter(this.voter);

  @override
  State<StatefulWidget> createState() {

    return editVoterState(voter);
  }


}

class editVoterState extends State<editVoter>{

  Voter voter;

  editVoterState(this.voter);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController boothController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController mandalController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController assemblyController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Add Voter",
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
                    child: Column(
                      children: <Widget>[
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
                                if(value.isEmpty){
                                  return 'Please Enter your Name*';
                                }
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
                              controller: mobileController,
                              validator: (value) {
                                if(value.isEmpty){
                                  return 'Please Enter your Number*';
                                }
                              },
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Age*',
                                  hintText: 'Enter your Age*',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              controller: ageController,
                              validator: (value) {
                                if(value.isEmpty){
                                  return 'Please Enter your Age*';
                                }},
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Address',
                                  hintText: 'Enter your Address',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              controller: addressController,
                            )),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child:  Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Polling Booth No*',
                                        hintText: 'Enter your Booth No*',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        )),
                                    controller: boothController,
                                    validator: (value) {
                                      if(value.isEmpty)
                                        return 'Please Enter your Booth No*';
                                    },
                                  )),
                            ),
                            Container(
                              width: 15,
                            ),
                            Expanded(
                                child:  Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Village/Town',
                                        hintText: 'Enter your Village/Town',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        )),
                                    controller: villageController,
                                    validator: (value) {
                                      if(value.isEmpty)
                                        return 'Please Enter your Village/Town';
                                    },
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child:  Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        labelText: 'Mandal',
                                        hintText: 'Enter your Mandal',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(5),
                                        )),
                                    controller: mandalController,
                                  )),
                            ),
                            Container(
                              width: 15,
                            ),
                            Expanded(
                              child:  Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'District',
                                      hintText: 'Enter your District',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(5),
                                      )),
                                  controller: districtController,
                                ),
                              ),),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Assembly Constituency*',
                                  hintText: 'Enter Assembly Constituency*',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )),
                              controller: assemblyController,
                              validator: (value) {
                                if(value.isEmpty)
                                  return 'Please Enter Assembly Constituency*';
                              },
                            )),
                        Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.only(top: 10),
                            height: 40,
                            width: 120,
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
                                  textScaleFactor: 1,
                                ),
                              ),
                              onTap: () {
                                onButtonClick();
                              },
                            )
                        ),
                      ],
                    )),
              ),
            ],
          )),
    );;
  }



  @override
  void initState() {
    super.initState();

    nameController.text = voter.name;
    mobileController.text = voter.mobilenumber;
    ageController.text = voter.age.toString();
    addressController.text = voter.address;
    boothController.text = voter.booth.toString();
    villageController.text = voter.village;
    mandalController.text = voter.mandal;
    districtController.text = voter.district;
    assemblyController.text = voter.constituency;
  }

  void onButtonClick() {

    String name, number, address, village, mandal, district, constituency;
    int age,booth;

    String repNumber = voter.repnumber;
    name = nameController.text;
    number = mobileController.text;
    age = int.parse(ageController.text);
    address = addressController.text;
    booth = int.parse(boothController.text);
    village = villageController.text;
    mandal = mandalController.text;
    district = districtController.text;
    constituency = assemblyController.text;

    setState(() {
      if (_formKey.currentState.validate()) {
        var dbHelper = DBHelper1();
        dbHelper.editContact(Voter(name,number,age,address,booth,village,mandal,district,constituency,repNumber));
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