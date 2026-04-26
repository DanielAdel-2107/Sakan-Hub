import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';

class BookingRequestModel {
  final String? id;
  final String apartmentId;
  final String studentId;
  final String status; // 'pending', 'approved', 'rejected'
  final DateTime? createdAt;
  final ApartmentModel? apartment;

  BookingRequestModel({
    this.id,
    required this.apartmentId,
    required this.studentId,
    required this.status,
    this.createdAt,
    this.apartment,
  });

  factory BookingRequestModel.fromJson(Map<String, dynamic> json) {
    return BookingRequestModel(
      id: json['id'],
      apartmentId: json['apartment_id'],
      studentId: json['student_id'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      apartment: json['apartments'] != null
          ? ApartmentModel.fromJson(json['apartments'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'apartment_id': apartmentId,
      'student_id': studentId,
      'status': status,
    };
  }
}
