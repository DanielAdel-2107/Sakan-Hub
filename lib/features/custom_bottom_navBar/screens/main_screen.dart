import 'package:flutter/material.dart';
import 'package:sakan/features/custom_bottom_navBar/widgets/custom_bottom_navBar.dart';
import 'package:sakan/features/student/chat_rooms/views/screens/chat_rooms_screen.dart';
import 'package:sakan/features/student/favorites/views/screens/favorites_screen.dart';
import 'package:sakan/features/student/home/apartment/views/screens/apartment_screen.dart';
import 'package:sakan/features/student/profile/views/screens/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/profile/view_models/cubit/profile_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // هذا هو المتغير الذي سيتحكم بكل شيء

  // قائمة الصفحات الأربعة
  final List<Widget> _pages = [
    const ApartmentScreen(), // صفحة الشقق اللي فيها الكيوبيت
    const FavoritesScreen(),
    ChatRoomsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..fetchProfile(),
      child: Scaffold(
        // الترتيب باستخدام Stack ليبقى الناف بار عائماً
        body: Stack(
          children: [
            // Using IndexedStack to preserve pages state
            IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
  
            // وضع الناف بار في الأسفل
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavBar(
                selectedIndex: _currentIndex, // نمرر الرقم الحالي
                onTap: (index) {
                  setState(() {
                    _currentIndex = index; // تحديث الرقم عند الضغط
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
