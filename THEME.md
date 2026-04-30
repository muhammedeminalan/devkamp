# DevKamp Theme Kullanımı

Bu proje sadece `light mode` kullanır ve tema kaynağı `AppTheme.light` dosyasıdır.

## Tema Girişi

- Uygulama teması: `lib/config/theme/app_theme.dart`
- MaterialApp kullanımı:

```dart
MaterialApp(
  theme: AppTheme.light,
)
```

## Renk Paleti Dosyaları

- `PrimaryColor` -> `lib/config/theme/constants/color/primary_color.dart`
- `SuccessColor` -> `lib/config/theme/constants/color/success_color.dart`
- `ErrorColor` -> `lib/config/theme/constants/color/error_color.dart`
- `WarningColor` -> `lib/config/theme/constants/color/warning_color.dart`
- `NeutralColor` -> `lib/config/theme/constants/color/neutral_color.dart`
- `BasicColor` -> `lib/config/theme/constants/color/basic_color.dart`

## Hangi Renk Nerede Kullanılır

- `PrimaryColor`
- Marka rengi, ana CTA butonları, aktif durumlar.
- Ana renk: `primary600` (`#4F46E5`)

- `SuccessColor`
- Başarılı işlemler, onay mesajları, success badge.
- Ana renk: `success500` (`#10B981`)

- `ErrorColor`
- Hata durumları, validation error, kritik uyarılar.
- Ana renk: `error500` (`#EF4444`)

- `WarningColor`
- Dikkat gerektiren ama kritik olmayan durumlar.
- Ana renk: `warning500` (`#F59E0B`)

- `NeutralColor`
- Arka plan, yüzey, border, ikincil metin.
- Örnek:
- Sayfa arka planı: `neutral50`
- Koyu metin: `neutral900`

- `BasicColor`
- Saf yardımcı renkler: `white`, `black`, `transparent`
- Kod bloğu görselleri: `codeBg`, `codeInk`

## Shade Kullanım Rehberi

- `50-100`: Çok açık arka planlar
- `200-300`: Border/disabled yüzey
- `400-500`: İkincil vurgu
- `600`: Ana aksiyon tonu
- `700-900`: Basılı/yoğun vurgu
- `950`: Çok koyu özel kullanım

## Örnek Kullanım

```dart
Container(
  color: PrimaryColor.primary600,
  child: Text(
    'Basla',
    style: context.textTheme.labelLarge?.copyWith(
      color: BasicColor.white,
    ),
  ),
)
```

```dart
Text(
  'Hata olustu',
  style: context.textTheme.bodyMedium?.copyWith(
    color: ErrorColor.error500,
  ),
)
```

## Not

- Yeni UI geliştirirken önce semantic renk sınıfını seç (`Primary/Success/Error/Warning/Neutral`), sonra gerekli shade’i seç.
- Hard-coded hex renk kullanma, palette dışına çıkma.
