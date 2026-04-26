
import 'package:flutter/material.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/features/owner/requests/models/owner_request_item.dart';
import 'package:sakan/features/owner/requests/views/widgets/action_button.dart';
import 'package:sakan/features/owner/requests/views/widgets/header_image_with_badge.dart';
import 'package:sakan/features/owner/requests/views/widgets/price_row.dart';
import 'package:sakan/features/owner/requests/views/widgets/status_info.dart';
import 'package:sakan/features/owner/requests/views/widgets/tenant_info_row.dart';

class RequestCard extends StatelessWidget {
  final OwnerRequestItem item;

  const RequestCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final status = item.status.toLowerCase();
    final statusInfo = StatusInfo.fromString(status);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Material(
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        color: AppColors.kCardColor,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.06),
        child: Column(
          children: [
            HeaderImageWithBadge(
              imageUrl: item.mainImage,
              statusInfo: statusInfo,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.apartment['title']?.toString() ?? 'Apartment',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.kTextPrimaryColor,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  PriceRow(price: item.apartment['price']),
                  const SizedBox(height: 24),
                  TenantInfoRow(
                    name: item.student['full_name']?.toString() ?? 'Tenant',
                    avatarUrl: item.student['image_url']?.toString(),
                    createdAt: item.createdAt,
                    onMessage: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening chat with ${item.student['full_name'] ?? 'tenant'}'),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  ActionButtons(
                    status: status,
                    bookingId: item.booking['id'].toString(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

