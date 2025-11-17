import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entity/fav_item_entity.dart';
import '../../../domain/repo/fav_repo.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteRepository repository;

  FavoriteCubit({required this.repository}) : super(FavoriteInitial());

  Future<void> loadFavorites() async {
    try {
      // لا تُصدر حالة تحميل إذا كانت البيانات موجودة بالفعل ومُحملة
      if (state is! FavoriteLoaded) {
        emit(FavoriteLoading());
      }
      // استخدام Stream/onSnapshot (يفترض أنه مطبق في الـ Repository/Service)
      // لضمان التحديث اللحظي إذا أمكن، أو نعتمد على استدعاء getFavorites
      final items = await repository.getFavorites();
      emit(FavoriteLoaded(items));
    } catch (e) {
      emit(FavoriteFailure(e.toString()));
    }
  }

  Future<void> toggleFavorite(FavoriteItemEntity item) async {
    if (state is FavoriteLoaded) {
      final currentState = state as FavoriteLoaded;
      final exists = currentState.items.any(
        (i) => i.product.id == item.product.id,
      );

      // 1. تحديث الـ UI فورًا بتعديل قائمة العناصر في الـ Cubit
      final updatedItems = exists
          ? currentState.items
                .where((i) => i.product.id != item.product.id)
                .toList()
          : [...currentState.items, item];

      emit(FavoriteLoaded(updatedItems));

      // 2. تحديث الـ repository بشكل غير متزامن
      try {
        if (exists) {
          await repository.removeFavorite(item.product.id);
        } else {
          await repository.addFavorite(item);
        }
      } catch (e) {
        // إذا فشلت عملية الكتابة على Firestore، نعيد الحالة السابقة إلى الـ UI
        // لضمان تزامن الـ UI مع Firestore
        emit(FavoriteFailure(e.toString())); // يمكن إظهار خطأ
        loadFavorites(); // إعادة تحميل القائمة الصحيحة من Firestore
      }
    }
  }

  // هذه الدالة ستُستخدم في الـ BlocSelector لتحديد حالة القلب
  bool isFavorite(String productId) {
    if (state is FavoriteLoaded) {
      return (state as FavoriteLoaded).items.any(
        (i) => i.product.id == productId,
      );
    }
    return false;
  }
}
