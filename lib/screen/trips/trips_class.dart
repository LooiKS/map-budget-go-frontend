class Trips {
  final String tripTitle;
  final String expensesTitle;

  Trips(this.tripTitle, this.expensesTitle);

  String getTripTitle() => tripTitle;
  String getExpensesTitle() => expensesTitle;

  void setTripTitle(String tripTitle) => tripTitle = tripTitle;
  void setExpensesTitle(String expensesTitle) => expensesTitle = expensesTitle;
}
