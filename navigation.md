# Navigation Rehberi (go_router + Clean Architecture)

Bu doküman projedeki mevcut navigasyon mimarisini ve yeni ekran ekleme adımlarını anlatır.

## 1) Mevcut Mimari

- Router merkezi: `lib/config/router/app_router.dart`
- App giriş: `lib/main.dart` içinde `MaterialApp.router`
- Auth state kaynağı: `AuthBloc` (`unknown`, `unauthenticated`, `authenticated`)
- Router refresh: `RouterRefreshNotifier` (`AuthBloc.stream` dinliyor)
- Alt sekme yapısı: `StatefulShellRoute.indexedStack`

## 2) Aktif Route Yapısı

- Public:
- `/splash`
- `/auth`
- Private (shell içinde):
- `/home`
- `/saved`
- `/profile`

## 3) Redirect Kuralları (Tek Gerçek Kaynak)

- `AuthStatus.unknown`
- Sadece `/splash` serbest
- Diğer her route `/splash`

- `AuthStatus.unauthenticated`
- Sadece `/auth` serbest
- Diğer her route `/auth`

- `AuthStatus.authenticated`
- `/splash` veya `/auth` istekleri `/home`
- Private route'lar serbest

## 4) Sayfalar Arası Geçiş Nasıl Yapılır

- Route değiştir (stack temiz):
```dart
context.go('/home');
```

- Üste yeni sayfa aç (stack koru):
```dart
context.push('/topic/flutter');
```

- Geri dön:
```dart
context.pop();
```

- Sonuç döndürerek geri dön:
```dart
context.pop(true);
```

Not: Alt sekmeler arası geçiş `context.go` ile değil shell içindeki `goBranch` ile yönetiliyor (`MainShellScaffold`).

## 5) Veri Transferi Yöntemleri

### A) Path Param (önerilen, kalıcı/deeplink uyumlu)

Route:
```dart
GoRoute(
  path: '/question/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return QuestionView(questionId: id);
  },
)
```

Kullanım:
```dart
context.push('/question/42');
```

### B) Query Param (filtre/sıralama için)

Kullanım:
```dart
context.push('/saved?filter=flutter&sort=recent');
```

Okuma:
```dart
final filter = state.uri.queryParameters['filter'];
final sort = state.uri.queryParameters['sort'];
```

### C) Extra (ekran içi model taşıma, geçici)

Kullanım:
```dart
context.push('/result', extra: myResultModel);
```

Okuma:
```dart
final result = state.extra as ResultModel;
```

Risk: `extra`, deep link ve cold start senaryolarında güvenilir değildir. Kritik veri için `path/query` kullan.

## 6) Yeni Sayfa Eklerken Ne Değişecek

### Senaryo 1: Tab dışı private sayfa (örn: Topic, Question, Result)

1. Feature ekran dosyasını oluştur.
2. `app_router.dart` içine path constant ekle.
3. Shell branch altına veya ilgili branch içindeki `routes` listesine `GoRoute` ekle.
4. Eğer route private ise redirect kuralına ekstra bir şey ekleme gerekmez (zaten auth guard var).
5. Geçişi `context.push(...)` veya `context.go(...)` ile bağla.

### Senaryo 2: Yeni bottom tab sayfası

1. Yeni view dosyasını oluştur.
2. `StatefulShellRoute.indexedStack` içine yeni `StatefulShellBranch` ekle.
3. `MainShellScaffold` içinde `NavigationDestination` ekle.
4. Sıralamayı branch index ile aynı tut.

### Senaryo 3: Public sayfa (örn: onboarding, forgot-password)

1. `GoRoute` ekle.
2. Redirect kuralında bu route'un hangi auth durumunda açık olacağına karar ver.
3. Aksi halde guard sayfayı otomatik `/auth` veya `/home`a çevirir.

## 7) Clean Architecture Kuralı

- Navigation kararı `router + auth state` ile verilir.
- UI katmanı `Navigator.push` kullanmaz, `go_router` API kullanır.
- Auth kontrolü view içinde if/else ile yapılmaz.
- Data kaynağı değişse de (`FakeAuthRepository` -> gerçek servis) router ve ekranlar değişmez.

## 8) Fake -> Gerçek Auth Geçişinde Ne Değişecek

- Değişecek yer:
- `lib/features/Auth/data/repositories/fake_auth_repository.dart`
- `main.dart` içinde repository injection

- Değişmeyecek yer:
- `AuthBloc` event/state akışı
- `AppRouter` redirect mantığı
- Ekranların route kullanımı

## 9) Hızlı Kontrol Listesi

- Yeni route eklendi mi?
- Path constant tanımlandı mı?
- Redirect etkisi kontrol edildi mi?
- Route'a param geliyorsa null-safe okuma yapıldı mı?
- `flutter analyze` temiz mi?

