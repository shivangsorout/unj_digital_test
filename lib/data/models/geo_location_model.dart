class GeoLocation {
  static const String keyLatitude = 'latitude';
  static const String keyLongitude = 'longitude';

  final String latitude;
  final String longitude;

  GeoLocation({required this.latitude, required this.longitude});

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      latitude: json[keyLatitude] ?? '',
      longitude: json[keyLongitude] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {keyLatitude: latitude, keyLongitude: longitude};
  }
}
