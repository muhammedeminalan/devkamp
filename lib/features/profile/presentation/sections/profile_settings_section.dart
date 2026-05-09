import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/core/locale/locale_cubit.dart';
import 'package:app/core/widgets/sections/app_section_header.dart';
import 'package:app/core/widgets/surfaces/app_surface_card.dart';
import 'package:app/core/widgets/loaders/small_button_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSettingsSection extends StatelessWidget {
  const ProfileSettingsSection({
    required this.onSignOut,
    required this.isSigningOut,
    super.key,
  });

  final VoidCallback onSignOut;
  final bool isSigningOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppSectionHeader(title: context.l10n.profileSettingsTitle),
        const SizedBox(height: 10),
        AppSurfaceCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: <Widget>[
              const _LanguageRow(),
              const _Divider(),
              const _NotificationRow(),
              const _Divider(),
              const _ReminderRow(),
              const _Divider(),
              InkWell(
                onTap: isSigningOut ? null : onSignOut,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
                child: SizedBox(
                  height: 52,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            context.l10n.profileSignOut,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFFEF4444),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        if (isSigningOut) const SmallButtonLoader(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, color: Color(0xFFF3F4F6));
  }
}

class _NotificationRow extends StatefulWidget {
  const _NotificationRow();

  @override
  State<_NotificationRow> createState() => _NotificationRowState();
}

class _NotificationRowState extends State<_NotificationRow> {
  bool value = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                context.l10n.profileSettingNotifications,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Switch.adaptive(
              value: value,
              activeTrackColor: PrimaryColor.primary600,
              onChanged: (bool next) => setState(() => value = next),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReminderRow extends StatelessWidget {
  const _ReminderRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                context.l10n.profileSettingReminder,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Text(
              context.l10n.profileReminderTime,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: NeutralColor.neutral500,
                  ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded, color: NeutralColor.neutral400),
          ],
        ),
      ),
    );
  }
}

// Dil seçimi satırı — mevcut dili gösterir, tıklanınca seçim modalı açılır.
class _LanguageRow extends StatelessWidget {
  const _LanguageRow();

  String _currentLabel(BuildContext context, Locale? locale) {
    if (locale == null) return context.l10n.profileLanguageSystem;
    if (locale.languageCode == 'tr') return context.l10n.profileLanguageTurkish;
    return context.l10n.profileLanguageEnglish;
  }

  void _showPicker(BuildContext context) {
    final LocaleCubit cubit = context.read<LocaleCubit>();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext sheetCtx) {
        return BlocProvider<LocaleCubit>.value(
          value: cubit,
          child: BlocBuilder<LocaleCubit, Locale?>(
            builder: (BuildContext ctx, Locale? selected) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      ctx.l10n.profileSettingLanguage,
                      style: ctx.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 16),
                    _LanguageOption(
                      flag: '📱',
                      label: ctx.l10n.profileLanguageSystem,
                      isSelected: selected == null,
                      onTap: () {
                        cubit.resetToDevice();
                        Navigator.of(sheetCtx).pop();
                      },
                    ),
                    const SizedBox(height: 8),
                    _LanguageOption(
                      flag: '🇹🇷',
                      label: ctx.l10n.profileLanguageTurkish,
                      isSelected: selected?.languageCode == 'tr',
                      onTap: () {
                        cubit.changeLocale(const Locale('tr'));
                        Navigator.of(sheetCtx).pop();
                      },
                    ),
                    const SizedBox(height: 8),
                    _LanguageOption(
                      flag: '🇬🇧',
                      label: ctx.l10n.profileLanguageEnglish,
                      isSelected: selected?.languageCode == 'en',
                      onTap: () {
                        cubit.changeLocale(const Locale('en'));
                        Navigator.of(sheetCtx).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Locale? locale = context.watch<LocaleCubit>().state;
    return InkWell(
      onTap: () => _showPicker(context),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: SizedBox(
        height: 52,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  context.l10n.profileSettingLanguage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Text(
                _currentLabel(context, locale),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: NeutralColor.neutral500,
                    ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right_rounded, color: NeutralColor.neutral400),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.flag,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String flag;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? PrimaryColor.primary50 : const Color(0xFFF9FAFB),
          border: Border.all(
            color: isSelected ? PrimaryColor.primary400 : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: <Widget>[
            Text(flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? PrimaryColor.primary700
                          : NeutralColor.neutral800,
                    ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_rounded,
                color: PrimaryColor.primary600,
                size: 18,
              ),
          ],
        ),
      ),
    );
  }
}
