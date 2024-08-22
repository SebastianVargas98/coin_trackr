part of 'dependencies.dart';

final GetIt serviceLocator = GetIt.instance;

void initDependencies() {
  // External libraries
  serviceLocator.registerLazySingleton(() => http.Client());

  _initFirebase();
  _initCore();
  _initAuth();
  _initCrypto();
  _initProfile();

  // Managers
  serviceLocator
      .registerLazySingleton<NavigationManager>(() => NavigationManager());
}

void _initProfile() {
  // Datasources
  serviceLocator.registerLazySingleton<FirebaseProfileDataSource>(
      () => FirebaseProfileDataSourceImpl(firebaseAuth: serviceLocator()));
  serviceLocator.registerLazySingleton<FirestoreProfileDataSource>(
      () => FirestoreProfileDataSourceImpl(firestore: serviceLocator()));

  // Repositories
  serviceLocator
      .registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(
            firebaseDataSource: serviceLocator(),
            firestoreDataSource: serviceLocator(),
          ));

  // Use Cases
  serviceLocator.registerLazySingleton(
    () => UpdatePasswordUseCase(
        profileRepository: serviceLocator<ProfileRepository>()),
  );
  serviceLocator.registerLazySingleton(() => UpdateUserUseCase(
      profileRepository: serviceLocator<ProfileRepository>()));

  // Providers
  serviceLocator.registerLazySingleton(
    () => ProfileProvider(
      getCurrentUserUseCase: serviceLocator(),
      updateUserUseCase: serviceLocator(),
      updatePasswordUseCase: serviceLocator(),
      saveLocalUserUseCase: serviceLocator(),
    ),
  );
}

void _initCore() {
  // Datasources
  serviceLocator.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl());

  // Repositories
  serviceLocator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        userLocalDataSource: serviceLocator(),
      ));

  // Use Cases
  serviceLocator.registerLazySingleton(() =>
      GetCurrentUserUseCase(userRepository: serviceLocator<UserRepository>()));

  // Providers
  serviceLocator.registerLazySingleton(() => NavigationProvider());
}

void _initAuth() {
  // Datasources
  serviceLocator.registerFactory<FirebaseAuthDataSource>(
      () => FirebaseAuthDataSourceImpl(firebaseAuth: serviceLocator()));
  serviceLocator.registerFactory<FirestoreUserDataSource>(
      () => FirestoreUserDataSourceImpl(firestore: serviceLocator()));

  // Repositories
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        authDataSource: serviceLocator(),
        userDataSource: serviceLocator(),
      ));

  // Use Cases
  serviceLocator.registerFactory(
      () => LoginUseCase(authRepository: serviceLocator<AuthRepository>()));
  serviceLocator.registerFactory(
      () => RegisterUseCase(authRepository: serviceLocator<AuthRepository>()));
  serviceLocator.registerFactory(() =>
      SaveLocalUserUseCase(userRepository: serviceLocator<UserRepository>()));

  // Providers
  serviceLocator.registerLazySingleton(
    () => AuthProvider(
      loginUseCase: serviceLocator(),
      registerUseCase: serviceLocator(),
      saveLocalUserUseCase: serviceLocator(),
    ),
  );
}

void _initCrypto() {
  // Datasources
  serviceLocator.registerLazySingleton<CryptoRemoteDataSource>(
      () => CryptoRemoteDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerLazySingleton<FirestoreCryptoDataSource>(
      () => FirestoreCryptoDataSourceImpl(firestore: serviceLocator()));

  // Repositories
  serviceLocator
      .registerLazySingleton<CryptoRepository>(() => CryptoRepositoryImpl(
            cryptoRemoteDataSource: serviceLocator(),
            firestoreCryptoDataSource: serviceLocator(),
          ));

  // Use Cases
  serviceLocator.registerLazySingleton(
    () => GetCryptoListUseCase(
        cryptoRepository: serviceLocator<CryptoRepository>()),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteFavoriteCryptoUseCase(
        cryptoRepository: serviceLocator<CryptoRepository>()),
  );
  serviceLocator.registerLazySingleton(
    () => GetFavoritesCryptosUseCase(
        cryptoRepository: serviceLocator<CryptoRepository>()),
  );
  serviceLocator.registerLazySingleton(
    () => SetFavoriteCryptoUseCase(
        cryptoRepository: serviceLocator<CryptoRepository>()),
  );

  // Providers
  serviceLocator.registerLazySingleton(
    () => CryptoProvider(
      deleteFavoriteCryptoUseCase: serviceLocator(),
      getFavoritesCryptosUseCase: serviceLocator(),
      setFavoriteCryptoUseCase: serviceLocator(),
      getCryptoListUseCase: serviceLocator(),
      getCurrentUserUseCase: serviceLocator(),
    ),
  );
}

void _initFirebase() {
  serviceLocator.registerFactory<firestore.FirebaseFirestore>(
      () => firestore.FirebaseFirestore.instance);
  serviceLocator.registerFactory<firebase.FirebaseAuth>(
      () => firebase.FirebaseAuth.instance);
}
