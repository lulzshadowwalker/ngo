part of 'location_cubit.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState.initial() = _Initial;
  const factory LocationState.loading() = _Loading;
  const factory LocationState.loaded(List<Location> locations) = _Loaded;
  const factory LocationState.error(String message) = _Error;

  const factory LocationState.loadedSingleLocation(Location location) = _LoadedSingleLocation;
}
