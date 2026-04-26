// package:sakan/features/auth/sign_up/models/profile_model.dart

class ProfileModel {
  final String id;
  final String fullName;
  final String role;
  final String phone;
  final bool isPaid;
  final DateTime createdAt;
  final String? imageUrl;
  final String? collegeId;           // ← الإضافة الجديدة

  ProfileModel({
    required this.id,
    required this.fullName,
    required this.role,
    required this.phone,
    required this.isPaid,
    required this.createdAt,
    this.imageUrl,
    this.collegeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'role': role,
      'phone': phone,
      'is_paid': isPaid,
      'created_at': createdAt.toUtc().toIso8601String(),
      if (imageUrl != null) 'image_url': imageUrl,
      if (collegeId != null) 'college_id': collegeId,    // ← فقط لو موجود
    };
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      isPaid: json['is_paid'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      imageUrl: json['image_url'] as String?,
      collegeId: json['college_id'] as String?,
    );
  }
}