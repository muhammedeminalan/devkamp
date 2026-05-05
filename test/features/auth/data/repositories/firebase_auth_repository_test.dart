import 'package:app/core/errors/app_exception.dart';
import 'package:app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:app/features/auth/data/repositories/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class _MockUser extends Mock implements User {}

void main() {
  group('FirebaseAuthRepository', () {
    late _MockAuthRemoteDataSource remoteDataSource;
    late FirebaseAuthRepository repository;

    setUp(() {
      remoteDataSource = _MockAuthRemoteDataSource();
      repository = FirebaseAuthRepository(remoteDataSource: remoteDataSource);
    });

    test('getCurrentUser null doner', () async {
      when(() => remoteDataSource.currentUser).thenReturn(null);

      final result = await repository.getCurrentUser();

      expect(result, isNull);
    });

    test('getCurrentUser user mapler', () async {
      final User user = _MockUser();
      when(() => remoteDataSource.currentUser).thenReturn(user);
      when(() => user.uid).thenReturn('uid-1');
      when(() => user.displayName).thenReturn('Emin');
      when(() => user.email).thenReturn('emin@example.com');
      when(() => user.photoURL).thenReturn('https://cdn.dev/avatar.png');

      final result = await repository.getCurrentUser();

      expect(result, isNotNull);
      expect(result!.id, 'uid-1');
      expect(result.name, 'Emin');
      expect(result.email, 'emin@example.com');
      expect(result.avatarUrl, 'https://cdn.dev/avatar.png');
    });

    test('signInWithGoogle basarili giris yapar', () async {
      final User user = _MockUser();
      when(() => remoteDataSource.signInWithGoogle())
          .thenAnswer((_) async => user);
      when(() => user.uid).thenReturn('uid-google');
      when(() => user.displayName).thenReturn('Muhammed Emin');
      when(() => user.email).thenReturn('emin@devkamp.app');
      when(() => user.photoURL).thenReturn('https://cdn.dev/profile.png');

      final result = await repository.signInWithGoogle();

      expect(result.id, 'uid-google');
      expect(result.name, 'Muhammed Emin');
      expect(result.email, 'emin@devkamp.app');
      expect(result.avatarUrl, 'https://cdn.dev/profile.png');
      verify(() => remoteDataSource.signInWithGoogle()).called(1);
    });

    test('signInWithGoogle user null donerse exception firlatir', () async {
      when(() => remoteDataSource.signInWithGoogle())
          .thenAnswer((_) async => null);

      expect(
        repository.signInWithGoogle,
        throwsA(isA<AuthException>()),
      );
    });

    test('signOut datasource cagirir', () async {
      when(() => remoteDataSource.signOut()).thenAnswer((_) async {});

      await repository.signOut();

      verify(() => remoteDataSource.signOut()).called(1);
    });
  });
}
