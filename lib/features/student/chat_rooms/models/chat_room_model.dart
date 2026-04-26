class ChatRoomModel {
  final String id;
  final String ownerId;
  final String? ownerFullName;
  final String? ownerAvatarUrl;
  final DateTime? createdAt;

  ChatRoomModel({
    required this.id,
    required this.ownerId,
    this.ownerFullName,
    this.ownerAvatarUrl,
    this.createdAt,
  });

  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    final ownerData = map['owner'] as Map<String, dynamic>?;

    return ChatRoomModel(
      id: map['id'],
      ownerId: map['owner_id'],
      ownerFullName: ownerData?['full_name'],
      ownerAvatarUrl: ownerData?['image_url'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
    );
  }

  String get displayName => ownerFullName ?? 'مالك الشقة';
  String get lastMessage => ''; // TODO: ربط بجدول messages لاحقاً
}