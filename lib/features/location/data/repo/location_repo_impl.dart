import 'package:dartz/dartz.dart';
import 'package:suits/core/error/custom_excption.dart';
import 'package:suits/core/error/failure.dart';
import 'package:suits/features/location/data/models/location_model.dart';
import 'package:suits/features/location/data/service/location_firestore_service.dart';
import 'package:suits/features/location/domain/repo/location_repo.dart';

class LocationRepoImpl implements LocationRepo {
  final LocationFirestoreService locationFirestoreService;

  LocationRepoImpl({required this.locationFirestoreService});

  @override
  Future<Either<CustomFailure, void>> addLocation(
    LocationModel locationData,
  ) async {
    try {
      await locationFirestoreService.addLocation(locationData);
      return const Right(null);
    } on CustomException catch (ex) {
      return Left(CustomFailure(errMessage: ex.toString()));
    }
  }

  @override
  Future<Either<CustomFailure, void>> deleteLocation(String locationId) async {
    try {
      await locationFirestoreService.deleteLocation(locationId);
      return const Right(null);
    } on CustomException catch (ex) {
      return Left(CustomFailure(errMessage: ex.toString()));
    }
  }

  @override
  Future<Either<CustomFailure, List<LocationModel>>> getLocations() async {
    try {
      final data = await locationFirestoreService.getLocations();
      return Right(data);
    } on CustomException catch (ex) {
      return Left(CustomFailure(errMessage: ex.toString()));
    }
  }

  @override
  Future<Either<CustomFailure, void>> updateLocation(
    LocationModel locationData,
  ) async {
    try {
      await locationFirestoreService.updateLocation(locationData);
      return const Right(null);
    } on CustomException catch (ex) {
      return Left(CustomFailure(errMessage: ex.toString()));
    }
  }
}
