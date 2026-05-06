import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/features/topic/domain/entities/topic.dart';
import 'package:flutter/material.dart';

class TopicListSection extends StatelessWidget {
  const TopicListSection({
    required this.topics,
    required this.onTopicTap,
    super.key,
  });

  final List<Topic> topics;
  final ValueChanged<Topic> onTopicTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Column(
        children: topics
            .map((Topic t) => _TopicRow(topic: t, onTap: () => onTopicTap(t)))
            .toList(),
      ),
    );
  }
}

class _TopicRow extends StatelessWidget {
  const _TopicRow({required this.topic, required this.onTap});

  final Topic topic;
  final VoidCallback onTap;

  Color get _diffColor => switch (topic.difficulty) {
        TopicDifficulty.easy => const Color(0xFF047857),
        TopicDifficulty.medium => const Color(0xFFB45309),
        TopicDifficulty.hard => const Color(0xFFB91C1C),
      };

  Color get _diffBg => switch (topic.difficulty) {
        TopicDifficulty.easy => const Color(0xFFD1FAE5),
        TopicDifficulty.medium => const Color(0xFFFEF3C7),
        TopicDifficulty.hard => const Color(0xFFFEE2E2),
      };

  String get _diffLabel => switch (topic.difficulty) {
        TopicDifficulty.easy => 'Başlangıç',
        TopicDifficulty.medium => 'Orta',
        TopicDifficulty.hard => 'İleri',
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: NeutralColor.neutral200),
            ),
            child: Row(
              children: <Widget>[
                _DoneIndicator(isDone: topic.isDone),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        topic.name,
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: NeutralColor.neutral900,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: _diffBg,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              _diffLabel,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: _diffColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 10,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${topic.questionCount} soru',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: NeutralColor.neutral500,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: NeutralColor.neutral400,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DoneIndicator extends StatelessWidget {
  const _DoneIndicator({required this.isDone});

  final bool isDone;

  @override
  Widget build(BuildContext context) {
    if (isDone) {
      return Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: Color(0xFF10B981),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.check_rounded, color: Colors.white, size: 14),
      );
    }
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: NeutralColor.neutral300,
          style: BorderStyle.solid,
          width: 1.5,
        ),
      ),
    );
  }
}
