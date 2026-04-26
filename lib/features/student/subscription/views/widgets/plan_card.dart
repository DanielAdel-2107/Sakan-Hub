import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/core/utilies/styles/app_text_styles.dart';
import 'package:sakan/features/student/subscription/models/subscription_plan_model.dart';
import 'package:sakan/features/student/subscription/view_models/cubit/subscription_cubit.dart';
import 'package:sakan/features/student/subscription/view_models/cubit/subscription_state.dart';

class PlanCard extends StatelessWidget {
  final SubscriptionPlan plan;

  const PlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        final isSelected = state is SubscriptionPlanSelected && state.selectedPlan.id == plan.id;
        
        return GestureDetector(
          onTap: () => context.read<SubscriptionCubit>().selectPlan(plan),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Glassmorphic Card
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: EdgeInsets.all(SizeConfig.width * 0.05),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: isSelected ? AppColors.kPrimaryColor : Colors.white.withOpacity(0.3),
                    width: isSelected ? 2.5 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected 
                        ? AppColors.kPrimaryColor.withOpacity(0.15) 
                        : Colors.black.withOpacity(0.03),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plan.title,
                                style: AppTextStyles.bodyLarge.copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                  color: AppColors.kTextPrimaryColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    plan.price,
                                    style: TextStyle(
                                      color: isSelected ? AppColors.kPrimaryColor : Colors.black87,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4, left: 4),
                                    child: Text(
                                      plan.duration,
                                      style: TextStyle(
                                        color: AppColors.kTextSecondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.check, color: Colors.white, size: 16),
                          ).animate().scale(duration: 200.ms, curve: Curves.easeInBack),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(height: 1),
                    ),
                    ...plan.features.map((feature) => _buildFeatureItem(feature, isSelected)),
                  ],
                ),
              ),
              
              // POPULAR BADGE
              if (plan.isPopular)
                Positioned(
                  top: -12,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.kPrimaryColor, AppColors.kPrimaryColor.withOpacity(0.8)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.kPrimaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      'MOST POPULAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                   .shimmer(delay: 2.seconds, duration: 1500.ms),
                ),
            ],
          ),
        ).animate(target: isSelected ? 1 : 0)
         .scale(begin: const Offset(1, 1), end: const Offset(1.02, 1.02), duration: 200.ms);
      },
    );
  }

  Widget _buildFeatureItem(String feature, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.kPrimaryColor.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.done,
              size: 14,
              color: isSelected ? AppColors.kPrimaryColor : Colors.grey,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              feature,
              style: TextStyle(
                color: isSelected ? AppColors.kTextPrimaryColor : AppColors.kTextSecondaryColor,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
