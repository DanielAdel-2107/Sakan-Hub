import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/apartments/view_models/cubit/owner_apartments_cubit.dart';
import 'package:sakan/features/owner/apartments/views/widgets/apartment_card.dart';
import 'package:sakan/features/owner/apartments/views/widgets/empty_apartments_view.dart';
import 'package:sakan/features/owner/apartments/views/widgets/error_view.dart';
import 'package:sakan/features/owner/apartments/views/widgets/status_filter_chips.dart';
import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';
import 'package:sakan/core/components/widgets_app/custom_quick_alert.dart';

class OwnerApartmentsView extends StatefulWidget {
  const OwnerApartmentsView({super.key});

  @override
  State<OwnerApartmentsView> createState() => OwnerApartmentsViewState();
}

class OwnerApartmentsViewState extends State<OwnerApartmentsView> {
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatusFilterChips(
          selectedStatus: selectedStatus,
          onStatusSelected: (value) => setState(() => selectedStatus = value),
        ),
        Expanded(
          child: BlocConsumer<OwnerApartmentsCubit, OwnerApartmentsState>(
            listener: (context, state) {
              if (state.status == OwnerApartmentsStatus.deleteSuccess) {
                CustomQuickAlert.showSuccess(context, message: 'Apartment deleted successfully');
              } else if (state.status == OwnerApartmentsStatus.deleteError) {
                CustomQuickAlert.showError(context, message: state.errorMessage ?? 'Failed to delete');
              }
            },
            builder: (context, state) {
              if (state.status == OwnerApartmentsStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.status == OwnerApartmentsStatus.error) {
                return ErrorView(message: state.errorMessage ?? 'Unknown error');
              }
              if (state.status == OwnerApartmentsStatus.empty) {
                return const EmptyApartmentsView();
              }
              if (state.status == OwnerApartmentsStatus.loaded || 
                  state.status == OwnerApartmentsStatus.deleting ||
                  state.status == OwnerApartmentsStatus.deleteSuccess ||
                  state.status == OwnerApartmentsStatus.deleteError) {
                final filtered = filterApartments(state.apartments, selectedStatus);
                if (filtered.isEmpty) {
                  return const Center(
                    child: Text('No apartments matching filter', style: TextStyle(fontSize: 18, color: Colors.grey)),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => context.read<OwnerApartmentsCubit>().loadOwnerApartments(),
                  backgroundColor: AppColors.kPrimaryColor,
                  color: Colors.white,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                    itemCount: filtered.length,
                    itemBuilder: (_, i) => ApartmentCard(apartment: filtered[i]),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  List<ApartmentModel> filterApartments(List<ApartmentModel> all, String? status) {
    if (status == null) return all;
    final wantAvailable = status == 'available';
    return all.where((apt) => apt.isAvailable == wantAvailable).toList();
  }
}

