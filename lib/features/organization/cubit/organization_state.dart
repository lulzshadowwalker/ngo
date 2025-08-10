part of 'organization_cubit.dart';

@freezed
class OrganizationState with _$OrganizationState {
  const factory OrganizationState.initial() = _Initial;
  const factory OrganizationState.loading() = _Loading;
  const factory OrganizationState.loaded(List<Organization> organizations) = _Loaded;
  const factory OrganizationState.error(String message) = _Error;
}
