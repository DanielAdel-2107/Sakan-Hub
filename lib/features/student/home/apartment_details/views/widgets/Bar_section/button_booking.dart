import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/core/helper/show_custom_dialog.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/student/home/apartment_details/models/booking_model.dart';
import 'package:sakan/features/student/home/apartment_details/view_models/cubit/booking_cubit.dart';
import 'package:sakan/features/student/home/apartment_details/view_models/cubit/booking_state.dart';
import 'package:sakan/features/student/booking_request/views/screens/booking_request_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ButtonBooking extends StatelessWidget {
  final String apartmentId;
  const ButtonBooking({super.key, required this.apartmentId});

  @override
  Widget build(BuildContext context) {
    return // داخل الـ Build الخاص بالزر في صفحة التفاصيل
    BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          showCustomDialog(
            title: 'Success',
            description: "Your Booking request has been sent successfully.",
            dialogType: DialogType.success,
            btnOkColor: Colors.green,
          );
          // Navigate to BookingRequestScreen
          if (state.bookingId != null) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BookingRequestScreen(bookingId: state.bookingId!),
                ),
              );
            });
          }
        } else if (state is BookingError) {
          // إظهار الدايلوج الخاص بك عند الخطأ
          showCustomDialog(
            title: 'Failure',
            description: state.message,
            dialogType: DialogType.error,
            btnOkColor: Colors.red,
          );
        } else if (state is BookingAlreadyExists) {
          showCustomDialog(
            title: 'Duplicate request',
            description:
                'You have requested this apartment before, and it is currently on pending.',
            dialogType: DialogType.warning,
            btnOkColor: Colors.orange,
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(
              const EdgeInsets.symmetric(horizontal: 70, vertical: 13),
            ),
            backgroundColor: WidgetStatePropertyAll(AppColors.kPrimaryColor),
          ),
          onPressed: () {
            final newBooking = BookingModel(
              apartmentId: apartmentId,
              studentId: Supabase.instance.client.auth.currentUser!.id,
              status: 'pending', // الحالة الافتراضية
            );
            context.read<BookingCubit>().submitBooking(newBooking);
          },
          child: state is BookingLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  "Book",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        );
      },
    );
  }
}
