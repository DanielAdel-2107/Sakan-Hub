import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String _key = 'favorite_apartments';

  // 1. جلب قائمة المفضلات
  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  // 2. التحقق هل العنصر مفضل أم لا
  static Future<bool> isFavorite(String id) async {
    final favorites = await getFavorites();
    return favorites.contains(id);
  }

  // 3. تبديل الحالة (إضافة أو حذف)
  static Future<bool> toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList(_key) ?? [];

    bool newState;
    if (favorites.contains(id)) {
      favorites.remove(id);
      newState = false; // تم الحذف
    } else {
      favorites.add(id);
      newState = true; // تم الإضافة
    }

    await prefs.setStringList(_key, favorites);
    return newState; // نعيد الحالة الجديدة لنحدث الـ UI بناءً عليها
  }
}
