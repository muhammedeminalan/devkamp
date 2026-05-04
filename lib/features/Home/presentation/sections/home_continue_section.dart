import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:flutter/material.dart';

class HomeContinueSection extends StatelessWidget {
  const HomeContinueSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          AppStrings.homeContinueSectionTitle,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                PrimaryColor.primary600,
                PrimaryColor.primary500,
                Color(0xFF8B5CF6),
              ],
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(79, 70, 229, 0.32),
                blurRadius: 32,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -30,
                right: -30,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: <Color>[
                        Color.fromRGBO(255, 255, 255, 0.18),
                        Color.fromRGBO(255, 255, 255, 0),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color.fromRGBO(255, 255, 255, 0.18),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.flutter_dash_rounded,
                      color: BasicColor.white,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppStrings.homeContinueTag,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: const Color.fromRGBO(255, 255, 255, 0.8),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          AppStrings.homeContinueTitle,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: BasicColor.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: -0.2,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppStrings.homeContinueStats,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: const Color.fromRGBO(255, 255, 255, 0.9),
                        ),
                  ),
                  Text(
                    AppStrings.homeContinuePercent,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: BasicColor.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: const LinearProgressIndicator(
                  value: 0.42,
                  minHeight: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(BasicColor.white),
                  backgroundColor: Color.fromRGBO(255, 255, 255, 0.25),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    AppStrings.homeContinueButton,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: BasicColor.white,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: BasicColor.white,
                  ),
                ],
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
