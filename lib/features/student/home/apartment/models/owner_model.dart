class Owner {
  final String id;
  final String fullName;
  final String? phone;
  final String? imageUrl;
  final bool isPaid;

  Owner({
    required this.id,
    required this.fullName,
    this.phone,
    this.imageUrl,
    required this.isPaid,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      id: json['id'] as String,
      fullName: json['full_name'] as String? ?? 'غير معروف',
      phone: json['phone'] as String?,
      imageUrl: json['image_url'] as String?,
      isPaid: json['is_paid'] as bool? ?? false,
    );
  }
}