class SubscriptionPlan {
  final String id;
  final String title;
  final String price;
  final String duration;
  final List<String> features;
  final bool isPopular;

  SubscriptionPlan({
    required this.id,
    required this.title,
    required this.price,
    required this.duration,
    required this.features,
    this.isPopular = false,
  });
}
