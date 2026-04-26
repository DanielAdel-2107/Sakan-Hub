class UniversityModel {
  final String id;
  final String name;
  final double? lat;
  final double? lng;

  UniversityModel({
    required this.id,
    required this.name,
    this.lat,
    this.lng,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      id: json['id'],
      name: json['name'],
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }
}
