import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/auth/sign_up/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SupabaseClient _supabase = Supabase.instance.client;

  ProfileCubit() : super(ProfileInitial());

  Future<void> fetchProfile() async {
    try {
      emit(ProfileLoading());
      // 1. التأكد من وجود مستخدم مسجل دخول
      final user = _supabase.auth.currentUser;
      if (user == null) {
        emit(ProfileError("User is not logged in"));
        return;
      }
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      // 3. تحويل البيانات لموديل
      final profile = ProfileModel.fromJson(data);
      emit(ProfileSuccess(profile));
    } catch (e) {
      emit(ProfileError("Failed to retrieve data: ${e.toString()}"));
    }
  }
}
