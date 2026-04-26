import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';

class MyBookingModel {
  final String id;
  final String apartmentId;
  final String studentId;
  final String status;
  final DateTime createdAt;
  final ApartmentModel apartment;

  MyBookingModel({
    required this.id,
    required this.apartmentId,
    required this.studentId,
    required this.status,
    required this.createdAt,
    required this.apartment,
  });

  factory MyBookingModel.fromJson(Map<String, dynamic> json) {
    return MyBookingModel(
      id: json['id'],
      apartmentId: json['apartment_id'],
      studentId: json['student_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      apartment: ApartmentModel.fromJson(json['apartments']),
    );
  }
}
