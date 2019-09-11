import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voters/Database/DBHelperVoters.dart';
import 'package:voters/model/Admin.dart';
import 'package:voters/model/Voter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:voters/screens/voter_add.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_voter.dart';
import 'login_page.dart';

class RepLogin extends StatefulWidget {

  //Object recieved from loginpage
  String contact;

  @override
  State<StatefulWidget> createState() {
    return RepLoginState(this.contact);
  }
  //constructor
  RepLogin(this.contact);
}

class RepLoginState extends State<RepLogin> {


  Future<List<Voter>> getContactsFromDB() async {
    DBHelper1 dbHelper = DBHelper1();
    Future<List<Voter>> contacts = dbHelper.getContacts(result);
    return contacts;
  }

  String result;

  //constructor
  RepLoginState(this.result);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 15),
                child: GestureDetector(
                  child:Icon(Icons.power_settings_new,color: Colors.white,size: 25,),
                  onTap: (){
                    onLogout();
                  },
                )
            )
          ],
          title: Text(
            "Representative Home",
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
      body:Container(
        child: FutureBuilder<List<Voter>>(
          future: getContactsFromDB(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 5.0,
                        color: Colors.white,
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: GestureDetector(
                                child: ListTile(
                                  title: Text(
                                    snapshot.data[index].name,
                                    textScaleFactor: 1.1,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  subtitle: Text(snapshot.data[index].village),
                                  trailing: GestureDetector(
                                    child: Icon(Icons.delete,size: 30,color: Colors.pinkAccent,),
                                    onTap: (){
                                      delete(snapshot.data[index].id);
                                    },
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                        return editVoter(snapshot.data[0]);
                                      }));
                                },
                              ),
                            )
                          ],
                        ));
                  });
            }
            //shows loading while snapshot is not fetching data
            return Container(
              alignment: AlignmentDirectional.center,
              child: CircularProgressIndicator(
                backgroundColor: Colors.pinkAccent,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return VoterAdd(result);
          }));
        },
        tooltip: 'Add Voter',
      ),
    );
  }

  void delete(int id){

    setState(() {
      var helper = DBHelper1();
      helper.deleteContact(id);
      Fluttertoast.showToast(msg: 'Successfully Deleted',toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.pinkAccent,backgroundColor: Colors.white);
    });

  }


  Future onLogout() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();

    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context){
          return loginPage();
        }
    ));
  }

}
