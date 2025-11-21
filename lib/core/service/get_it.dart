import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:suits/core/api/api_service.dart';
import 'package:suits/features/auth/presentation/cubits/google_cubit/google_cubit.dart';
import 'package:suits/features/cart/data/repo/cart_repo_impl.dart';
import 'package:suits/features/cart/domain/repo/cart_repo.dart';
import 'package:suits/features/cart/presentation/cubits/cart/cart_cubit.dart';
import 'package:suits/features/favorite/data/repo/fav_repo_impl.dart';
import 'package:suits/features/favorite/data/service/fav_service.dart';
import 'package:suits/features/favorite/domain/repo/fav_repo.dart';
import 'package:suits/features/favorite/presentation/cubits/favorite/favorite_cubit.dart';
import 'package:suits/features/home/data/repo/product_repo_impl.dart';
import 'package:suits/features/home/domain/repo/product_repo.dart';
import 'package:suits/features/home/presentation/cubits/get_product/get_product_cubit.dart';
import '../../features/auth/data/repo/auth_repo_implement.dart';
import '../../features/auth/data/repo/otp_repo_implement.dart';
import '../../features/auth/data/service/firebase_auth.dart';
import '../../features/auth/data/service/otp_service.dart';
import '../../features/auth/domain/repo/auth_repo.dart';
import '../../features/auth/domain/repo/otp_repo.dart';
import '../../features/auth/presentation/cubits/forget_password_cubit/forget_password_cubit.dart';
import '../../features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import '../../features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import '../../features/auth/presentation/cubits/signout_cubit/signout_cubit.dart';
import '../../features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import '../../features/cart/data/services/cart_firestore_service.dart';

/*
 * this file is responsible for setting up the GetIt service locator
 * it registers services, repositories, and cubits for dependency injection
 * to use, call getIt<T>() to retrieve an instance of type T
 * for example, getIt<ApiService>() returns the registered ApiService instance
 * make sure to call getItSetup() during app initialization
 */
final getIt = GetIt.instance;
final userId = FirebaseAuth.instance.currentUser!.uid;
Future<void> getItSetup() async {
  // services
  getIt.registerLazySingleton<FirebaseService>(() => FirebaseService());
  getIt.registerLazySingleton<OtpService>(() => OtpService());
  getIt.registerLazySingleton<ApiService>(() => ApiService(Dio()));

  getIt.registerLazySingleton<CartService>(
    () => CartService(firestore: FirebaseFirestore.instance),
  );

  getIt.registerLazySingleton<FavoriteService>(
    () => FavoriteService(firestore: FirebaseFirestore.instance),
  );
  // repo
  getIt.registerLazySingleton<FirebaseAuthRepo>(
    () => FirebaseAuthRepoImplement(getIt<FirebaseService>()),
  );
  getIt.registerLazySingleton<OtpRepository>(
    () => OtpRepositoryImpl(otpService: getIt<OtpService>()),
  );
  getIt.registerLazySingleton<ProductRepo>(
    () => ProductRepoImpl(ApiService(Dio())),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(service: getIt<CartService>()),
  );

  getIt.registerLazySingleton<FavoriteRepository>(
    () => FavoriteRepositoryImpl(
      service: FavoriteService(firestore: FirebaseFirestore.instance),
    ),
  );

  // Cubits
  getIt.registerFactory(() => SignupCubit(getIt()));
  getIt.registerFactory(() => LoginCubit(getIt()));
  getIt.registerFactory(() => SignoutCubit(getIt()));
  getIt.registerFactory(() => OtpCubit(getIt()));
  getIt.registerFactory(() => ForgetPasswordCubit(getIt()));
  getIt.registerFactory(() => GoogleCubit(getIt()));
  getIt.registerFactory(() => GetProductCubit(getIt()));
  getIt.registerFactory(() => CartCubit(repository: getIt<CartRepository>()));
  getIt.registerFactory(
    () => FavoriteCubit(repository: getIt<FavoriteRepository>()),
  );
}
