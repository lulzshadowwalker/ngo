import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/core/contracts/organizations_repository.dart';
import 'package:ngo/models/organization.dart';

part 'organization_cubit.freezed.dart';
part 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  final OrganizationsRepository _repository;

  OrganizationCubit(this._repository) : super(const OrganizationState.initial());

  Future<void> fetchAllOrganizations({String language = 'en'}) async {
    try {
      emit(const OrganizationState.loading());
      
      final organizations = await _repository.fetchAll(language: language);
      
      emit(OrganizationState.loaded(organizations));
    } catch (error) {
      emit(OrganizationState.error(error.toString()));
    }
  }

  Future<void> fetchOrganization(String slug, {String language = 'en'}) async {
    try {
      emit(const OrganizationState.loading());
      
      final organization = await _repository.fetch(slug, language: language);
      
      emit(OrganizationState.loaded([organization]));
    } catch (error) {
      emit(OrganizationState.error(error.toString()));
    }
  }
}
