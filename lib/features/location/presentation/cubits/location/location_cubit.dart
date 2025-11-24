import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:suits/features/location/domain/repo/location_repo.dart';

import '../../../data/models/location_model.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this._locationRepo) : super(LocationInitial());

  final LocationRepo _locationRepo;

  Future<void> getLocations() async {
    if (isClosed) return;
    emit(LocationLoading());

    final result = await _locationRepo.getLocations();

    if (isClosed) return;
    result.fold(
      (failure) => emit(LocationFailure(errorMessage: failure.errMessage)),
      (locations) => emit(LocationSuccess(locations: locations)),
    );
  }

  Future<void> addLocation(LocationModel locationData) async {
    if (isClosed) return;
    emit(LocationLoading());

    final result = await _locationRepo.addLocation(locationData);

    if (isClosed) return;
    result.fold(
      (failure) => emit(LocationFailure(errorMessage: failure.errMessage)),
      (_) async {
        if (isClosed) return;
        final updated = await _locationRepo.getLocations();
        if (isClosed) return;

        updated.fold(
          (failure) => emit(LocationFailure(errorMessage: failure.errMessage)),
          (locations) => emit(LocationSuccess(locations: locations)),
        );
      },
    );
  }

  Future<void> deleteLocation(String locationId) async {
    if (isClosed) return;
    emit(LocationLoading());

    final result = await _locationRepo.deleteLocation(locationId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(LocationFailure(errorMessage: failure.errMessage)),
      (_) async {
        if (isClosed) return;
        final updated = await _locationRepo.getLocations();

        updated.fold(
          (failure) => emit(LocationFailure(errorMessage: failure.errMessage)),
          (locations) => emit(LocationSuccess(locations: locations)),
        );
      },
    );
  }

  Future<void> updateLocation(LocationModel locationData) async {
    if (isClosed) return;
    emit(LocationLoading());

    final result = await _locationRepo.updateLocation(locationData);

    if (isClosed) return;
    result.fold(
      (failure) => emit(LocationFailure(errorMessage: failure.errMessage)),
      (_) async {
        if (isClosed) return;
        final updated = await _locationRepo.getLocations();

        updated.fold(
          (failure) => emit(LocationFailure(errorMessage: failure.errMessage)),
          (locations) => emit(LocationSuccess(locations: locations)),
        );
      },
    );
  }
}
