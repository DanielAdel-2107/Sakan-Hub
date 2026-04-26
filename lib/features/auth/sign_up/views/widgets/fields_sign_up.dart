import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakan/core/components/variables_app.dart';
import 'package:sakan/core/components/widgets_app/customTextFields.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FieldsSignUp extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const FieldsSignUp({super.key, required this.formKey});

  @override
  State<FieldsSignUp> createState() => _FieldsSignUpState();
}

// ... imports نفسها

class _FieldsSignUpState extends State<FieldsSignUp> {
  bool isLoadingColleges = true;
  final ImagePicker _picker = ImagePicker();
  String? _imageError;

  @override
  void initState() {
    super.initState();
    _fetchColleges();
  }

  Future<void> _fetchColleges() async {
    try {
      final response = await Supabase.instance.client
          .from('universities')
          .select('id, name')
          .order('name');

      if (!mounted) return;

      setState(() {
        colleges = List<Map<String, dynamic>>.from(response);
        isLoadingColleges = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoadingColleges = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load universities: $e')),
      );
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 75,
        maxWidth: 900,
        maxHeight: 900,
      );

      if (image != null && mounted) {
        setState(() {
          selectedProfileImage = File(image.path);
          _imageError = null;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12),

          GestureDetector(
            onTap: _pickImage,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: selectedProfileImage != null
                            ? FileImage(selectedProfileImage!)
                            : null,
                        child: selectedProfileImage == null
                            ? Icon(
                                Icons.person,
                                size: 70,
                                color: Colors.grey.shade500,
                              )
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'Tap to select profile picture (required)',
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (_imageError != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    _imageError!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 32),

          CustomTextFormField(
            focusNode: fullNameFocus,
            validator: validated,
            controller: fullNameController,
            hintText: 'Full Name',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 16),

          CustomTextFormField(
            focusNode: emailFocus,
            validator: emailValidator,
            controller: emailController,
            hintText: 'Email',
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 16),

          CustomTextFormField(
            focusNode: passFocus,
            validator: passwordValidator,
            controller: passController,
            hintText: 'Password',
            icon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 16),

          CustomTextFormField(
            focusNode: phoneFocus,
            validator: phoneValidator,
            controller: phoneController,
            hintText: 'Phone Number',
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 24),

          if (userRole == 'student') ...[
            if (isLoadingColleges)
              const Center(child: CircularProgressIndicator())
            else
              DropdownButtonFormField<String>(
                initialValue: selectedCollegeId,
                isExpanded: true,
                menuMaxHeight: 320,
                hint: const Text('Select University / College'),
                items: colleges.map((college) {
                  return DropdownMenuItem<String>(
                    value: college['id'] as String,
                    child: Text(
                      college['name'] as String,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => selectedCollegeId = value),
                validator: (v) => (v == null || v.isEmpty)
                    ? 'Please select your college'
                    : null,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.school_outlined,
                    color: AppColors.kPrimaryColor,
                  ),
                  labelText: 'University / College',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.kPrimaryColor,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                dropdownColor: Colors.white,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.kPrimaryColor,
                ),
              ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Selecting a college is required for students only',
                style: TextStyle(color: Colors.grey, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
