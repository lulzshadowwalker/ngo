import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/core/contracts/sectors_repository.dart';
import 'package:ngo/models/sectors.dart';

part 'sectors_cubit.freezed.dart';
part 'sectors_state.dart';

class SectorsCubit extends Cubit<SectorsState> {
  final SectorsRepository _sectorsRepository;
  SectorsCubit(this._sectorsRepository) : super(SectorsState.initial());

  Future<void> fetchAllSectors({String language = 'en'}) async {
    try {
      emit(const SectorsState.loading());
      final sectors = await _sectorsRepository.fetchAll(language: language);
      emit(SectorsState.loaded(sectors));
    } catch (error) {
      emit(SectorsState.error(error.toString()));
    }
  }
}
