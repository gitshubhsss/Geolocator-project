class LocationModel {
  final int? id;
  final String latitude;
  final String longitude;

  // Constructor
  LocationModel({
    this.id,
    required this.latitude,
    required this.longitude,
  });

  // Factory method to create a LocationModel from a JSON map
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'], // SQLite often uses an `id` column as the primary key
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  // Method to convert a LocationModel to a JSON map
  Map<String, dynamic> toJson() {
    final map = {
      'latitude': latitude,
      'longitude': longitude,
    };
    if (id != null) {
      map['id'] = id as String;
    }
    return map;
  }
}
