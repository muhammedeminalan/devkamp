import 'package:app/config/theme/constants/color/neutral_color.dart';
import 'package:app/config/theme/constants/color/primary_color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({
    required this.userName,
    required this.streakDays,
    this.avatarUrl,
    super.key,
  });

  final String userName;
  final int streakDays;
  final String? avatarUrl;

  // Streak sayısına ve günün saatine göre dinamik motivasyon mesajı üretir.
  String _motivationText() {
    final int hour = DateTime.now().hour;

    if (streakDays == 0) {
      if (hour < 12) return 'Güne iyi bir başlangıç yap 🎯';
      if (hour < 18) return 'Bugün ilk soruyu çöz 💡';
      return 'Geceyi verimli geçir 🌙';
    }

    if (streakDays == 1) return 'İyi başladın, devam et! 💪';
    if (streakDays < 5) return '$streakDays günlük serini koru 🔥';
    if (streakDays < 15) return '$streakDays gündür aralıksız çalışıyorsun 🚀';
    return '$streakDays günlük efsane seri! 👑';
  }

  // İsmin baş harfini avatar olarak gösterir.
  String get _avatarLetter =>
      userName.isNotEmpty ? userName[0].toUpperCase() : '?';

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // Sol: selamlama + motivasyon
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Merhaba, $userName',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: NeutralColor.neutral500,
                      fontWeight: FontWeight.w500,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                _motivationText(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: NeutralColor.neutral900,
                      letterSpacing: -0.4,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Sağ: profil avatarı — tıklanınca profil sayfasına gider
        GestureDetector(
          onTap: () => context.go('/profile'),
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(79, 70, 229, 0.28),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 21,
              // Fotoğraf varsa göster, yoksa gradient + baş harf
              backgroundImage:
                  avatarUrl != null ? NetworkImage(avatarUrl!) : null,
              backgroundColor: Colors.transparent,
              child: avatarUrl == null
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: <Color>[
                            PrimaryColor.primary500,
                            PrimaryColor.primary700,
                          ],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _avatarLetter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
