import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/contracts/locations_repository.dart';
import '../../../models/location.dart';

part 'location_cubit.freezed.dart';
part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final LocationsRepository _repository;
  LocationCubit(this._repository) : super(LocationState.initial());



 Future<void> fetchAllLocation({String language = 'en'})async{
    try {
      emit(const LocationState.loading());
       final locations = await  _repository.fetchAll(language: language);

       log("Fetched ${locations.length} locations");
       emit(LocationState.loaded(locations));
    } catch (error) {
      emit(LocationState.error(error.toString()));
    }
  }


  Future<void> fetchLocation(String id, {String language = 'en'}) async {
    try {
      emit(const LocationState.loading());
      final location = await _repository.fetch(id, language: language);
      emit(LocationState.loadedSingleLocation(location));
    } catch (error) {
      emit(LocationState.error(error.toString()));
    }
  }
}
