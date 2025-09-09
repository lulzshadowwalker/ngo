part of 'static_page_cubit.dart';

@freezed
class StaticPageState with _$StaticPageState {
  const factory StaticPageState.initial() = _Initial;
  const factory StaticPageState.loading() = _Loading;
  const factory StaticPageState.success(StaticPage staticPage) = _Success;
  const factory StaticPageState.error(String message) = _Error;
}
