part of 'sectors_cubit.dart';

@freezed
class SectorsState with _$SectorsState {
  const factory SectorsState.initial() = _Initial;
  const factory SectorsState.loading() = _Loading;
  const factory SectorsState.loaded(List<Sector> sectors) = _Loaded;
  const factory SectorsState.error(String message) = _Error;
  const factory SectorsState.singleLoading(Sector sector) = _SingleLoading;
}
