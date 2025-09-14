part of 'application_cubit.dart';

@freezed
class ApplicationState with _$ApplicationState {
  const factory ApplicationState.initial() = _Initial;
  const factory ApplicationState.checking() = _Checking;
  const factory ApplicationState.canApply() = _CanApply;
  const factory ApplicationState.alreadyApplied(Application application) =
      _AlreadyApplied;
  const factory ApplicationState.submitting() = _Submitting;
  const factory ApplicationState.submitted(Application application) =
      _Submitted;
  const factory ApplicationState.saving() = _Saving;
  const factory ApplicationState.savedAsDraft() = _SavedAsDraft;
  const factory ApplicationState.error(String message) = _Error;
}
