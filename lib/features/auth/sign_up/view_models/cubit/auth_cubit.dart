import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/network/supabase/auth/auth_repository.dart';
import 'package:sakan/features/auth/sign_up/view_models/cubit/auth_state.dart';
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;

  AuthCubit(this._repository) : super(AuthInitial());

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role,
    String? collegeId,                    // ← الإضافة الجديدة
    File? profileImage,               // ← جديد
  }) async {
    emit(AuthLoading());
    try {
      final profile = await _repository.signUp(
        email: email,
        password: password,
        fullName: name,
        phone: phone,
        role: role,
        profileImage: profileImage,     // ← تمريرها
        collegeId: collegeId,               // ← تمرير القيمة
      );
      emit(AuthSuccess(profile));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required String role,
  }) async {
    emit(AuthLoading());
    try {
      final profile = await _repository.login(
        email: email,
        password: password,
        requiredRole: role,
      );
      emit(AuthSuccess(profile));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void resetState() {
    emit(AuthInitial());
  }
}