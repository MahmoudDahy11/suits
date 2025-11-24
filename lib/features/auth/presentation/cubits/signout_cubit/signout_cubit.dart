import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:suits/features/auth/domain/repo/auth_repo.dart';

import '../../../../cart/data/services/cart_firestore_service.dart';
import '../../../../cart/domain/repo/cart_repo.dart';
import '../../../../favorite/data/service/fav_service.dart';
import '../../../../favorite/domain/repo/fav_repo.dart';

part 'signout_state.dart';

/*
 * SignoutCubit class
 * extends Cubit with SignoutState
 * manages the state for user sign-out
 * uses FirebaseAuthRepo for authentication operations
 * emits loading, success, and failure states based on the sign-out process
 */
class SignoutCubit extends Cubit<SignoutState> {
  SignoutCubit(this._firebaseAuthrepo) : super(SignOutInitial());

  final FirebaseAuthRepo _firebaseAuthrepo;

  Future<void> signOut() async {
    if (isClosed) return;
    emit(SignOutLoading());
    if (isClosed) return;
    final result = await _firebaseAuthrepo.signOut();
    result.fold(
      (failure) => emit(SignOutFailure(errMessage: failure.errMessage)),
      (_) async {
        final getIt = GetIt.instance;

        await getIt.resetLazySingleton<CartRepository>();

        await getIt.resetLazySingleton<CartService>();
        await getIt.resetLazySingleton<FavoriteRepository>();
        await getIt.resetLazySingleton<FavoriteService>();

        emit(SignOutSuccess());
      },
    );
  }
  void resetState() {
    emit(SignOutInitial());
  }
}
