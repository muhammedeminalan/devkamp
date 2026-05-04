import 'package:app/features/Auth/domain/entities/app_user.dart';
import 'package:app/features/Auth/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @override
  Future<AppUser?> getCurrentUser() async {
    final User? user = _firebaseAuth.currentUser;
    if (user == null) {
      return null;
    }
    return _mapUser(user);
  }

  @override
  Future<AppUser> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google giriş işlemi iptal edildi.');
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user == null) {
      throw Exception('Google hesabı ile girişten kullanıcı bilgisi alınamadı.');
    }

    return _mapUser(user);
  }

  @override
  Future<AppUser> signInWithEmail() async {
    throw Exception('E-posta ile giriş henüz aktif değil.');
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  AppUser _mapUser(User user) {
    return AppUser(
      id: user.uid,
      name: user.displayName ?? 'Kullanıcı',
      email: user.email ?? '',
      avatarUrl: user.photoURL,
    );
  }
}
