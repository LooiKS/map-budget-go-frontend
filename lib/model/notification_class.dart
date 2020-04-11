class Notifications {
  final String title;
  final bool status;
  final String time;
  final String username;

  Notifications(this.title, this.status, this.time, this.username);

  String getTitle() => title;
  bool getStatus() => status;
  String getTime() => time;
  String getUsername() => username;

  void setTitle(String title) => title = title;
  void setStatus(bool status) => status = status;
  void setTime(String time) => time = time;
  void setUsername(String username) => username = username;
}
