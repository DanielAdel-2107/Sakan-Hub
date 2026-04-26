import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakan/core/helper/show_custom_dialog.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/add_apartment/view_models/cubit/add_apartment_cubit.dart';
import 'package:sakan/features/owner/add_apartment/view_models/cubit/add_apartment_state.dart';
import 'package:sakan/features/owner/add_apartment/views/widgets/apartment_form_fields.dart';
import 'package:sakan/features/owner/add_apartment/views/widgets/location_picker_section.dart'; // ← جديد
import 'package:sakan/features/owner/add_apartment/views/widgets/photos_section.dart';
import 'package:sakan/features/owner/add_apartment/views/widgets/publish_button.dart';

class AddApartmentScreen extends StatefulWidget {
  const AddApartmentScreen({super.key});

  @override
  State<AddApartmentScreen> createState() => _AddApartmentScreenState();
}

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();

  String? _selectedStatus = 'Available';
  final _photos = <XFile>[];

  static const _maxPhotos = 10;
  static const _statusOptions = ['Available', 'Reserved', 'Rented'];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickPhotos() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage(
      imageQuality: 82,
      maxWidth: 1200,
    );

    if (picked.isEmpty || !mounted) return;

    setState(() {
      final remaining = _maxPhotos - _photos.length;
      _photos.addAll(picked.take(remaining));
    });

    if (picked.length > (_maxPhotos - _photos.length) && mounted) {
      showCustomDialog(
        title: 'Limit Reached',
        description: 'Maximum 10 photos allowed',
        dialogType: DialogType.warning,
      );
    }
  }

  void _removePhoto(int index) {
    setState(() => _photos.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddApartmentCubit(),
      child: BlocConsumer<AddApartmentCubit, AddApartmentState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pop(context);
            showCustomDialog(
              title: 'Success',
              description: 'Apartment published successfully!',
              dialogType: DialogType.success,
            );
          }

          if (state.errorMessage != null) {
            showCustomDialog(
              title: 'Error',
              description: state.errorMessage!,
              dialogType: DialogType.error,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.kBackgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.kBackgroundColor,
              elevation: 0,
              title: const Text(
                'Add New Apartment',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
            ),
            body: Form(
              key: _formKey,
              child: CustomScrollView(
                slivers: [
                  // Photos Section
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    sliver: SliverToBoxAdapter(
                      child: PhotosSection(
                        photos: _photos,
                        onPickPhotos: _pickPhotos,
                        onRemovePhoto: _removePhoto,
                        maxPhotos: _maxPhotos,
                      ),
                    ),
                  ),

                  // ── الخريطة الجديدة ─────────────────────────────
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(20, 24, 20, 0),
                    sliver: SliverToBoxAdapter(
                      child: LocationPickerSection(),
                    ),
                  ),

                  // Form Fields + Button
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 24),
                        ApartmentFormFields(
                          titleController: _titleController,
                          descController: _descController,
                          priceController: _priceController,
                          selectedStatus: _selectedStatus,
                          statusOptions: _statusOptions,
                          onStatusChanged: (v) =>
                              setState(() => _selectedStatus = v),
                        ),
                        const SizedBox(height: 32),
                        PublishButton(
                          isLoading: state.isLoading,
                          onPressed: () => _handlePublish(context),
                        ),
                        const SizedBox(height: 40),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handlePublish(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<AddApartmentCubit>().submit(
          title: _titleController.text.trim(),
          description: _descController.text.trim(),
          priceText: _priceController.text.trim(),
          selectedStatus: _selectedStatus ?? 'Available',
          photos: List.from(_photos),
          formKey: _formKey,
        );
  }
}