import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/extensions/project_extensions.dart';
import 'package:app/core/widgets/sections/app_section_header.dart';
import 'package:app/core/widgets/surfaces/app_surface_card.dart';
import 'package:app/core/widgets/loaders/small_button_loader.dart';
import 'package:flutter/material.dart';

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
