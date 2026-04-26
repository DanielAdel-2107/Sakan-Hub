import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/requests/view_models/cubit/owner_requests_cubit.dart';
import 'package:sakan/features/owner/requests/views/widgets/modern_filter_bar.dart';
import 'package:sakan/features/owner/requests/views/widgets/requests_list_view.dart';
import 'package:timeago/timeago.dart' as timeago;

class OwnerRequestsScreen extends StatelessWidget {
  const OwnerRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('en_short', timeago.EnShortMessages());

    return BlocProvider(
      create: (_) => OwnerRequestsCubit()..loadRequests(),
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: _buildAppBar(),
        body: const Column(
          children: [
            ModernFilterBar(),
            Expanded(child: RequestsListView()),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.kWhiteColor,
      title: Text(
        'Booking Requests',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: AppColors.kTextPrimaryColor,
        ),
      ),
      centerTitle: true,
    );
  }
}

