import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/add_apartment/view_models/cubit/add_apartment_cubit.dart';
import 'package:sakan/features/owner/add_apartment/view_models/cubit/add_apartment_state.dart';

class LocationPickerSection extends StatefulWidget {
  const LocationPickerSection({super.key});

  @override
  State<LocationPickerSection> createState() => _LocationPickerSectionState();
}

class _LocationPickerSectionState extends State<LocationPickerSection> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // شلناها من هنا عشان متعطلش فوراً
    // هتشتغل لما تضغط على الزرار (أكثر أمان)
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddApartmentCubit, AddApartmentState>(
      // listener عشان نحرك الخريطة تلقائياً لما الـ Cubit يغير الموقع
      listenWhen: (previous, current) =>
          previous.latitude != current.latitude ||
          previous.longitude != current.longitude,
      listener: (context, state) {
        if (state.latitude != null && state.longitude != null) {
          final pos = LatLng(state.latitude!, state.longitude!);
          _mapController.move(pos, 17);
        }
      },
      builder: (context, state) {
        // Single Source of Truth = الـ Cubit فقط (شلنا الـ local state خالص)
        final position = (state.latitude != null && state.longitude != null)
            ? LatLng(state.latitude!, state.longitude!)
            : const LatLng(30.0444, 31.2357); // Cairo default

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Apartment Location on Map',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap on the map to choose location',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 340,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: state.isLoading
                    ? Center(child: CircularProgressIndicator(
                      color: AppColors.kPrimaryColor,
                    ))
                    : FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: position,
                          initialZoom: 15,
                          onTap: (tapPosition, point) {
                            context
                                .read<AddApartmentCubit>()
                                .updateLocation(point.latitude, point.longitude);
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.sakan.app',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: position,
                                width: 40,
                                height: 40,
                                child: const Icon(
                                  Icons.location_pin,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () async {
                try {
                  await context.read<AddApartmentCubit>().getCurrentLocation();
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('فشل في الحصول على الموقع: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              icon: const Icon(Icons.my_location_rounded),
              label: const Text('Use My Current Location'),
            ),
          ],
        );
      },
    );
  }
}