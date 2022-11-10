class Report {
  String id;
  double lat;
  double lng;
  int bitmap;
  String name;

  Report(this.id, this.lat, this.lng, this.bitmap, this.name);

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      json['_id'],
      json['lat'],
      json['lng'],
      //ToDo - change this to bitmap
      0,
      json['description'],
    );
  }
}
