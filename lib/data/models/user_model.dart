import 'package:unj_digital_test/data/models/company_model.dart';
import 'package:unj_digital_test/data/models/geo_location_model.dart';

class UserModel {
  static const String keyId = 'id';
  static const String keyName = 'name';
  static const String keyEmail = 'email';
  static const String keyPhone = 'phone';
  static const String keyAddress = 'address';
  static const String keyCompany = 'company';
  static const String keyWebsite = 'website';
  static const String keyUsername = 'username';
  static const String keyGeoLocation = 'geo_location';

  final int id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final Company? company;
  final String? website;
  final String? username;
  final GeoLocation? geoLocation;

  UserModel({
    this.id = 0,
    required this.name,
    required this.email,
    required this.phone,
    this.address = '',
    this.company,
    this.website,
    this.username,
    this.geoLocation,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[keyId] ?? 0,
      name: json[keyName] ?? '',
      email: json[keyEmail] ?? '',
      phone: json[keyPhone] ?? '',
      address: json[keyAddress] ?? '',
      company:
          json.containsKey(keyCompany)
              ? Company.fromJson(json[keyCompany])
              : null,
      website: json[keyWebsite],
      username: json[keyUsername],
      geoLocation:
          json.containsKey(keyGeoLocation)
              ? GeoLocation.fromJson(json[keyGeoLocation])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      keyId: id,
      keyName: name,
      keyEmail: email,
      keyPhone: phone,
      keyAddress: address,
    };
    if (company != null) {
      map[keyCompany] = company!.toJson();
    }
    if (website != null) {
      map[keyWebsite] = website;
    }
    if (username != null) {
      map[keyUsername] = username;
    }
    if (geoLocation != null) {
      map[keyGeoLocation] = geoLocation!.toJson();
    }
    return map;
  }

  factory UserModel.empty() {
    return UserModel(
      id: 0,
      name: '',
      email: '',
      phone: '',
      address: '',
      company: null,
      website: null,
      username: null,
      geoLocation: null,
    );
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    Company? company,
    String? website,
    String? username,
    GeoLocation? geoLocation,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      company: company ?? this.company,
      website: website ?? this.website,
      username: username ?? this.username,
      geoLocation: geoLocation ?? this.geoLocation,
    );
  }
}
