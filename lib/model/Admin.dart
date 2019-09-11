
class Admin{

  int _id;
  String _name;
  String _number;
  String _password;
  String _adminNumber;


  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get adminNumber => _adminNumber;

  set adminNumber(String value) {
    _adminNumber = value;
  }

  Admin.admin(this._name,this._number,this._password);
  Admin(this._name,this._number,this._password,this._adminNumber);

  Map<String, dynamic> toMapAdmin() {
    return <String, dynamic>{
      'name': this._name,
      'number': this._number,
      'password': this._password,
    };
  }

  Admin.fromMap(Map<String,dynamic> map){
    this._id = map['id'];
    this._name = map['name'];
    this._number = map['number'];
    this._password = map['password'];
    this._adminNumber = map['adminNumber'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': this._name,
      'number': this._number,
      'password': this._password,
      'adminNumber': this._adminNumber,
    };
  }



  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get number => _number;

  set number(String value) {
    _number = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }



}