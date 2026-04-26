import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/student/home/apartment/service/favorite_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakan/features/student/favorites/view_models/cubit/favorites_cubit.dart';

class ApartmentCard extends StatefulWidget {
  final String id;
  final List<String> imagesUrl;
  final String title;
  final String description;
  final String ownerName;
  final int price;
  final double distance;
  final bool isAvailable;
  final bool isFavoriteInitial;
  final VoidCallback? onFavoriteChanged;

  const ApartmentCard({
    super.key,
    required this.id,
    required this.imagesUrl,
    required this.title,
    required this.description,
    required this.ownerName,
    required this.price,
    required this.distance,
    required this.isAvailable,
    this.isFavoriteInitial = false,
    this.onFavoriteChanged,
  });

  @override
  State<ApartmentCard> createState() => _ApartmentCardState();
}

class _ApartmentCardState extends State<ApartmentCard> {
  late bool isFavorite;
  bool _isSyncing = true;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavoriteInitial;
    _syncFavoriteStatus();
  }

  Future<void> _syncFavoriteStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = prefs.getStringList('favorite_apartments') ?? [];

      final bool localFavorite = favorites.contains(widget.id);

      // إذا كان في فرق بين الـ API والـ local → نأخذ الـ local (أحدث)
      if (localFavorite != isFavorite) {
        setState(() {
          isFavorite = localFavorite;
        });
      }
    } catch (e) {
      // لو حصل خطأ في القراءة → نكتفي بالقيمة الافتراضية من الـ API
    } finally {
      if (mounted) {
        setState(() {
          _isSyncing = false;
        });
      }
    }
  }

  Future<void> _toggleFavorite() async {
    // optimistic update
    final previousState = isFavorite;
    setState(() {
      isFavorite = !isFavorite;
    });

    try {
      final newState = await FavoriteService.toggleFavorite(widget.id);

      // sync with cubit if it exists in the tree
      if (mounted) {
        context.read<FavoritesCubit>().toggleFavorite(widget.id);
      }

      // لو السيرفر رجّع حالة مختلفة عن اللي توقعناها
      if (newState != isFavorite) {
        setState(() {
          isFavorite = newState;
        });
      }

      // نحدّث الشاشة الأب (مثل Favorites screen)
      widget.onFavoriteChanged?.call();
    } catch (e) {
      // في حالة فشل → نرجّع الحالة السابقة
      setState(() {
        isFavorite = previousState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainImage = widget.imagesUrl.isNotEmpty
        ? widget.imagesUrl.first
        : 'https://via.placeholder.com/400x280';

    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                child: Image.network(
                  mainImage,
                  height: 240,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Available Badge
              if (widget.isAvailable)
                Positioned(
                  top: 18,
                  left: 18,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.kSuccessColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 8),
                      ],
                    ),
                    child: const Text(
                      'Available Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              // Floating Price Badge (إبداعي)
              Positioned(
                bottom: 18,
                right: 18,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.kPrimaryColor,
                        AppColors.kSecondaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 12),
                    ],
                  ),
                  child: Text(
                    '\$${widget.price}',
                    style: GoogleFonts.lato(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Heart (زجاجي) ← الجزء اللي اتعدل
              Positioned(
                top: 18,
                right: 18,
                child: GestureDetector(
                  onTap: _toggleFavorite,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
                      ],
                    ),
                    child: _isSyncing
                        ? const SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.grey),
                            ),
                          )
                        : Icon(
                            isFavorite ? Iconsax.heart5 : Iconsax.heart,
                            color: isFavorite ? Colors.red : Colors.grey[800],
                            size: 26,
                          ),
                  ),
                ),
              ),
            ],
          ),

          // Info Section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.merriweather(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kTextPrimaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(
                      Iconsax.user,
                      size: 18,
                      color: AppColors.kTextSecondaryColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'by ${widget.ownerName}',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        color: AppColors.kTextSecondaryColor,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Text(
                  widget.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(
                    fontSize: 14.5,
                    height: 1.45,
                    color: AppColors.kTextSecondaryColor,
                  ),
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.location4,
                          size: 19,
                          color: AppColors.kAccentColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${widget.distance.toStringAsFixed(1)} km away',
                          style: GoogleFonts.lato(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kTextPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '/night',
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: AppColors.kTextSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}