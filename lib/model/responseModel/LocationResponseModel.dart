class LocationResponse {
  final String status;
  final String message;
  final Driver driver;

  const LocationResponse({
    required this.status,
    required this.message,
    required this.driver,
  });

  // Factory method to create an instance from JSON
  factory LocationResponse.fromJson(Map<String, dynamic> json) {
    return LocationResponse(
      status: json['status'],
      message: json['message'],
      driver: Driver.fromJson(json['driver']),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'driver': driver.toJson(),
    };
  }
}

class Driver {
  final String name;
  final String phoneMobile;
  final String emailAddress;
  final String status;

  const Driver({
    required this.name,
    required this.phoneMobile,
    required this.emailAddress,
    required this.status,
  });

  // Factory method to create an instance from JSON
  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      name: json['name'],
      phoneMobile: json['phone_mobile'],
      emailAddress: json['email_address'],
      status: json['status'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_mobile': phoneMobile,
      'email_address': emailAddress,
      'status': status,
    };
  }
}
