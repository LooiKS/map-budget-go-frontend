class User {
  String id;
  String firstName;
  String lastName;
  String phoneNum;
  String email;
  String profilePic;
  String username;
  List<User> friend;
  String gender;
  bool isChecked;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNum,
      this.email,
      this.profilePic,
      this.username,
      this.gender,
      this.isChecked,
      this.friend});

  User.copy(User from)
      : this(
            id: from.id,
            firstName: from.firstName,
            lastName: from.lastName,
            phoneNum: from.phoneNum,
            email: from.email,
            profilePic: from.profilePic,
            username: from.username,
            gender: from.gender,
            isChecked: from.isChecked,
            friend: [...from.friend]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNum": phoneNum,
        "email": email,
        "profilePic": profilePic,
        "username": username,
        "friend": friend == null ? null : friend.map((f) => f.id).toList(),
        "gender": gender,
        "isChecked": isChecked,
      };

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json["id"],
          firstName: json["firstName"],
          lastName: json["lastName"],
          phoneNum: json["phoneNum"],
          email: json["email"],
          profilePic: json["profilePic"],
          username: json["username"],
          gender: json["gender"],
          isChecked: json["isChecked"] == "true" ? true : false,
          friend: json["friend"].map<User>((f) => User.fromJson(f)).toList(),
        );

  String get _id => this.id;
  String get _firstName => this.firstName;
  String get _lastName => this.lastName;
  String get _phoneNum => this.phoneNum;
  String get _email => this.email;
  String get _profilePic => this.profilePic;
  String get _username => this.username;
  List<User> get _friend => this.friend;
  String get _gender => this.gender;
  bool get _isChecked => this.isChecked;

  set _id(String newValue) => this.id = newValue;
  set _firstName(String newValue) => this.firstName = newValue;
  set _phoneNum(String newValue) => this.phoneNum = newValue;
  set _email(String newValue) => this.email = newValue;
  set _profilePic(String newValue) => this.profilePic = newValue;
  set _username(String newValue) => this.username = newValue;
  set _friend(List<User> newValue) => this.friend = newValue;
  set _gender(String newValue) => this.gender = newValue;
  set _isChecked(bool newValue) => this.isChecked = newValue;
}
