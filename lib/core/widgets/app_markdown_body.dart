import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:markdown/markdown.dart' as md;

// Gemini markdown cevaplarını quiz ve saved ekranında tutarlı biçimde gösterir.
class AppMarkdownBody extends StatelessWidget {
  const AppMarkdownBody({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: NeutralColor.neutral700,
          height: 1.65,
        );

    final MarkdownStyleSheet sheet =
        MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
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
        border: Border(
          left: BorderSide(color: PrimaryColor.primary600, width: 3),
        ),
      ),
      blockquotePadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );

    return MarkdownBody(
      data: text,
      builders: <String, MarkdownElementBuilder>{
        'code': _CodeBlockBuilder(),
      },
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
    final bool isBlock = element.attributes['class'] != null ||
        element.textContent.contains('\n');
    if (!isBlock) return null;

    final String language =
        element.attributes['class']?.replaceFirst('language-', '') ?? 'dart';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF282C34),
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
