import 'dart:io';
import 'dart:convert';                    // ← أضفت ده
import 'package:sakan/features/auth/sign_up/models/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ← أضفت ده
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final _client = Supabase.instance.client;

  // ====================== SIGN UP (بدون تغيير) ======================
  Future<ProfileModel> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required String role,
    File? profileImage,
    String? collegeId,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );

      String? imageUrl;
      if (response.user == null) throw 'حدث خطأ في التسجيل';

      if (profileImage != null) {
        final fileName =
            '${response.user!.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        await _client.storage
            .from('profiles')
            .upload(fileName, profileImage);

        imageUrl = _client.storage.from('profiles').getPublicUrl(fileName);
      }

      final profile = ProfileModel(
        id: response.user!.id,
        fullName: fullName,
        role: role,
        phone: phone,
        isPaid: false,
        createdAt: DateTime.now(),
        collegeId: role == 'student' ? collegeId : null,
        imageUrl: imageUrl,
      );

      await _client.from('profiles').insert(profile.toJson());
      return profile;
    } catch (e) {
      throw e.toString();
    }
  }

  // ====================== LOGIN (محدث + حفظ في SharedPrefs) ======================
  Future<ProfileModel> login({
    required String email,
    required String password,
    required String requiredRole,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) throw 'خطأ في تسجيل الدخول';

      // جلب البيانات من جدول profiles
      final userData = await _client
          .from('profiles')
          .select()
          .eq('id', response.user!.id)
          .single();

      final profile = ProfileModel.fromJson(userData);

      // التحقق من الدور
      if (profile.role != requiredRole) {
        await _client.auth.signOut();
        throw 'wrong-role';
      }

      // ====================== حفظ في SharedPreferences ======================
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_profile', json.encode(profile.toJson()));

      return profile;
    } catch (e) {
      throw e.toString();
    }
  }
}

Future<ProfileModel?> getSavedProfile() async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString('user_profile');
  if (jsonString == null) return null;

  return ProfileModel.fromJson(json.decode(jsonString));
}