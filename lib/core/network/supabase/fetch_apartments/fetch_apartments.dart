import 'package:sakan/features/student/home/apartment/models/apartment_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<List<ApartmentModel>> fetchApartments() async {
  try {
    // جلب البيانات مع عمل Join لجدول الصور
    final response = await Supabase.instance.client
        .from('apartments')
        .select(
          '*, apartment_images(image_url)',
        ) // هاد السطر بيجيب كل الصور التابعة للشقة
        .eq('is_available', true); // جلب الشقق المتاحة فقط

    final data = response as List<dynamic>;
    return data.map((json) => ApartmentModel.fromJson(json)).toList();
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}
