import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/core/widgets/sections/app_section_header.dart';
import 'package:app/core/widgets/surfaces/app_surface_card.dart';
import 'package:app/features/profile/domain/entities/category_performance.dart';
import 'package:flutter/material.dart';

class ProfilePerformanceSection extends StatelessWidget {
  const ProfilePerformanceSection({
    required this.performances,
    super.key,
  });

  final List<CategoryPerformance> performances;

  // categoryId'ye göre ikon döndürür.
  IconData _iconFor(String id) => switch (id) {
        'flutter'  => Icons.flutter_dash_rounded,
        'dart'     => Icons.code_rounded,
        'python'   => Icons.terminal_rounded,
        'ios'      => Icons.phone_iphone_rounded,
        'android'  => Icons.android_rounded,
        'sql'      => Icons.storage_rounded,
        _          => Icons.book_rounded,
      };

  // categoryId'ye göre renk döndürür.
  Color _colorFor(String id) => switch (id) {
        'flutter'  => const Color(0xFF2563EB),
        'dart'     => const Color(0xFF4F46E5),
        'python'   => const Color(0xFF059669),
        'ios'      => const Color(0xFF374151),
        'android'  => const Color(0xFF16A34A),
        'sql'      => const Color(0xFF0EA5E9),
        _          => const Color(0xFF9333EA),
      };

  Color _bgFor(String id) => switch (id) {
        'flutter'  => const Color(0xFFDBEAFE),
        'dart'     => const Color(0xFFEEF2FF),
        'python'   => const Color(0xFFD1FAE5),
        'ios'      => const Color(0xFFF3F4F6),
        'android'  => const Color(0xFFDCFCE7),
        'sql'      => const Color(0xFFE0F2FE),
        _          => const Color(0xFFF3E8FF),
      };

  @override
  Widget build(BuildContext context) {
    if (performances.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppSectionHeader(title: context.l10n.profilePerformanceTitle),
        const SizedBox(height: 10),
        AppSurfaceCard(
          child: Column(
            children: performances.map((CategoryPerformance perf) {
              final int pct = (perf.accuracy * 100).round();
              final Color color = _colorFor(perf.categoryId);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: _bgFor(perf.categoryId),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Icon(_iconFor(perf.categoryId), size: 16, color: color),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Uzun kategori isimleri için Expanded + ellipsis
                              Expanded(
                                child: Text(
                                  perf.categoryTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '$pct% · ${perf.totalSolved} soru',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: color,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: perf.accuracy,
                              minHeight: 6,
                              backgroundColor: NeutralColor.neutral100,
                              valueColor: AlwaysStoppedAnimation<Color>(color),
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
