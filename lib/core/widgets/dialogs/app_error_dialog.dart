import 'package:flutter/material.dart';

// Kritik hata diyaloğu: kullanıcıyı durdurur, aksiyon almaya zorlar.
// Minor hatalar için AppSnackBar kullan.
Future<void> showAppErrorDialog(
  BuildContext context, {
  required String message,
  String title = 'Bir Hata Oluştu',
  // Birincil aksiyon (sağda, dolu buton): genellikle "Tekrar Dene"
  String? primaryLabel,
  VoidCallback? onPrimary,
  // İkincil aksiyon (solda, text buton): genellikle "Geri Dön"
  String? secondaryLabel,
  VoidCallback? onSecondary,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ctx) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        if (secondaryLabel != null)
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onSecondary?.call();
            },
            child: Text(secondaryLabel),
          ),
        if (primaryLabel != null)
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onPrimary?.call();
            },
            child: Text(primaryLabel),
          ),
        // Her iki label da null ise en az bir kapatma butonu göster.
        if (primaryLabel == null && secondaryLabel == null)
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Tamam'),
          ),
      ],
    ),
  );
}
