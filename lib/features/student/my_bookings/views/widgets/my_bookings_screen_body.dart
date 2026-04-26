import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/features/student/chat/views/screens/chat_screen.dart';
import 'package:sakan/features/student/my_bookings/view_models/cubit/my_bookings_cubit.dart';
import 'package:sakan/features/student/my_bookings/view_models/cubit/my_bookings_state.dart';
import 'package:sakan/features/student/my_bookings/views/widgets/booking_list_item.dart';

class MyBookingsScreenBody extends StatelessWidget {
  const MyBookingsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyBookingsCubit, MyBookingsState>(
      listener: (context, state) {
        if (state.status == MyBookingsStatus.chatNavigate && state.chatModel != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(chatModel: state.chatModel!),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state.status == MyBookingsStatus.loading && state.bookings.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == MyBookingsStatus.error && state.bookings.isEmpty) {
          return Center(child: Text(state.error ?? 'Unknown error'));
        }

        return Column(
          children: [
            _buildFilterBar(context, state),
            Expanded(
              child: state.filteredBookings.isEmpty
                  ? _buildEmptyState(state.activeFilter)
                  : RefreshIndicator(
                      onRefresh: () => context.read<MyBookingsCubit>().fetchMyBookings(),
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(
                          SizeConfig.width * 0.05,
                          SizeConfig.height * 0.02,
                          SizeConfig.width * 0.05,
                          SizeConfig.height * 0.12,
                        ),
                        itemCount: state.filteredBookings.length,
                        separatorBuilder: (context, index) => SizedBox(height: SizeConfig.height * 0.01),
                        itemBuilder: (context, index) {
                          return BookingListItem(booking: state.filteredBookings[index]);
                        },
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterBar(BuildContext context, MyBookingsState state) {
    final filters = ['All', 'Pending', 'Approved', 'Rejected'];
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.01),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.05),
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = state.activeFilter == filter;
          return ChoiceChip(
            label: Text(filter),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                context.read<MyBookingsCubit>().updateFilter(filter);
              }
            },
            selectedColor: AppColors.kPrimaryColor,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : AppColors.kTextPrimaryColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
            backgroundColor: Colors.white,
            elevation: isSelected ? 4 : 0,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: isSelected ? AppColors.kPrimaryColor : Colors.grey.withOpacity(0.2),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(String filter) {
    String message = filter == 'All' ? 'No bookings found' : 'No $filter bookings found';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_outline_rounded, size: 64, color: Colors.grey.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
