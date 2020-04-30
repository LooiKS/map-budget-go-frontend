class Users {
  String userName;
  String imageURL;
  bool isChecked;

  Users(this.userName, this.imageURL,this.isChecked);
  Users.copy(Users from) : this(from.userName, from.imageURL,from.isChecked);
}
