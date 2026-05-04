import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({
    required this.name,
    required this.email,
    super.key,
  });

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    final String initial =
        (name.isNotEmpty ? name.characters.first : 'U').toUpperCase();

    return Column(
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[PrimaryColor.primary500, Color(0xFF8B5CF6)],
                ),
                border: Border.all(color: BasicColor.white, width: 3),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(99, 102, 241, 0.35),
                    blurRadius: 28,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: BasicColor.white,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ),
            Positioned(
              right: -4,
              bottom: -2,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      PrimaryColor.primary500,
                      PrimaryColor.primary700,
                    ],
                  ),
                  border: Border.all(color: BasicColor.white, width: 2.5),
                ),
                alignment: Alignment.center,
                child: Text(
                  '5',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: BasicColor.white,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: NeutralColor.neutral900,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          email,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: NeutralColor.neutral500,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: PrimaryColor.primary100,
          ),
          child: Text(
            '${AppStrings.profileLevelLabel} 🚀',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: PrimaryColor.primary700,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ],
    );
  }
}
