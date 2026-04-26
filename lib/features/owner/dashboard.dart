// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class AppColors {
//   static final Color primary = Color(0xFF2F80ED);
//   static final Color primaryLight = Color(0xFF5A9EFF);
//   static final Color success = Color(0xFF27AE60);
//   static final Color accent = Color(0xFFF59E0B);
//   static final Color background = Color(0xFFF9FAFB);
//   static final Color surface = Color(0xFFFFFFFF);
//   static final Color textPrimary = Color(0xFF1F2937);
//   static final Color textSecondary = Color(0xFF6B7280);
//   static final Color divider = Color(0xFFE5E7EB);
// }

// class LandlordDashboard extends StatelessWidget {
//   const LandlordDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isSmallScreen = size.width < 360;

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               backgroundColor: AppColors.surface,
//               elevation: 0,
//               floating: true,
//               title: Text(
//                 'My Properties',
//                 style: TextStyle(
//                   color: AppColors.textPrimary,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 22,
//                 ),
//               ),
//               actions: [
//                 IconButton(
//                   icon: const Icon(Icons.notifications_outlined),
//                   color: AppColors.textSecondary,
//                   onPressed: () {},
//                 ),
//                 const SizedBox(width: 8),
//               ],
//             ),

//             SliverPadding(
//               padding: const EdgeInsets.all(16),
//               sliver: SliverList(
//                 delegate: SliverChildListDelegate([
//                   // Today's stats row - النسخة المحسنة
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Expanded(
//                         flex: 5,
//                         child: _EnhancedStatCard(
//                           title: "Today's Increase",
//                           value: "8",
//                           subtitle: "New rental requests",
//                           trend: "+42% from yesterday",
//                           color: AppColors.accent,
//                           icon: Icons.trending_up_rounded,
//                           progress: 0.68,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         flex: 3,
//                         child: _EnhancedSmallStatCard(
//                           title: "Available Units",
//                           value: "14",
//                           subtitle: "out of 68 total",
//                           color: AppColors.success,
//                           icon: Icons.apartment_rounded,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 28),

//                   // Occupancy section
//                   Text(
//                     "Occupancy Rate Trend",
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: AppColors.textPrimary,
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   _OccupancyChartCard(isSmallScreen: isSmallScreen),

//                   const SizedBox(height: 32),

//                   // Quick Actions
//                   Wrap(
//                     spacing: 16,
//                     runSpacing: 16,
//                     alignment: WrapAlignment.spaceEvenly,
//                     children: [
//                       _ActionTile("Payments", Icons.receipt_long_rounded),
//                       _ActionTile("Map View", Icons.map_outlined),
//                       _ActionTile("Tenants", Icons.people_alt_rounded),
//                       _ActionTile(
//                         "Reports",
//                         Icons.analytics_rounded,
//                         isPrimary: true,
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 40),
//                 ]),
//               ),
//             ),
//           ],
//         ),
//       ),

//       bottomNavigationBar: _buildBottomNav(),
//     );
//   }

//   Widget _buildBottomNav() {
//     return BottomNavigationBar(
//       selectedItemColor: AppColors.primary,
//       unselectedItemColor: AppColors.textSecondary,
//       backgroundColor: AppColors.surface,
//       type: BottomNavigationBarType.fixed,
//       showSelectedLabels: true,
//       showUnselectedLabels: true,
//       elevation: 8,
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.dashboard_rounded),
//           label: "Home",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.apartment_rounded),
//           label: "Units",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.message_rounded),
//           label: "Messages",
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.settings_rounded),
//           label: "Settings",
//         ),
//       ],
//     );
//   }
// }

// // ──────────────────────────────────────────────
// //          Enhanced Stat Cards
// // ──────────────────────────────────────────────

// class _EnhancedStatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final String subtitle;
//   final String? trend;
//   final Color color;
//   final double progress;
//   final IconData icon;

//   const _EnhancedStatCard({
//     required this.title,
//     required this.value,
//     required this.subtitle,
//     this.trend,
//     required this.color,
//     required this.progress,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [color.withOpacity(0.12), color.withOpacity(0.05)],
//         ),
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.18), width: 1.2),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.15),
//             blurRadius: 12,
//             offset: const Offset(0, 5),
//           ),
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title.toUpperCase(),
//                 style: TextStyle(
//                   color: color.withOpacity(0.9),
//                   fontSize: 13,
//                   fontWeight: FontWeight.w700,
//                   letterSpacing: 0.4,
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: color.withOpacity(0.15),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(icon, color: color, size: 26),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 42,
//               fontWeight: FontWeight.w900,
//               color: AppColors.textPrimary,
//               height: 1.0,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             subtitle,
//             style: TextStyle(
//               color: AppColors.textSecondary,
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           if (trend != null) ...[
//             const SizedBox(height: 8),
//             Text(
//               trend!,
//               style: TextStyle(
//                 color: color,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//           const SizedBox(height: 16),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8),
//             child: LinearProgressIndicator(
//               value: progress,
//               minHeight: 12,
//               backgroundColor: color.withOpacity(0.18),
//               valueColor: AlwaysStoppedAnimation<Color>(color),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _EnhancedSmallStatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final String? subtitle;
//   final Color color;
//   final IconData icon;

//   const _EnhancedSmallStatCard({
//     required this.title,
//     required this.value,
//     this.subtitle,
//     required this.color,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: color.withOpacity(0.25), width: 1.5),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.18),
//             blurRadius: 14,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.15),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, color: color, size: 36),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 40,
//               fontWeight: FontWeight.w900,
//               color: AppColors.textPrimary,
//               height: 1.0,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             title,
//             style: TextStyle(
//               color: AppColors.textSecondary,
//               fontSize: 14,
//               fontWeight: FontWeight.w600,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           if (subtitle != null) ...[
//             const SizedBox(height: 4),
//             Text(
//               subtitle!,
//               style: TextStyle(
//                 color: AppColors.textSecondary.withOpacity(0.75),
//                 fontSize: 12.5,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// // ──────────────────────────────────────────────
// //          Occupancy Chart with fl_chart
// // ──────────────────────────────────────────────

// class _OccupancyChartCard extends StatelessWidget {
//   final bool isSmallScreen;

//   const _OccupancyChartCard({required this.isSmallScreen});

//   @override
//   Widget build(BuildContext context) {
//     final months = ["Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"];
//     final occupied = [45, 62, 78, 92, 88, 70, 55, 68]; // %
//     final available = occupied.map((o) => 100 - o).toList();

//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.baseline,
//                     children: [
//                       Text(
//                         "82",
//                         style: TextStyle(
//                           fontSize: 44,
//                           fontWeight: FontWeight.w900,
//                           color: AppColors.success,
//                           height: 0.95,
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         "%",
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.success,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     "Current Occupancy Rate",
//                     style: TextStyle(
//                       color: AppColors.textSecondary,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   _buildLegendDot("Occupied", AppColors.primary),
//                   const SizedBox(height: 6),
//                   _buildLegendDot("Available", AppColors.success),
//                 ],
//               ),
//             ],
//           ),

//           const SizedBox(height: 32),

//           SizedBox(
//             height: isSmallScreen ? 220 : 260,
//             child: BarChart(
//               BarChartData(
//                 alignment: BarChartAlignment.spaceAround,
//                 maxY: 100,
//                 minY: 0,
//                 barGroups: List.generate(months.length, (i) {
//                   return BarChartGroupData(
//                     x: i,
//                     barsSpace: 8,
//                     barRods: [
//                       BarChartRodData(
//                         toY: occupied[i].toDouble(),
//                         color: AppColors.primary,
//                         width: 16,
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(8),
//                         ),
//                       ),
//                       BarChartRodData(
//                         toY: available[i].toDouble(),
//                         color: AppColors.success.withOpacity(0.75),
//                         width: 16,
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(8),
//                         ),
//                       ),
//                     ],
//                   );
//                 }),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   rightTitles: const AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   topTitles: const AxisTitles(
//                     sideTitles: SideTitles(showTitles: false),
//                   ),
//                   bottomTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 32,
//                       getTitlesWidget: (value, meta) {
//                         final index = value.toInt();
//                         if (index >= 0 && index < months.length) {
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 8),
//                             child: Text(
//                               months[index],
//                               style: const TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           );
//                         }
//                         return const Text('');
//                       },
//                     ),
//                   ),
//                   leftTitles: AxisTitles(
//                     sideTitles: SideTitles(
//                       showTitles: true,
//                       reservedSize: 40,
//                       interval: 20,
//                       getTitlesWidget: (value, meta) {
//                         return Text(
//                           '${value.toInt()}%',
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 12,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 gridData: FlGridData(
//                   show: true,
//                   drawVerticalLine: false,
//                   horizontalInterval: 20,
//                   getDrawingHorizontalLine: (value) => FlLine(
//                     color: Colors.grey.withOpacity(0.15),
//                     strokeWidth: 1,
//                   ),
//                 ),
//                 borderData: FlBorderData(show: false),
//                 barTouchData: BarTouchData(
//                   enabled: true,
//                   touchTooltipData: BarTouchTooltipData(
//                     // tooltipBgColor: Colors.black.withOpacity(0.8),
//                     tooltipPadding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 8,
//                     ),
//                     tooltipBorder: BorderSide(),
//                     getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                       final isOccupied = rodIndex == 0;
//                       final value = isOccupied
//                           ? occupied[groupIndex]
//                           : available[groupIndex];
//                       final label = isOccupied ? "Occupied" : "Available";
//                       return BarTooltipItem(
//                         '$label\n$value%',
//                         const TextStyle(
//                           color: Colors.white,
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLegendDot(String label, Color color) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(0.4),
//                 blurRadius: 6,
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }
// }

// // ──────────────────────────────────────────────
// //          Other Widgets (unchanged)
// // ──────────────────────────────────────────────

// Widget _ActionTile(String label, IconData icon, {bool isPrimary = false}) {
//   return Column(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Material(
//         color: isPrimary ? AppColors.primary : AppColors.surface,
//         borderRadius: BorderRadius.circular(14),
//         elevation: isPrimary ? 0 : 2,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(14),
//           onTap: () {},
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             child: Icon(
//               icon,
//               color: isPrimary ? Colors.white : AppColors.textSecondary,
//               size: 28,
//             ),
//           ),
//         ),
//       ),
//       const SizedBox(height: 8),
//       Text(
//         label,
//         style: TextStyle(
//           fontSize: 13,
//           color: isPrimary ? AppColors.primary : AppColors.textSecondary,
//           fontWeight: isPrimary ? FontWeight.w600 : FontWeight.normal,
//         ),
//         textAlign: TextAlign.center,
//       ),
//     ],
//   );
// }
