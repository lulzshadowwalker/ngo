part of 'skills_cubit.dart';

@freezed
class SkillsState with _$SkillsState {
  const factory SkillsState.initial() = _Initial;
  const factory SkillsState.loading() = _Loading;
  const factory SkillsState.loaded(List<Skill> skills) = _Loaded;
  const factory SkillsState.loadedSingleSkill(Skill skill) = _LoadedSingleSkill;
  const factory SkillsState.error(String message) = _Error;
}
