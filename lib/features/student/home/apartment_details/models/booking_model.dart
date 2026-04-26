class BookingModel {
  final String? id;
  final String apartmentId;
  final String studentId;
  final String status;
  final DateTime? createdAt;

  BookingModel({
    this.id,
    required this.apartmentId,
    required this.studentId,
    required this.status, // حالة افتراضية
    this.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      apartmentId: json['apartment_id'],
      studentId: json['student_id'],
      status: json['status'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  // تحويل إلى Map للإرسال إلى Supabase
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'apartment_id': apartmentId,
      'student_id': studentId,
      'status': status,
    };
  }
}
