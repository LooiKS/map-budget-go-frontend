class User {
  String _id;
  String _firstName;
  String _lastName;
  String _phoneNum;
  String _email;
  String _profilePic;
  String _username;
  String _password;
  bool _isChecked;

  User(this._id, this._firstName, this._lastName, this._phoneNum, this._email,
      this._profilePic, this._username,this._password,this._isChecked);

  String get id => this._id;
  String get firstName => this._firstName;
  String get lastName => this._lastName;
  String get phoneNum => this._phoneNum;
  String get email => this._email;
  String get profilePic => this._profilePic;
  String get username => this._username;
  String get password => this._password;
  bool get isChecked => this._isChecked;

  set id(String newValue) => this._id = newValue;
  set firstName(String newValue) => this._firstName = newValue;
  set lastName(String newValue) => this._lastName = newValue;
  set phoneNum(String newValue) => this._phoneNum = newValue;
  set email(String newValue) => this._email = newValue;
  set profilePic(String newValue) => this._profilePic = newValue;
  set username(String newValue) => this._username = newValue;
  set password(String newValue) => this._password = newValue;
  set isChecked(bool newValue) => this._isChecked = newValue;
}