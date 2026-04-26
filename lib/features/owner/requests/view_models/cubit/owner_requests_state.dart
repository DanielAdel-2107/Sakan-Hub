part of 'owner_requests_cubit.dart';

@immutable

sealed class OwnerRequestsState {}

class OwnerRequestsInitial extends OwnerRequestsState {}

class OwnerRequestsLoading extends OwnerRequestsState {}

class OwnerRequestsLoaded extends OwnerRequestsState {
  final List<OwnerRequestItem> items;
  OwnerRequestsLoaded(this.items);
}

class OwnerRequestsError extends OwnerRequestsState {
  final String message;
  OwnerRequestsError(this.message);
}

