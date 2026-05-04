import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:app/core/constants/text/app_strings.dart';
import 'package:app/core/widgets/small_button_loader.dart';
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
        Text(
          AppStrings.profileSettingsTitle,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: NeutralColor.neutral900,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: NeutralColor.neutral100),
          ),
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
                            AppStrings.profileSignOut,
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
                AppStrings.profileSettingNotifications,
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
                AppStrings.profileSettingReminder,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Text(
              AppStrings.profileReminderTime,
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
