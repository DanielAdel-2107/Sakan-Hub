import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/add_apartment/views/screens/add_apartment_screen.dart';
import 'package:sakan/features/owner/apartments/view_models/cubit/owner_apartments_cubit.dart';
import 'package:sakan/features/owner/apartments/views/widgets/owner_apartments_view.dart';
import 'package:sakan/features/owner/owner_chats/cubit/chat_rooms_cubit.dart';
import 'package:sakan/features/owner/owner_chats/views/screens/owner_chat_screen.dart';
import 'package:sakan/features/owner/requests/views/screens/owner_request_screen.dart';
import 'package:sakan/features/student/profile/views/screens/profile_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OwnerApartmentsScreen extends StatefulWidget {
  const OwnerApartmentsScreen({super.key});

  @override
  State<OwnerApartmentsScreen> createState() => _OwnerApartmentsScreenState();
}

class _OwnerApartmentsScreenState extends State<OwnerApartmentsScreen> {
  String? selectedStatus;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OwnerApartmentsCubit(Supabase.instance.client),
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: _selectedIndex == 0 ? _buildAppBar() : null,
        floatingActionButton: _selectedIndex == 0 ? _buildFab(context) : null,
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            const OwnerApartmentsView(),
            BlocProvider(
              create: (context) => ChatRoomsCubit()..fetchChatRooms(),
              child: const OwnerChatScreen(),
            ),
            const OwnerRequestsScreen(),
            const ProfileScreen(),
          ],
        ),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'My Apartments',
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 28,
          color: AppColors.kTextPrimaryColor,
          letterSpacing: -0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.tune_rounded,
            color: AppColors.kPrimaryColor,
            size: 28,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddApartmentScreen()),
        ).then((value) {
          if (value == true && context.mounted) {
            context.read<OwnerApartmentsCubit>().loadOwnerApartments();
          }
        });
      },
      backgroundColor: AppColors.kSecondaryColor,
      icon: const Icon(Icons.add_rounded, size: 30, color: Colors.white),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          'Add',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  NavigationBar _buildBottomNav() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) => setState(() => _selectedIndex = index),
      backgroundColor: AppColors.kCardColor,
      elevation: 12,
      indicatorColor: AppColors.kPrimaryColor.withOpacity(0.15),
      shadowColor: Colors.black.withOpacity(0.1),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.apartment_outlined, size: 26),
          selectedIcon: Icon(
            Icons.apartment_rounded,
            size: 26,
            color: AppColors.kPrimaryColor,
          ),
          label: 'Apartments',
        ),
        NavigationDestination(
          icon: const Icon(CupertinoIcons.chat_bubble_2, size: 26),
          selectedIcon: Icon(
            CupertinoIcons.chat_bubble_2_fill,
            size: 26,
            color: AppColors.kPrimaryColor,
          ),
          label: 'Chats',
        ),
        NavigationDestination(
          icon: const Icon(Icons.calendar_today_outlined, size: 26),
          selectedIcon: Icon(
            Icons.calendar_today_rounded,
            size: 26,
            color: AppColors.kPrimaryColor,
          ),
          label: 'Bookings',
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline_rounded, size: 26),
          selectedIcon: Icon(
            Icons.person_rounded,
            size: 26,
            color: AppColors.kPrimaryColor,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
