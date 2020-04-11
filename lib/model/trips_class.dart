class Trips {
  final String tripTitle;
  final String tripDetail;

  Trips(this.tripTitle, this.tripDetail);

  String getTripTitle() => tripTitle;
  String getTripDetail() => tripDetail;

  void setTripTitle(String tripTitle) => tripTitle = tripTitle;
  void setTripDetail(String tripDetail) => tripDetail = tripDetail;
}
