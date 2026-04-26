import 'package:geolocator/geolocator.dart';

class LocationService {
  // 1. دالة لجلب الموقع الحالي للمستخدم
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return Future.error('Location services are disabled.');

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  // 2. دالة حساب المسافة (بالمتر ثم تحويلها لكيلومتر)
  static double calculateDistance(
    double startLat,
    double startLng,
    double endLat,
    double endLng,
  ) {
    // نستخدم Geolocator المدمجة لسهولة الحساب ودقته
    double distanceInMeters = Geolocator.distanceBetween(
      startLat,
      startLng,
      endLat,
      endLng,
    );
    return distanceInMeters / 1000; // تحويل لكيلومتر
  }
}
