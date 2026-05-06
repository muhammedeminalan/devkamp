import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:flutter/material.dart';

class QuestionProgressSection extends StatelessWidget {
  const QuestionProgressSection({
    required this.currentIndex,
    required this.total,
    required this.isBookmarked,
    required this.onBack,
    required this.onBookmark,
    super.key,
  });

  final int currentIndex;
  final int total;
  final bool isBookmarked;
  final VoidCallback onBack;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    final double pct = (currentIndex + 1) / total;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Row(
        children: <Widget>[
          _NavButton(onTap: onBack, child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Soru ${currentIndex + 1} / $total',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: NeutralColor.neutral700,
                          ),
                    ),
                    Text(
                      '${(pct * 100).round()}%',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: NeutralColor.neutral500,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: pct,
                    minHeight: 6,
                    backgroundColor: NeutralColor.neutral200,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      PrimaryColor.primary600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _NavButton(
            onTap: onBookmark,
            child: Icon(
              isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              size: 18,
              color: isBookmarked ? PrimaryColor.primary600 : NeutralColor.neutral700,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Center(child: child),
      ),
    );
  }
}
