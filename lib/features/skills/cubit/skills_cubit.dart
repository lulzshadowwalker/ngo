import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/core/contracts/skills_repository.dart';
import 'package:ngo/models/skill.dart';

part 'skills_cubit.freezed.dart';
part 'skills_state.dart';

class SkillsCubit extends Cubit<SkillsState> {
  final SkillsRepository _repository;

  SkillsCubit(this._repository) : super(const SkillsState.initial());

  Future<void> fetchAllSkills({String language = 'en'}) async {
    try {
      print('SkillsCubit: Starting to fetch skills...');
      emit(const SkillsState.loading());
      
      print('SkillsCubit: Calling repository.fetchAll...');
      final skills = await _repository.fetchAll(language: language);
      
      print('SkillsCubit: Received ${skills.length} skills');
      emit(SkillsState.loaded(skills));
    } catch (error) {
      emit(SkillsState.error(error.toString()));
    }
  }

  Future<void> fetchSkill(String id, {String language = 'en'}) async {
    try {
      emit(const SkillsState.loading());
      
      final skill = await _repository.fetch(id, language: language);
      
      emit(SkillsState.loadedSingleSkill(skill));
    } catch (error) {
      emit(SkillsState.error(error.toString()));
    }
  }
}
