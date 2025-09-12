part of 'opportunities_cubit.dart';

@freezed
class OpportunitiesState with _$OpportunitiesState {
  const factory OpportunitiesState.initial() = _Initial;
  const factory OpportunitiesState.loading() = _Loading;
  const factory OpportunitiesState.loaded({
    required List<Opportunity> opportunities,
    required ApiMeta meta,
    required ApiLinks links,
    @Default(1) int currentPage,
    @Default('') String searchQuery,
    @Default([]) List<String> selectedTags,
    int? selectedSectorId,
    int? selectedLocationId,
    @Default(false) bool isFeatured,
  }) = _Loaded;
  const factory OpportunitiesState.error(String message) = _Error;
}
