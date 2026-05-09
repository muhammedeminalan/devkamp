import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/features/quiz/domain/entities/quiz_question.dart';
import 'package:app/features/quiz/presentation/bloc/quiz_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:markdown/markdown.dart' as md;

class QuestionCardSection extends StatelessWidget {
  const QuestionCardSection({
    required this.question,
    required this.answerStage,
    required this.answerText,
    required this.onShowAnswer,
    required this.onRetry,
    required this.onStreamingDone,
    super.key,
  });

  final QuizQuestion question;
  final AnswerStage answerStage;
  final String? answerText;
  final VoidCallback onShowAnswer;
  final VoidCallback onRetry;
  final VoidCallback onStreamingDone;

  String get _diffLabel => switch (question.difficulty) {
        QuestionDifficulty.easy => 'Kolay',
        QuestionDifficulty.medium => 'Orta',
        QuestionDifficulty.hard => 'Zor',
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: NeutralColor.neutral200),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(17, 24, 39, 0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _Badge(label: question.topic, color: PrimaryColor.primary600, bg: PrimaryColor.primary50),
              const SizedBox(width: 8),
              _Badge(
                label: _diffLabel,
                color: const Color(0xFFB45309),
                bg: const Color(0xFFFEF3C7),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            question.text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: NeutralColor.neutral900,
                  height: 1.35,
                  letterSpacing: -0.3,
                ),
          ),
          if (answerStage == AnswerStage.hidden) ...<Widget>[
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onShowAnswer,
                child: const Text('Cevabı Gör'),
              ),
            ),
          ],
          if (answerStage == AnswerStage.loading) ...<Widget>[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 12),
            const _AiHeader(streaming: true),
            const SizedBox(height: 10),
            _SkeletonBlocks(),
          ],
          if (answerStage == AnswerStage.streaming && answerText != null) ...<Widget>[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 12),
            const _AiHeader(streaming: true),
            const SizedBox(height: 8),
            _StreamingText(text: answerText!, onDone: onStreamingDone),
          ],
          if (answerStage == AnswerStage.answered && answerText != null) ...<Widget>[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 12),
            const _AiHeader(streaming: false),
            const SizedBox(height: 8),
            _AnswerText(text: answerText!),
          ],
          if (answerStage == AnswerStage.error) ...<Widget>[
            const SizedBox(height: 16),
            _ErrorCard(onRetry: onRetry),
          ],
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color, required this.bg});

  final String label;
  final Color color;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
      ),
    );
  }
}

class _AiHeader extends StatelessWidget {
  const _AiHeader({required this.streaming});

  final bool streaming;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: PrimaryColor.primary600,
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Icon(Icons.bolt_rounded, color: Colors.white, size: 13),
        ),
        const SizedBox(width: 8),
        Text(
          'AI Cevabı',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: NeutralColor.neutral700,
              ),
        ),
        if (streaming) ...<Widget>[
          const SizedBox(width: 8),
          const _DotLoader(),
        ],
      ],
    );
  }
}

class _DotLoader extends StatefulWidget {
  const _DotLoader();

  @override
  State<_DotLoader> createState() => _DotLoaderState();
}

class _DotLoaderState extends State<_DotLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (BuildContext context, _) {
        return Row(
          children: List<Widget>.generate(3, (int i) {
            final double phase = (_ctrl.value * 3 - i).clamp(0.0, 1.0);
            final double opacity = 0.3 + phase * 0.7;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Opacity(
                opacity: opacity,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: PrimaryColor.primary600,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _SkeletonBlocks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        _Skeleton(widthFactor: 0.4),
        SizedBox(height: 8),
        _Skeleton(widthFactor: 1),
        SizedBox(height: 6),
        _Skeleton(widthFactor: 0.9),
        SizedBox(height: 6),
        _Skeleton(widthFactor: 0.65),
        SizedBox(height: 8),
        _Skeleton(widthFactor: 1, height: 56),
      ],
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton({required this.widthFactor, this.height = 13});

  final double widthFactor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: NeutralColor.neutral200,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}

class _StreamingText extends StatefulWidget {
  const _StreamingText({required this.text, required this.onDone});

  final String text;
  final VoidCallback onDone;

  @override
  State<_StreamingText> createState() => _StreamingTextState();
}

class _StreamingTextState extends State<_StreamingText> {
  int _visibleChars = 0;

  @override
  void initState() {
    super.initState();
    _stream();
  }

  Future<void> _stream() async {
    const int charsPerTick = 4;
    const Duration tickDuration = Duration(milliseconds: 20);
    final int total = widget.text.length;

    while (_visibleChars < total) {
      await Future<void>.delayed(tickDuration);
      if (!mounted) return;
      setState(() {
        _visibleChars = (_visibleChars + charsPerTick).clamp(0, total);
      });
    }

    widget.onDone();
  }

  @override
  Widget build(BuildContext context) {
    return _AnswerText(text: widget.text.substring(0, _visibleChars));
  }
}

// Gemini markdown formatında cevap ürettiği için MarkdownBody ile render ediyoruz.
class _AnswerText extends StatelessWidget {
  const _AnswerText({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: NeutralColor.neutral700,
          height: 1.65,
        );

    final MarkdownStyleSheet sheet = MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
      p: baseStyle,
      listBullet: baseStyle,
      code: baseStyle.copyWith(
        fontFamily: 'monospace',
        fontSize: 13,
        color: NeutralColor.neutral800,
        backgroundColor: NeutralColor.neutral100,
      ),
      blockquoteDecoration: BoxDecoration(
        color: PrimaryColor.primary50,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: PrimaryColor.primary600, width: 3)),
      ),
      blockquotePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );

    return MarkdownBody(
      data: text,
      builders: <String, MarkdownElementBuilder>{'code': _CodeBlockBuilder()},
      styleSheet: sheet,
    );
  }
}

// Atom One Dark temasıyla syntax highlighted kod bloğu render eder.
class _CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfterWithContext(
    BuildContext context,
    md.Element element,
    TextStyle? preferredStyle,
    TextStyle? parentStyle,
  ) {
    // Sadece blok kod için çalış (satır içi kod değil).
    final bool isBlock = element.attributes['class'] != null ||
        (element.textContent.contains('\n'));
    if (!isBlock) return null;

    final String language = element.attributes['class']
            ?.replaceFirst('language-', '') ??
        'dart';

    // Arka planı Container'a veriyoruz; HighlightView sadece metni render eder.
    // Böylece yatay kaydırmada kutu sabit kalır, sadece içerik kayar.
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF282C34), // atom-one-dark arka plan rengi
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: HighlightView(
          element.textContent.trimRight(),
          language: language,
          theme: atomOneDarkTheme,
          padding: const EdgeInsets.all(14),
          textStyle: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}


class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'AI cevabı yüklenemedi.',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: const Color(0xFFB91C1C),
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            'Bağlantını kontrol et ve tekrar dene.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF7F1D1D),
                ),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: onRetry,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFB91C1C),
              side: const BorderSide(color: Color(0xFFFECACA)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            child: const Text(
              'Tekrar Dene',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
