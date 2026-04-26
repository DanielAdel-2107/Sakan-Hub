import 'package:sakan/features/student/subscription/models/subscription_plan_model.dart';

abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionPlanSelected extends SubscriptionState {
  final SubscriptionPlan selectedPlan;
  SubscriptionPlanSelected(this.selectedPlan);
}

class SubscriptionSuccess extends SubscriptionState {
  final String message;
  SubscriptionSuccess(this.message);
}

class SubscriptionError extends SubscriptionState {
  final String message;
  SubscriptionError(this.message);
}
