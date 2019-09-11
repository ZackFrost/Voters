
class Voter{
  int _id;
  String _name;
  String _mobilenumber;
  int _age;
  String _address;
  int _booth;
  String _village;
  String _mandal;
  String _district;
  String _constituency;
  String _repnumber;

  Voter(this._name ,this._mobilenumber, this._age, this._address, this._booth,
      this._village, this._mandal, this._district, this._constituency,
      this._repnumber);


  String get name => _name;

  set name(String value) {
    _name = value;
  }

  Voter.fromMap(Map<String,dynamic> map){
    this._id = map['id'];
    this._name = map['name'];
    this._mobilenumber = map['mobilenumber'];
    this._age = map['age'];
    this._address = map['address'];
    this._booth = map['booth'];
    this._village = map['village'];
    this._mandal = map['mandal'];
    this._district = map['district'];
    this._constituency = map['constituency'];
    this._repnumber = map['repnumber'];
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'name': this._name,
      'mobilenumber': this._mobilenumber,
      'age' :  this._age,
      'address' : this._address,
      'booth' : this._booth,
      'village' : this._village,
      'mandal' : this._mandal,
      'district' : this._district,
      'constituency' : this._constituency,
      'repnumber': this._repnumber,
    };
  }

  String get repnumber => _repnumber;

  set repnumber(String value) {
    _repnumber = value;
  }

  String get constituency => _constituency;

  set constituency(String value) {
    _constituency = value;
  }

  String get district => _district;

  set district(String value) {
    _district = value;
  }

  String get mandal => _mandal;

  set mandal(String value) {
    _mandal = value;
  }

  String get village => _village;

  set village(String value) {
    _village = value;
  }

  int get booth => _booth;

  set booth(int value) {
    _booth = value;
  }

  String get address => _address;

  set address(String value) {
    _address = value;
  }

  int get age => _age;

  set age(int value) {
    _age = value;
  }

  String get mobilenumber => _mobilenumber;

  set mobilenumber(String value) {
    _mobilenumber = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }


}