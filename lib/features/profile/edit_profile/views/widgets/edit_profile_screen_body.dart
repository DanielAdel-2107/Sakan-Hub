import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/components/widgets_app/customTextFields.dart';
import 'package:sakan/core/components/widgets_app/custom_button.dart';
import 'package:sakan/core/components/widgets_app/custom_quick_alert.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/features/profile/edit_profile/view_models/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:sakan/features/profile/edit_profile/view_models/edit_profile_cubit/edit_profile_state.dart';
import 'package:sakan/features/profile/edit_profile/views/widgets/profile_image_picker.dart';
import 'package:sakan/features/profile/edit_profile/views/widgets/university_dropdown_field.dart';

class EditProfileScreenBody extends StatefulWidget {
  const EditProfileScreenBody({super.key});

  @override
  State<EditProfileScreenBody> createState() => _EditProfileScreenBodyState();
}

class _EditProfileScreenBodyState extends State<EditProfileScreenBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  String? _selectedCollegeId;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();

  @override
  void initState() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileSuccess) {
          _nameController.text = state.profile.fullName;
          _phoneController.text = state.profile.phone;
          _selectedCollegeId = state.profile.collegeId;
        } else if (state is ProfileUpdateLoading) {
          CustomQuickAlert.showLoading(context);
        } else if (state is ProfileUpdateSuccess) {
          Navigator.pop(context); // Close loading
          CustomQuickAlert.showSuccess(
            context,
            message: "Profile updated successfully",
            onConfirm: () => Navigator.pop(context),
          );
        } else if (state is EditProfileError) {
          if (ModalRoute.of(context)?.isCurrent == false) {
             Navigator.pop(context); // Close loading if open
          }
          CustomQuickAlert.showError(context, message: state.message);
        }
      },
      builder: (context, state) {
        if (state is EditProfileLoading && context.read<EditProfileCubit>().currentProfile == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final cubit = context.read<EditProfileCubit>();
        final profile = cubit.currentProfile;

        if (profile == null) return const SizedBox();

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.05,
            vertical: SizeConfig.height * 0.02,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ProfileImagePicker(
                  imageUrl: profile.imageUrl,
                  localImage: cubit.profileImage,
                  onPick: () => cubit.pickImage(),
                ),
                SizedBox(height: SizeConfig.height * 0.04),
                CustomTextFormField(
                  controller: _nameController,
                  hintText: "Full Name",
                  icon: Icons.person_outline_rounded,
                  focusNode: _nameFocus,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Name is required";
                    return null;
                  },
                ),
                SizedBox(height: SizeConfig.height * 0.02),
                CustomTextFormField(
                  controller: _phoneController,
                  hintText: "Phone Number",
                  icon: Icons.phone_outlined,
                  focusNode: _phoneFocus,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "Phone is required";
                    return null;
                  },
                ),
                if (profile.role == 'student') ...[
                  SizedBox(height: SizeConfig.height * 0.02),
                  UniversityDropdownField(
                    universities: cubit.universities,
                    selectedId: _selectedCollegeId,
                    onChanged: (id) {
                      setState(() {
                        _selectedCollegeId = id;
                      });
                    },
                  ),
                ],
                SizedBox(height: SizeConfig.height * 0.05),
                CustomButton(
                  text: "Save Changes",
                  color: AppColors.kPrimaryColor,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      cubit.updateProfile(
                        fullName: _nameController.text,
                        phone: _phoneController.text,
                        collegeId: _selectedCollegeId,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
