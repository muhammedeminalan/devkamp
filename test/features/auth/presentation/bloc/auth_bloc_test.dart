import 'package:app/core/errors/app_exception.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/auth/domain/entities/app_user.dart';
import 'package:app/features/auth/domain/usecases/check_session_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_in_with_email_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/profile/domain/usecases/update_streak_usecase.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckSessionUseCase extends Mock implements CheckSessionUseCase {}

class MockSignInWithGoogleUseCase extends Mock
    implements SignInWithGoogleUseCase {}

class MockSignInWithEmailUseCase extends Mock
    implements SignInWithEmailUseCase {}

class MockSignOutUseCase extends Mock implements SignOutUseCase {}

class MockUpdateStreakUseCase extends Mock implements UpdateStreakUseCase {}

const AppUser _testUser = AppUser(
  id: 'test-uid-123',
  name: 'Test Kullanıcı',
  email: 'test@example.com',
);

void main() {
  late MockCheckSessionUseCase mockCheckSession;
  late MockSignInWithGoogleUseCase mockSignInGoogle;
  late MockSignInWithEmailUseCase mockSignInEmail;
  late MockSignOutUseCase mockSignOut;
  late MockUpdateStreakUseCase mockUpdateStreak;

  setUp(() {
    mockCheckSession = MockCheckSessionUseCase();
    mockSignInGoogle = MockSignInWithGoogleUseCase();
    mockSignInEmail = MockSignInWithEmailUseCase();
    mockSignOut = MockSignOutUseCase();
    mockUpdateStreak = MockUpdateStreakUseCase();
    when(() => mockUpdateStreak()).thenAnswer((_) async => const Success(null));
  });

  AuthBloc buildBloc({AppUser? initialUser}) => AuthBloc(
        checkSessionUseCase: mockCheckSession,
        signInWithGoogleUseCase: mockSignInGoogle,
        signInWithEmailUseCase: mockSignInEmail,
        signOutUseCase: mockSignOut,
        updateStreakUseCase: mockUpdateStreak,
        initialUser: initialUser,
      );

  group('AuthBloc —', () {
    group('başlangıç durumu', () {
      test('initialUser null ise unauthenticated durumda başlar', () {
        final AuthBloc bloc = buildBloc();

        expect(
          bloc.state,
          const AuthState(status: AuthStatus.unauthenticated),
        );
      });

      test('initialUser varsa authenticated durumda başlar', () {
        final AuthBloc bloc = buildBloc(initialUser: _testUser);

        expect(bloc.state.status, AuthStatus.authenticated);
        expect(bloc.state.user, _testUser);
      });
    });

    group('AuthSignInWithGoogleRequested', () {
      blocTest<AuthBloc, AuthState>(
        'Google girişi başarılı olursa authenticated emitler',
        build: () {
          when(() => mockSignInGoogle()).thenAnswer((_) async => _testUser);
          return buildBloc();
        },
        act: (AuthBloc bloc) => bloc.add(const AuthSignInWithGoogleRequested()),
        expect: () => <AuthState>[
          const AuthState(status: AuthStatus.unauthenticated, isLoading: true),
          const AuthState(status: AuthStatus.authenticated, user: _testUser),
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'Google girişi başarısız olursa hata mesajı emitler',
        build: () {
          when(
            () => mockSignInGoogle(),
          ).thenThrow(const AuthException('Google girişi başarısız'));
          return buildBloc();
        },
        act: (AuthBloc bloc) => bloc.add(const AuthSignInWithGoogleRequested()),
        expect: () => <Object?>[
          const AuthState(status: AuthStatus.unauthenticated, isLoading: true),
          isA<AuthState>()
              .having(
                (AuthState state) => state.status,
                'status',
                AuthStatus.unauthenticated,
              )
              .having(
                (AuthState state) => state.errorMessage,
                'errorMessage',
                contains('Google ile giriş başarısız:'),
              ),
        ],
      );
    });

    group('AuthSignOutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'çıkış yapılınca unauthenticated emitler',
        build: () {
          when(() => mockSignOut()).thenAnswer((_) async {});
          return buildBloc(initialUser: _testUser);
        },
        act: (AuthBloc bloc) => bloc.add(const AuthSignOutRequested()),
        expect: () => <AuthState>[
          const AuthState(
            status: AuthStatus.authenticated,
            user: _testUser,
            isLoading: true,
          ),
          const AuthState(status: AuthStatus.unauthenticated),
        ],
      );
    });
  });
}
