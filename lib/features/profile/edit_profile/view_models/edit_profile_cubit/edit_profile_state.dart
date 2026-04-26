import 'package:sakan/features/profile/edit_profile/models/profile_model.dart';
import 'package:sakan/features/profile/edit_profile/models/university_model.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final ProfileModel profile;
  EditProfileSuccess(this.profile);
}

class EditProfileError extends EditProfileState {
  final String message;
  EditProfileError(this.message);
}

class UniversitiesLoaded extends EditProfileState {
  final List<UniversityModel> universities;
  UniversitiesLoaded(this.universities);
}

class ProfileUpdateLoading extends EditProfileState {}

class ProfileUpdateSuccess extends EditProfileState {
  final ProfileModel profile;
  ProfileUpdateSuccess(this.profile);
}
