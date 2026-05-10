import 'package:app/core/errors/app_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract interface class AuthRemoteDataSource {
  User? get currentUser;
  Future<User?> signInWithGoogle();
  Future<void> signOut();
}

@LazySingleton(as: AuthRemoteDataSource)
class FirebaseAuthRemoteDataSource implements AuthRemoteDataSource {
  FirebaseAuthRemoteDataSource();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException('Google giriş işlemi iptal edildi.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } on AuthException {
      rethrow;
    } on FirebaseAuthException catch (_) {
      throw const AuthException('Google ile giriş başarısız. Lütfen tekrar dene.');
    } on Exception catch (_) {
      throw const AuthException('Giriş sırasında bir hata oluştu. Lütfen tekrar dene.');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } on FirebaseAuthException catch (_) {
      throw const AuthException('Çıkış yapılırken bir hata oluştu.');
    } on Exception catch (_) {
      throw const AuthException('Çıkış yapılırken bir hata oluştu.');
    }
  }
}
