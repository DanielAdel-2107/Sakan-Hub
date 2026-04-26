import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/network/supabase/auth/auth_repository.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/features/auth/sign_up/view_models/cubit/auth_cubit.dart';
import 'package:sakan/features/splash_screen/splash_screen.dart';
import 'package:sakan/features/student/home/apartment/view_models/cubit/apartments_cubit.dart';
import 'package:sakan/features/student/home/apartment_details/view_models/cubit/booking_cubit.dart';
import 'package:sakan/features/student/favorites/view_models/cubit/favorites_cubit.dart';
import 'package:sakan/features/student/profile/view_models/cubit/profile_cubit.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(AuthRepository()),
        ),
        BlocProvider(create: (context) => ApartmentsCubit()..fetchApartments()),
        BlocProvider(create: (context) => FavoritesCubit()..fetchFavorites()),
        BlocProvider(create: (context) => ProfileCubit()..fetchProfile()),
        BlocProvider(create: (context) => BookingCubit()),
      ],

      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
