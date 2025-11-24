class LocationModel {
  final String id;
  final String governorate;
  final String city;
  final String phoneNumber;
  LocationModel({
    required this.id,
    required this.governorate,
    required this.city,
    required this.phoneNumber,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'governorate': governorate,
      'city': city,
      'phoneNumber': phoneNumber,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? '',
      governorate: json['governorate'] ?? '',
      city: json['city'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }
}
