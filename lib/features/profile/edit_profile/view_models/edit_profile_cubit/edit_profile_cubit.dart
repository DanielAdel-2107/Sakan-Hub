import 'dart:io';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakan/features/profile/edit_profile/models/profile_model.dart';
import 'package:sakan/features/profile/edit_profile/models/university_model.dart';
import 'package:sakan/features/profile/edit_profile/view_models/edit_profile_cubit/edit_profile_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final SupabaseClient _supabase = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();
  
  File? profileImage;
  List<UniversityModel> universities = [];
  ProfileModel? currentProfile;

  EditProfileCubit() : super(EditProfileInitial());

  Future<void> fetchProfile() async {
    emit(EditProfileLoading());
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        emit(EditProfileError("User not logged in"));
        return;
      }

      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      currentProfile = ProfileModel.fromJson(data);
      
      if (currentProfile!.role == 'student') {
        await fetchUniversities();
      }
      
      emit(EditProfileSuccess(currentProfile!));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  Future<void> fetchUniversities() async {
    try {
      final data = await _supabase
          .from('universities')
          .select()
          .order('name', ascending: true);

      universities = data.map<UniversityModel>((json) => UniversityModel.fromJson(json)).toList();
      emit(UniversitiesLoaded(universities));
    } catch (e) {
      print('Failed to fetch universities: $e');
    }
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        profileImage = File(image.path);
        emit(EditProfileSuccess(currentProfile!)); // Trigger UI update to show local image
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> updateProfile({
    required String fullName,
    required String phone,
    String? collegeId,
  }) async {
    emit(ProfileUpdateLoading());
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw 'User not found';

      String? imageUrl = currentProfile?.imageUrl;

      if (profileImage != null) {
        final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        await _supabase.storage
            .from('profiles')
            .upload(fileName, profileImage!);

        imageUrl = _supabase.storage.from('profiles').getPublicUrl(fileName);
      }

      final updatedProfileMap = {
        'full_name': fullName,
        'phone': phone,
        'image_url': imageUrl,
        if (currentProfile?.role == 'student') 'college_id': collegeId,
      };

      await _supabase
          .from('profiles')
          .update(updatedProfileMap)
          .eq('id', user.id);

      // Fetch fresh data
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      final updatedProfile = ProfileModel.fromJson(data);
      currentProfile = updatedProfile;

      // Update local cache
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_profile', json.encode(updatedProfile.toJson()));

      emit(ProfileUpdateSuccess(updatedProfile));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }
}
