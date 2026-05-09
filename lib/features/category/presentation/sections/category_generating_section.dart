import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';

// Kategoriler AI tarafından üretilirken gösterilen yükleme ekranı.
class CategoryGeneratingSection extends StatefulWidget {
  const CategoryGeneratingSection({super.key});

  @override
  State<CategoryGeneratingSection> createState() =>
      _CategoryGeneratingSectionState();
}

class _CategoryGeneratingSectionState extends State<CategoryGeneratingSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _fade = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: PrimaryColor.primary600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.bolt_rounded,
                    color: Colors.white, size: 16),
              ),
              const SizedBox(width: 10),
              FadeTransition(
                opacity: _fade,
                child: Text(
                  AppStrings.categoryGenerating,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: PrimaryColor.primary600,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ..._skeletonCards(),
        ],
      ),
    );
  }

  List<Widget> _skeletonCards() {
    return List<Widget>.generate(5, (int i) {
      return AnimatedBuilder(
        animation: _ctrl,
        builder: (BuildContext ctx, _) {
          return Opacity(
            opacity: _fade.value,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              height: 72,
              decoration: BoxDecoration(
                color: NeutralColor.neutral200,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          );
        },
      );
    });
  }
}
