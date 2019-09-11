import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voters/Database/DBHelperRepresentatives.dart';
import 'package:voters/Database/DBHelperVoters.dart';
import 'package:voters/model/Voter.dart';
import 'package:voters/screens/login_page.dart';
import 'package:voters/screens/representative_add.dart';
import 'package:voters/model/Admin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:voters/screens/edit_rep.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminLogin extends StatefulWidget {
  String adminNumber;

  AdminLogin(this.adminNumber);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AdminState(adminNumber);
  }
}

class AdminState extends State<AdminLogin> {

  bool showRep = true;
  bool showFab = true;
  String repnumber;

  Future<List<Admin>> getContactsFromDB() async {
    var dbHelper = DBHelper();
    Future<List<Admin>> contacts = dbHelper.getContacts(this.adminNumber);
    return contacts;
  }

  Future<List<Voter>> getVotersFromDB() async {
    DBHelper1 dbHelper = DBHelper1();
    Future<List<Voter>> contacts = dbHelper.getContacts(this.repnumber);
    return contacts;
  }

  String name, number;
  String adminNumber;
  var users = ['Representatives','Voters'];
  String currentListItem = 'Representatives';

  AdminState(this.adminNumber);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 15),
                child: GestureDetector(
                  child: Icon(
                    Icons.power_settings_new,
                    color: Colors.white,
                    size: 25,
                  ),
                  onTap: () {
                    onLogout();
                  },
                ))
          ],
          title: Text(
            "Admin Home",
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
      body:Column(children: <Widget>[
          Card(
            elevation: 7,
            borderOnForeground: true,
            margin: EdgeInsets.all(10),
              child:DropdownButtonHideUnderline(
                  child:Padding(
                    padding: EdgeInsets.only(left: 0),
                    child:ButtonTheme(
                        alignedDropdown: true,
                        child:DropdownButton<String>(
                      isExpanded: true,
                      items: users.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (String valueSelected) {
                        setState(() {
                          this.currentListItem = valueSelected;
                          if(valueSelected == 'Voters')
                          {
                            showRep = false;
                            showFab = false;
                          }
                          else{
                            showRep = true;
                            showFab = true;
                          }
                        });
                      },
                      value: currentListItem,
                    )
                  )
                  )
              ),

          ),
        if (showRep)
        showRepresentatives(),
        if(!showRep)
          showRepVoters()
        ]),
        floatingActionButton:
        Visibility(
          visible: showFab,
          child:FloatingActionButton(
            child:
            Icon(Icons.add),
            backgroundColor: Colors.pinkAccent,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AddRep(adminNumber);
              }));
            },
          ),
        )
    );
  }

  void delete(int id) {
    setState(() {
      var helper = DBHelper();
      helper.deleteContact(id);
      Fluttertoast.showToast(
          msg: 'Successfully Deleted',
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.pinkAccent,
          backgroundColor: Colors.white);
    });
  }

  Future onLogout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return loginPage();
    }));
  }

 Widget showRepresentatives() {

    return Expanded(
      child: Container(
          child:FutureBuilder<List<Admin>>(
            future: getContactsFromDB(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                     this.repnumber = snapshot.data[0].number;
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
                                    subtitle: Text(snapshot.data[index].number),
                                    trailing: GestureDetector(
                                      child: Icon(
                                        Icons.delete,
                                        size: 30,
                                        color: Colors.pinkAccent,
                                      ),
                                      onTap: () {
                                        delete(snapshot.data[index].id);
                                      },
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                          return EditPage(
                                              snapshot.data[index].id,
                                              snapshot.data[index].name,
                                              snapshot.data[index].number,
                                              snapshot.data[index].password);
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
          )),
    );
  }

 Widget showRepVoters() {
   return Expanded(
     child: Container(
         child:FutureBuilder<List<Voter>>(
           future: getVotersFromDB(),
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
                                 ),
                                 onTap: () {
//                                   Navigator.push(context,
//                                       MaterialPageRoute(builder: (context) {
//                                         return EditPage(
//                                             snapshot.data[index].id,
//                                             snapshot.data[index].name,
//                                             snapshot.data[index].number,
//                                             snapshot.data[index].password);
//                                       }));
                                 },
                               ),
                             )
                           ],
                         ));
                   });
             }
             //shows loading while snapshot is not fetching data
            return Container(
              color: Colors.white,
            );
           },
         )),
   );

  }

}
