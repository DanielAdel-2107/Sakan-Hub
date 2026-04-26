import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/owner/requests/view_models/cubit/owner_requests_cubit.dart';
import 'package:sakan/features/owner/requests/views/widgets/filter_pill.dart';

class ModernFilterBar extends StatelessWidget {
  const ModernFilterBar({super.key});

  static const _filters = ['All', 'Pending', 'Approved', 'Rejected'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerRequestsCubit, OwnerRequestsState>(
      builder: (context, state) {
        final cubit = context.read<OwnerRequestsCubit>();
        final selected = cubit.currentFilter;

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.94),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: _filters.map((filter) {
                final isSelected = filter == selected;
                return Expanded(
                  child: FilterPill(
                    label: filter,
                    isSelected: isSelected,
                    onTap: () => cubit.changeFilter(filter),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

