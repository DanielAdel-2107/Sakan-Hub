class OwnerRequestItem {
  final Map<String, dynamic> apartment;
  final Map<String, dynamic> booking;
  final Map<String, dynamic> student;

  OwnerRequestItem.fromJson(Map<String, dynamic> json)
    : apartment = json['apartment'] as Map<String, dynamic>? ?? {},
      booking = json['booking'] as Map<String, dynamic>? ?? {},
      student = json['student'] as Map<String, dynamic>? ?? {};

  String get status =>
      (booking['status'] as String?)?.toLowerCase() ?? 'pending';

  DateTime? get createdAt => booking['created_at'] != null
      ? DateTime.tryParse(booking['created_at'] as String)
      : null;

  List<String> get apartmentImages =>
      (apartment['images'] as List?)?.cast<String>() ?? [];

  String? get mainImage =>
      apartmentImages.isNotEmpty ? apartmentImages.first : null;
}
