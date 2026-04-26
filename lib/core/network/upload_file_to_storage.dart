import 'dart:developer';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:sakan/core/di/dependancy_injection.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<String?> uploadFileToSupabaseStorage({
  required File file,
  required String bucketName,
}) async {
  try {
    final fileName = "images/${const Uuid().v4()}.jpg";
    await getIt<SupabaseClient>().storage.from(bucketName).upload(fileName, file);
    return getIt<SupabaseClient>().storage.from(bucketName).getPublicUrl(fileName);
  } on Exception catch (e) {
    log('Upload error: $e');
    return null;
  }
}
