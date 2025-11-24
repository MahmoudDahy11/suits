part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationSuccess extends LocationState {
  final List<LocationModel> locations;
  const LocationSuccess({required this.locations});
  
  @override
  List<Object> get props => [locations];
}

final class LocationFailure extends LocationState {
  final String errorMessage;
  const LocationFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
