class BusModel {
  String busName = "";
  int busId = 0;
  int ownerId=0;
  int busRoute = 0;
  String busNumber = "";
  String busCurrentLocation = "";
  int startStop = 0;
  int endStop = 0;
  String startingTime = "";
  BusModel(this.busId, this.busName, this.ownerId,this.busRoute, this.busNumber,
      this.busCurrentLocation, this.startStop, this.endStop, this.startingTime);
}
