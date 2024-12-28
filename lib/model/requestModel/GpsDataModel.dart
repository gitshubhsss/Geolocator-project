class GpsData {
  final String driverId;
  final String mobile;
  final String latitude;
  final String longitude;
  final String status;

  // Constructor with required named parameters
  const GpsData({
    required this.driverId,
    required this.mobile,
    required this.latitude,
    required this.longitude,
    required this.status,
  });

  // Factory method to create an instance from JSON
  factory GpsData.fromJson(Map<String, dynamic> json) {
    return GpsData(
      driverId: json['driverId'],
      mobile: json['mobile'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      status: json['status'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'driverId': driverId,
      'mobile': mobile,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
    };
  }
}
