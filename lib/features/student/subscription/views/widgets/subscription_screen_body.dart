import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sakan/core/components/widgets_app/custom_button.dart';
import 'package:sakan/core/components/widgets_app/custom_quick_alert.dart';
import 'package:sakan/core/constants/app_constants.dart';
import 'package:sakan/core/utilies/colors/app_colors.dart';
import 'package:sakan/core/utilies/sizes/sized_config.dart';
import 'package:sakan/core/utilies/styles/app_text_styles.dart';
import 'package:sakan/features/student/subscription/view_models/cubit/subscription_cubit.dart';
import 'package:sakan/features/student/subscription/view_models/cubit/subscription_state.dart';
import 'package:sakan/features/student/subscription/views/widgets/plan_card.dart';
import 'package:sakan/features/student/subscription/views/widgets/trial_expired_header.dart';

class SubscriptionScreenBody extends StatelessWidget {
  const SubscriptionScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubscriptionCubit, SubscriptionState>(
      listener: (context, state) {
        if (state is SubscriptionSuccess) {
          CustomQuickAlert.showSuccess(context, message: state.message);
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
          });
        } else if (state is SubscriptionError) {
          CustomQuickAlert.showError(context, message: state.message);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const TrialExpiredHeader()
                  .animate()
                  .fade(duration: 600.ms)
                  .slideY(begin: -0.2, end: 0, curve: Curves.easeOutCirc),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.height * 0.04),
                    Text(
                      'Choose your journey',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                        letterSpacing: -0.5,
                      ),
                    ).animate().fade(delay: 200.ms).slideX(begin: -0.1, end: 0),
                    const SizedBox(height: 8),
                    Text(
                      'Find the plan that fits your needs perfectly.',
                      style: TextStyle(
                        color: AppColors.kTextSecondaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fade(delay: 300.ms).slideX(begin: -0.1, end: 0),
                    
                    SizedBox(height: SizeConfig.height * 0.03),
                    
                    // Plans List
                    ...AppConstants.subscriptionPlans.asMap().entries.map((entry) {
                      final index = entry.key;
                      final plan = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: PlanCard(plan: plan)
                            .animate()
                            .fade(delay: (400 + (index * 100)).ms)
                            .slideY(begin: 0.1, end: 0),
                      );
                    }),
                    
                    SizedBox(height: SizeConfig.height * 0.04),
                    
                    _buildSecurityInfo(),
                    
                    SizedBox(height: SizeConfig.height * 0.04),
                    _buildPayButton(context),
                    SizedBox(height: SizeConfig.height * 0.06),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.security_rounded, color: Colors.green, size: 20),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Secure encrypted payment. Your data is protected.',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    ).animate().fade(delay: 800.ms);
  }

  Widget _buildPayButton(BuildContext context) {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.kPrimaryColor.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: CustomButton(
            text: 'Pay & Unlock Now',
            onTap: () {
              context.read<SubscriptionCubit>().confirmSubscription();
            },
            color: AppColors.kPrimaryColor,
            isLoading: state is SubscriptionLoading,
          ),
        );
      },
    ).animate().scale(delay: 900.ms, curve: Curves.elasticOut);
  }
}
