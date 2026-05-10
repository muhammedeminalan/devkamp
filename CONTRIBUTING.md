# Katkıda Bulunma Rehberi

DevKamp'a katkıda bulunmak istediğin için teşekkürler! Bu rehber süreci kolaylaştırmak için hazırlanmıştır.

## Başlamadan Önce

- Mevcut [issue'lara](https://github.com/muhammedeminalan/devkamp/issues) bak — belki zaten açılmış
- Büyük bir değişiklik yapmadan önce issue aç ve tartış
- [README.md](README.md) ile kurulum adımlarını takip et

## Geliştirme Süreci

**1. Fork et ve klonla**
```bash
git clone https://github.com/KULLANICI_ADIN/devkamp.git
cd devkamp
```

**2. Bağımlılıkları yükle**
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

**3. Özellik dalı oluştur**
```bash
git checkout -b feat/ozellik-adi
# ya da
git checkout -b fix/hata-adi
```

**4. Değişiklikleri yap ve test et**
```bash
flutter analyze
flutter test
```

**5. Commit at (Conventional Commits formatında)**
```bash
git commit -m "feat: yeni özellik açıklaması"
git commit -m "fix: hata düzeltmesi"
git commit -m "docs: dokümantasyon güncellemesi"
```

**6. PR aç**

GitHub üzerinden PR aç ve PR şablonunu doldur.

## Kod Standartları

- **Mimari:** Clean Architecture — katmanlara dikkat et (data / domain / presentation)
- **State Management:** BLoC pattern kullan
- **Analiz:** `flutter analyze` sıfır hata ile geçmeli
- **Dil:** Kod yorumları Türkçe, değişken/fonksiyon isimleri İngilizce
- **Stil:** `very_good_analysis` lint kuralları geçerli

## Commit Mesajı Formatı

[Conventional Commits](https://www.conventionalcommits.org/) standardını kullan:

| Prefix | Kullanım |
|--------|----------|
| `feat:` | Yeni özellik |
| `fix:` | Hata düzeltmesi |
| `refactor:` | Kod yeniden düzenleme |
| `docs:` | Dokümantasyon |
| `test:` | Test ekleme/düzenleme |
| `chore:` | Build, CI, araç güncellemeleri |

## Soru veya Yardım

Bir sorun mu var? [Issue aç](https://github.com/muhammedeminalan/devkamp/issues/new) veya mevcut issue'larda yorum yap.
