import 'package:sakan/features/student/home/apartment/models/owner_model.dart';

class ApartmentModel {
  final String id;
  final String ownerId;
  final Owner owner;               // ← الإضافة الجديدة
  final String title;
  final String description;
  final double price;
  final double lat;
  final double lng;
  final bool isAvailable;
  final List<String> imageUrls;
  final double distance;
  final bool isFavorite;

  ApartmentModel({
    required this.id,
    required this.ownerId,
    required this.owner,
    required this.title,
    required this.description,
    required this.price,
    required this.lat,
    required this.lng,
    required this.isAvailable,
    required this.imageUrls,
    required this.distance,
    this.isFavorite = false,
  });

  factory ApartmentModel.fromJson(
    Map<String, dynamic> json, [
    double? calculatedDistance,
  ]) {
    final imagesFromJoin = json['apartment_images'] as List<dynamic>? ?? [];
    final urls = imagesFromJoin
        .map((img) => img['image_url'] as String)
        .toList();
    final ownerJson = json['profiles'] as Map<String, dynamic>?;
    final owner = ownerJson != null
        ? Owner.fromJson(ownerJson)
        : Owner(id: json['owner_id'] as String, fullName: 'غير معروف', isPaid: false);

    return ApartmentModel(
      id: json['id'] as String,
      ownerId: json['owner_id'] as String,
      owner: owner,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
      isAvailable: json['is_available'] as bool? ?? true,
      imageUrls: urls,
      distance: calculatedDistance ?? 0.0,
      isFavorite: json['is_favorite'] ?? false,
    );
  }

  // copyWith لو محتاجه (نعدله كمان)
  ApartmentModel copyWith({
    String? id,
    String? ownerId,
    Owner? owner,
    String? title,
    String? description,
    double? price,
    double? lat,
    double? lng,
    bool? isAvailable,
    List<String>? imageUrls,
    double? distance,
    bool? isFavorite,
  }) {
    return ApartmentModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      owner: owner ?? this.owner,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isAvailable: isAvailable ?? this.isAvailable,
      imageUrls: imageUrls ?? this.imageUrls,
      distance: distance ?? this.distance,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

