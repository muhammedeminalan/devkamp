import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:flutter/material.dart';

class ResultScoreSection extends StatefulWidget {
  const ResultScoreSection({
    required this.score,
    required this.total,
    super.key,
  });

  final int score;
  final int total;

  @override
  State<ResultScoreSection> createState() => _ResultScoreSectionState();
}

class _ResultScoreSectionState extends State<ResultScoreSection> {
  double _animPct = 0;

  @override
  void initState() {
    super.initState();
    // İlk frame render'landıktan sonra animasyonu başlat — görünür olmadan animate etme.
    Future<void>.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        setState(() {
          _animPct = widget.score / widget.total;
        });
      }
    });
  }

  Color get _ringColor {
    final double pct = widget.score / widget.total;
    if (pct >= 0.8) return const Color(0xFF10B981);
    if (pct >= 0.5) return PrimaryColor.primary600;
    return const Color(0xFFEF4444);
  }

  String get _message {
    final double pct = widget.score / widget.total;
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
        SizedBox(
          width: 170,
          height: 170,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: _animPct),
                duration: const Duration(milliseconds: 1400),
                curve: Curves.easeOutCubic,
                builder: (BuildContext context, double value, _) {
                  return CircularProgressIndicator(
                    value: value,
                    strokeWidth: 14,
                    strokeCap: StrokeCap.round,
                    backgroundColor: const Color(0xFFE5E7EB),
                    valueColor: AlwaysStoppedAnimation<Color>(_ringColor),
                  );
                },
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${widget.score}/${widget.total}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -1,
                        ),
                  ),
                  Text(
                    '${((widget.score / widget.total) * 100).round()}% doğru',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _ringColor,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
