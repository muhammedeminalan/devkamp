import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/widgets/sections/app_section_header.dart';
import 'package:app/core/widgets/surfaces/app_surface_card.dart';
import 'package:flutter/material.dart';

class ProfilePerformanceSection extends StatelessWidget {
  const ProfilePerformanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<({String name, int done, int total, IconData icon, Color color, Color bg})>
        items = <({String name, int done, int total, IconData icon, Color color, Color bg})>[
      (name: 'Flutter', done: 38, total: 124, icon: Icons.flutter_dash_rounded, color: const Color(0xFF2563EB), bg: const Color(0xFFDBEAFE)),
      (name: 'Dart', done: 22, total: 78, icon: Icons.code_rounded, color: const Color(0xFF4F46E5), bg: const Color(0xFFEEF2FF)),
      (name: 'iOS', done: 17, total: 62, icon: Icons.phone_iphone_rounded, color: const Color(0xFF0284C7), bg: const Color(0xFFE0F2FE)),
      (name: 'SQL', done: 19, total: 70, icon: Icons.storage_rounded, color: const Color(0xFF0EA5E9), bg: const Color(0xFFE0F2FE)),
      (name: 'System Design', done: 9, total: 40, icon: Icons.account_tree_rounded, color: const Color(0xFF9333EA), bg: const Color(0xFFF3E8FF)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const AppSectionHeader(title: AppStrings.profilePerformanceTitle),
        const SizedBox(height: 10),
        AppSurfaceCard(
          child: Column(
            children: items.map((item) {
              final int pct = ((item.done / item.total) * 100).round();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: item.bg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Icon(item.icon, size: 16, color: item.color),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                item.name,
                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                '$pct%',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: item.color,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: pct / 100,
                              minHeight: 6,
                              backgroundColor: NeutralColor.neutral100,
                              valueColor: AlwaysStoppedAnimation<Color>(item.color),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
