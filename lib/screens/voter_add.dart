import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voters/Database/DBHelperVoters.dart';
import 'package:voters/model/Voter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VoterAdd extends StatefulWidget {

String representativeNumber;

 VoterAdd(this.representativeNumber);

  @override
  State<StatefulWidget> createState() {
    return VoterAddState(representativeNumber);
  }
}

class VoterAddState extends State {

  String repnumber;

  VoterAddState(this.repnumber);


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var mobileController = TextEditingController();
  var ageController = TextEditingController();
  var addressController = TextEditingController();
  var boothController = TextEditingController();
  var villageController = TextEditingController();
  var mandalController = TextEditingController();
  var districtController = TextEditingController();
  var assemblyController = TextEditingController();

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
                                    else if(value.length != 10){
                                      return 'Please Enter 10 Digits';
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

                                  }
                                        else if(value.length > 2)
                                          return 'Please Enter only two digits';
                                          },
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
                                          if(value.length >2)
                                            return 'Enter only two digits';
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
        );
  }

  void onButtonClick() {

    String name, number, address, village, mandal, district, constituency;
    int age,booth;

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
        dbHelper.addNewContact(Voter(name,number,age,address,booth,village,mandal,district,constituency,repnumber));
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
