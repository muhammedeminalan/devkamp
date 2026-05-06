import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/widgets/loaders/app_score_ring.dart';
import 'package:flutter/material.dart';

class ResultScoreSection extends StatelessWidget {
  const ResultScoreSection({
    required this.score,
    required this.total,
    super.key,
  });

  final int score;
  final int total;

  Color get _ringColor {
    if (total <= 0) {
      return const Color(0xFFEF4444);
    }
    final double pct = score / total;
    if (pct >= 0.8) return const Color(0xFF10B981);
    if (pct >= 0.5) return PrimaryColor.primary600;
    return const Color(0xFFEF4444);
  }

  String get _message {
    if (total <= 0) {
      return 'Henüz sonuç hesaplanamadı.';
    }
    final double pct = score / total;
    if (pct >= 0.8) return 'Harika! Mülakata hazırsın.';
    if (pct >= 0.5) return 'İyi ilerleme. Çalışmaya devam et.';
    return 'Durma. Tekrar çalış ve dene.';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 8),
        Text(
          'Oturum Tamamlandı! 🎉',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          _message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF6B7280),
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        AppScoreRing(
          score: score,
          total: total,
          ringColor: _ringColor,
        ),
      ],
    );
  }
}
