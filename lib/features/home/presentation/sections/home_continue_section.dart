import 'package:app/config/theme/constants/color/basic_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/widgets/sections/app_section_header.dart';
import 'package:flutter/material.dart';

class HomeContinueSection extends StatelessWidget {
  const HomeContinueSection({
    required this.categoryName,
    required this.topicName,
    required this.onTap,
    super.key,
  });

  final String categoryName;
  final String topicName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const AppSectionHeader(title: AppStrings.homeContinueSectionTitle),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: Container(
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
                // Dekoratif arka plan dairesi
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
                            Icons.play_arrow_rounded,
                            color: BasicColor.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Kategori adı — küçük etiket
                              Text(
                                categoryName.toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: const Color.fromRGBO(255, 255, 255, 0.8),
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 2),
                              // Konu adı — ana başlık
                              Text(
                                topicName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                    const SizedBox(height: 14),
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
        ),
      ],
    );
  }
}
