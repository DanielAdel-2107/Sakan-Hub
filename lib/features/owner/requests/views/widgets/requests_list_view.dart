import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/requests/view_models/cubit/owner_requests_cubit.dart';
import 'package:sakan/features/owner/requests/views/widgets/request_card.dart';

class RequestsListView extends StatelessWidget {
  const RequestsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerRequestsCubit, OwnerRequestsState>(
      builder: (context, state) {
        if (state is OwnerRequestsLoading) {
          return Center(child: CircularProgressIndicator(color: AppColors.kPrimaryColor));
        }

        if (state is OwnerRequestsError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.kErrorColor, fontSize: 16, height: 1.4),
              ),
            ),
          );
        }

        if (state is OwnerRequestsLoaded) {
          final cubit = context.read<OwnerRequestsCubit>();
          final filtered = state.items.where((it) {
            if (cubit.currentFilter == 'All') return true;
            return it.status.toLowerCase() == cubit.currentFilter.toLowerCase();
          }).toList();

          if (filtered.isEmpty) {
            return Center(
              child: Text(
                'No requests found',
                style: TextStyle(fontSize: 17, color: AppColors.kTextSecondaryColor),
              ),
            );
          }

          return RefreshIndicator(
            color: AppColors.kPrimaryColor,
            onRefresh: () => cubit.loadRequests(),
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
              itemCount: filtered.length,
              itemBuilder: (_, i) => RequestCard(item: filtered[i]),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
