class TripExpenses {
  final String title;
  final String dateTime;
  final String amount;
  final String payBy;

  TripExpenses(this.title, this.dateTime, this.amount, this.payBy);
  

  String getTitle() => title;
  String getDateTime() => dateTime;
  String getAmount() => amount;
  String getPayBy() => payBy;

  void setTitle(String title) => title = title;
  void setDateTime(String dateTime) => dateTime = dateTime;
  void setAmount(String amount) => amount = amount;
  void setPayBy(String payBy) => payBy = payBy;
}
