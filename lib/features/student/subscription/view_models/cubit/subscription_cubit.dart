import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/subscription/models/subscription_plan_model.dart';
import 'package:sakan/features/student/subscription/view_models/cubit/subscription_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final SupabaseClient _supabase = Supabase.instance.client;
  SubscriptionPlan? _selectedPlan;

  SubscriptionCubit() : super(SubscriptionInitial());

  void selectPlan(SubscriptionPlan plan) {
    _selectedPlan = plan;
    emit(SubscriptionPlanSelected(plan));
  }

  Future<void> confirmSubscription() async {
    if (_selectedPlan == null) {
      emit(SubscriptionError("Please select a plan first"));
      return;
    }

    emit(SubscriptionLoading());
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        emit(SubscriptionError("User not logged in"));
        return;
      }

      DateTime expiresAt;
      if (_selectedPlan!.id.contains('yearly')) {
        expiresAt = DateTime.now().add(const Duration(days: 365));
      } else {
        expiresAt = DateTime.now().add(const Duration(days: 30));
      }

      // Add to subscriptions table
      await _supabase.from('subscriptions').insert({
        'user_id': userId,
        'expires_at': expiresAt.toUtc().toIso8601String(),
        'is_active': true,
      });

      // Update profile status
      await _supabase.from('profiles').update({
        'is_paid': true,
      }).eq('id', userId);

      emit(SubscriptionSuccess("Successfully subscribed to ${_selectedPlan!.title}"));
    } catch (e) {
      emit(SubscriptionError("Failed to process subscription: ${e.toString()}"));
    }
  }
}
