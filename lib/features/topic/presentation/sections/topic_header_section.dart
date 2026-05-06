import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/features/topic/domain/entities/topic.dart';
import 'package:flutter/material.dart';

class TopicHeaderSection extends StatelessWidget {
  const TopicHeaderSection({
    required this.categoryTitle,
    required this.topics,
    super.key,
  });

  final String categoryTitle;
  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    final int completed = topics.where((Topic t) => t.isDone).length;
    final double progress =
        topics.isEmpty ? 0 : completed / topics.length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            categoryTitle,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: NeutralColor.neutral900,
                  letterSpacing: -0.5,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            '$completed / ${topics.length} konu tamamlandı',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: NeutralColor.neutral500,
                ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: NeutralColor.neutral200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                PrimaryColor.primary600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
