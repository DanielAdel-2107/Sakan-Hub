import 'package:sakan/core/utilies/assets/lotties/app_lotties.dart';
import 'package:sakan/features/on_boarding/models/on_boarding_model.dart';
import 'package:sakan/features/student/subscription/models/subscription_plan_model.dart';

class AppConstants {
  // on boarding list
  static List<OnBoardingStepModel> onBoardingList = <OnBoardingStepModel>[
    OnBoardingStepModel(
      image: AppLotties.mapIconLottie, // course materials lottie
      title: "Find Your Perfect Student Home",
      subTitle:
          "Search and discover nearby student housing easily. Filter by distance, price, and availability.",
    ),
    OnBoardingStepModel(
      image: AppLotties.verificationLottie, // digital library lottie
      title: "Book Instantly & Securely",
      subTitle:
          "Reserve your apartment in just a few taps. Get instant confirmation from verified owners.",
    ),
    OnBoardingStepModel(
      image: AppLotties.chatLottie, // notifications lottie
      title: "Chat with Owners & Stay Updated",
      subTitle:
          "Communicate directly with apartment owners. Track your booking status anytime.",
    ),
  ];

  // subscription plans
  static List<SubscriptionPlan> subscriptionPlans = [
    SubscriptionPlan(
      id: 'basic_monthly',
      title: 'Monthly Basic',
      price: '\$9.99',
      duration: 'per month',
      features: [
        'Unlimited apartment searches',
        'Direct chat with owners',
        'Instant booking requests',
        'Email notifications',
      ],
    ),
    SubscriptionPlan(
      id: 'pro_monthly',
      title: 'Monthly Pro',
      price: '\$19.99',
      duration: 'per month',
      features: [
        'All Basic features',
        'Priority support',
        'Verified badge on profile',
        'Advanced distance filtering',
      ],
      isPopular: true,
    ),
    SubscriptionPlan(
      id: 'yearly_premium',
      title: 'Yearly Premium',
      price: '\$99.99',
      duration: 'per year',
      features: [
        'All Pro features',
        'Save 40% annually',
        'Exclusive early access to new listing',
        'Dedicated account manager',
      ],
    ),
  ];
}

