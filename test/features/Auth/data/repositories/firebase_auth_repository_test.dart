import 'package:app/features/Auth/data/repositories/firebase_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class _MockFirebaseAuth extends Mock implements FirebaseAuth {}

class _MockGoogleSignIn extends Mock implements GoogleSignIn {}

class _MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class _MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class _MockUserCredential extends Mock implements UserCredential {}

class _MockUser extends Mock implements User {}

class _FakeAuthCredential extends Fake implements AuthCredential {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeAuthCredential());
  });

  group('FirebaseAuthRepository', () {
    late _MockFirebaseAuth firebaseAuth;
    late _MockGoogleSignIn googleSignIn;
    late FirebaseAuthRepository repository;

    setUp(() {
      firebaseAuth = _MockFirebaseAuth();
      googleSignIn = _MockGoogleSignIn();
      repository = FirebaseAuthRepository(
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
      );
    });

    test('getCurrentUser null doner', () async {
      when(() => firebaseAuth.currentUser).thenReturn(null);

      final result = await repository.getCurrentUser();

      expect(result, isNull);
    });

    test('getCurrentUser user mapler', () async {
      final user = _MockUser();
      when(() => firebaseAuth.currentUser).thenReturn(user);
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
      final account = _MockGoogleSignInAccount();
      final auth = _MockGoogleSignInAuthentication();
      final credential = _MockUserCredential();
      final user = _MockUser();

      when(() => googleSignIn.signIn()).thenAnswer((_) async => account);
      when(() => account.authentication).thenAnswer((_) async => auth);
      when(() => auth.accessToken).thenReturn('access-token');
      when(() => auth.idToken).thenReturn('id-token');
      when(() => firebaseAuth.signInWithCredential(any()))
          .thenAnswer((_) async => credential);
      when(() => credential.user).thenReturn(user);
      when(() => user.uid).thenReturn('uid-google');
      when(() => user.displayName).thenReturn('Muhammed Emin');
      when(() => user.email).thenReturn('emin@devkamp.app');
      when(() => user.photoURL).thenReturn('https://cdn.dev/profile.png');

      final result = await repository.signInWithGoogle();

      expect(result.id, 'uid-google');
      expect(result.name, 'Muhammed Emin');
      expect(result.email, 'emin@devkamp.app');
      expect(result.avatarUrl, 'https://cdn.dev/profile.png');
      verify(() => googleSignIn.signIn()).called(1);
      verify(() => firebaseAuth.signInWithCredential(any())).called(1);
    });

    test('signInWithGoogle iptal edilirse exception firlatir', () async {
      when(() => googleSignIn.signIn()).thenAnswer((_) async => null);

      expect(
        repository.signInWithGoogle,
        throwsA(isA<Exception>()),
      );
    });

    test('signInWithGoogle user null donerse exception firlatir', () async {
      final account = _MockGoogleSignInAccount();
      final auth = _MockGoogleSignInAuthentication();
      final credential = _MockUserCredential();

      when(() => googleSignIn.signIn()).thenAnswer((_) async => account);
      when(() => account.authentication).thenAnswer((_) async => auth);
      when(() => auth.accessToken).thenReturn('access-token');
      when(() => auth.idToken).thenReturn('id-token');
      when(() => firebaseAuth.signInWithCredential(any()))
          .thenAnswer((_) async => credential);
      when(() => credential.user).thenReturn(null);

      expect(
        repository.signInWithGoogle,
        throwsA(isA<Exception>()),
      );
    });

    test('signOut hem firebase hem google signOut cagirir', () async {
      when(() => firebaseAuth.signOut()).thenAnswer((_) async {});
      when(() => googleSignIn.signOut()).thenAnswer((_) async => null);

      await repository.signOut();

      verify(() => firebaseAuth.signOut()).called(1);
      verify(() => googleSignIn.signOut()).called(1);
    });
  });
}
