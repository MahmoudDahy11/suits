import 'package:dartz/dartz.dart';
import 'package:suits/core/error/failure.dart';

import '../../data/models/location_model.dart';

abstract class LocationRepo {
  Future<Either<CustomFailure, void>> addLocation(LocationModel locationData);
  Future<Either<CustomFailure, List<LocationModel>>> getLocations();
  Future<Either<CustomFailure, void>> deleteLocation(String locationId);
  Future<Either<CustomFailure, void>> updateLocation(
    LocationModel locationData,
  );
}
