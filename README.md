<div align="center">
  <img src="assets/svg/dev_kamp_logo.svg" width="100" height="100" alt="DevKamp Logo" />
  <h1>DevKamp</h1>
  <p><strong>AI destekli teknik mülakat hazırlık uygulaması</strong></p>

  [![CI](https://github.com/muhammedeminalan/devkamp/actions/workflows/ci.yml/badge.svg)](https://github.com/muhammedeminalan/devkamp/actions/workflows/ci.yml)
  [![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
  [![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
</div>

---

## Nedir?

DevKamp, yazılım geliştiricilerin teknik mülakata hazırlanmasına yardımcı olan açık kaynaklı bir Flutter uygulamasıdır. Gemini AI ile desteklenen soru-cevap sistemi, Firestore tabanlı ilerleme takibi ve konu bazlı kategori yapısıyla kişiselleştirilmiş bir öğrenme deneyimi sunar.

## Özellikler

- **AI Destekli Cevaplar** — Gemini ile her soruya anlık, detaylı yanıt
- **Konu Bazlı Quizler** — Dart, Flutter, asenkron programlama ve daha fazlası
- **Rastgele Quiz Modu** — Farklı konulardan karışık soru akışı
- **İlerleme Takibi** — Streak, puan ve kategori performansı
- **Soru Kaydetme** — Tekrar çalışmak istediğin soruları işaretle
- **Çok Dilli** — Türkçe arayüz (i18n altyapısı hazır)
- **Google ile Giriş** — Firebase Auth entegrasyonu

## Ekran Görüntüleri

> Yakında eklenecek

## Teknoloji Yığını

| Katman | Teknoloji |
|--------|-----------|
| Framework | Flutter 3.x / Dart 3.x |
| State Management | flutter_bloc |
| Navigation | go_router |
| DI | get_it + injectable |
| Backend | Firebase (Auth + Firestore) |
| AI | Google Gemini API |
| Modeller | freezed + json_serializable |
| Mimari | Clean Architecture |

## Kurulum

### Gereksinimler

- Flutter SDK `>=3.4.0`
- Dart SDK `>=3.4.0`
- Firebase projesi (Auth + Firestore etkin)
- Gemini API anahtarı

### Adımlar

**1. Repoyu klonla**
```bash
git clone https://github.com/muhammedeminalan/devkamp.git
cd devkamp
```

**2. Bağımlılıkları yükle**
```bash
flutter pub get
```

**3. Ortam değişkenlerini ayarla**

`.env.example` dosyasını kopyala ve kendi anahtarlarını ekle:
```bash
cp .env.example .env
```

```env
GEMINI_API_KEY=your_gemini_api_key_here
```

**4. Firebase ayarla**

[Firebase CLI](https://firebase.google.com/docs/cli) ile proje bağla:
```bash
flutterfire configure
```

**5. Kod üretimini çalıştır**
```bash
dart run build_runner build --delete-conflicting-outputs
```

**6. Uygulamayı başlat**
```bash
flutter run
```

## Proje Yapısı

```
lib/
├── app/                    # Uygulama katmanı (entry point, navigation)
├── bootstrap/              # DI başlatma, app bootstrap
├── config/                 # Tema, router, DI modülü
├── core/                   # Paylaşılan yardımcılar (result, errors, widgets)
├── features/
│   ├── auth/               # Google ile giriş/çıkış
│   ├── category/           # Kategori listeleme ve AI üretimi
│   ├── home/               # Ana sayfa, ilerleme, son oturum
│   ├── profile/            # Profil, streak, başarımlar
│   ├── quiz/               # Quiz akışı ve AI cevaplar
│   ├── saved/              # Kaydedilen sorular
│   ├── splash/             # Splash ekranı
│   └── topic/              # Konu listeleme
└── l10n/                   # Lokalizasyon dosyaları
```

## Katkıda Bulunma

Katkıda bulunmak ister misin? [CONTRIBUTING.md](CONTRIBUTING.md) dosyasına göz at.

## Lisans

Bu proje [MIT Lisansı](LICENSE) ile lisanslanmıştır.

---

<div align="center">
  <sub>Muhammed Emin Alan tarafından yapılmıştır &mdash; <a href="https://github.com/muhammedeminalan">@muhammedeminalan</a></sub>
</div>
