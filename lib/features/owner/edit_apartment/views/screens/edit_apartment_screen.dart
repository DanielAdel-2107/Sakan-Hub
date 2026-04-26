import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/edit_apartment/view_models/cubit/edit_apartment_cubit.dart';
import 'package:sakan/features/owner/edit_apartment/views/widgets/apartment_form_fields.dart';
import 'package:sakan/features/owner/edit_apartment/views/widgets/apartment_image_section.dart';
import 'package:sakan/features/owner/edit_apartment/views/widgets/save_button.dart';
import 'package:sakan/features/owner/edit_apartment/views/widgets/section_title.dart';
import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sakan/core/components/widgets_app/custom_quick_alert.dart';


class EditApartmentScreen extends StatefulWidget {
  final ApartmentModel apartment;

  const EditApartmentScreen({super.key, required this.apartment});

  @override
  State<EditApartmentScreen> createState() => _EditApartmentScreenState();
}

class _EditApartmentScreenState extends State<EditApartmentScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _latController;
  late TextEditingController _lngController;

  late bool _isAvailable;
  List<String> _existingImageUrls = [];
  final List<File> _newImages = [];
  final List<String> _imagesToDelete = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.apartment.title);
    _descriptionController = TextEditingController(text: widget.apartment.description);
    _priceController = TextEditingController(text: widget.apartment.price.toStringAsFixed(0));
    _latController = TextEditingController(text: widget.apartment.lat.toStringAsFixed(6));
    _lngController = TextEditingController(text: widget.apartment.lng.toStringAsFixed(6));
    _isAvailable = widget.apartment.isAvailable;
    _existingImageUrls = List.from(widget.apartment.imageUrls);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage(limit: 8);
    if (picked.isNotEmpty && mounted) {
      setState(() {
        _newImages.addAll(picked.map((x) => File(x.path)));
      });
    }
  }

  void _removeExisting(int index) {
    setState(() {
      _imagesToDelete.add(_existingImageUrls.removeAt(index));
    });
  }

  void _removeNew(int index) {
    setState(() => _newImages.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditApartmentCubit(Supabase.instance.client, widget.apartment),
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          title: const Text('Edit Apartment'),
          centerTitle: true,
          backgroundColor: AppColors.kWhiteColor,
          foregroundColor: AppColors.kTextPrimaryColor,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: BlocConsumer<EditApartmentCubit, EditApartmentState>(
          listener: (context, state) {
            if (state is EditApartmentSuccess) {
              CustomQuickAlert.showSuccess(
                context,
                message: 'Apartment updated successfully',
                onConfirm: () => Navigator.pop(context, true),
              );
            } else if (state is EditApartmentError) {
              CustomQuickAlert.showError(context, message: state.message);
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 40),
                children: [
                  const SectionTitle(title: 'Apartment Images'),
                  const SizedBox(height: 12),
                  ApartmentImagesSection(
                    existingUrls: _existingImageUrls,
                    newFiles: _newImages,
                    onRemoveExisting: _removeExisting,
                    onRemoveNew: _removeNew,
                    onAddPhotos: _pickImages,
                  ),
                  const SizedBox(height: 32),
                  ApartmentFormFields(
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    priceController: _priceController,
                    latController: _latController,
                    lngController: _lngController,
                    isAvailable: _isAvailable,
                    onAvailabilityChanged: (v) => setState(() => _isAvailable = v),
                  ),
                  const SizedBox(height: 40),
                  SaveButton(
                    isLoading: state is EditApartmentLoading,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      final updated = widget.apartment.copyWith(
                        title: _titleController.text.trim(),
                        description: _descriptionController.text.trim(),
                        price: double.parse(_priceController.text),
                        lat: double.parse(_latController.text),
                        lng: double.parse(_lngController.text),
                        isAvailable: _isAvailable,
                      );

                      context.read<EditApartmentCubit>().updateApartment(
                            updated,
                            newImages: _newImages,
                            imagesToDelete: _imagesToDelete,
                          );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

