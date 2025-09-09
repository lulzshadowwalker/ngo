import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/core/contracts/organizations_repository.dart';
import 'package:ngo/models/organization.dart';

part 'organization_cubit.freezed.dart';
part 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  final OrganizationsRepository _repository;
  Timer? _debounceTimer;

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

  Future<void> followOrganization(String organizationId) async {
    try {
      await _repository.followOrganization(organizationId);
      // Optionally refresh the organizations list
      await fetchAllOrganizations();
    } catch (error) {
      emit(OrganizationState.error('Failed to follow organization: ${error.toString()}'));
    }
  }

  Future<void> unfollowOrganization(String organizationId) async {
    try {
      await _repository.unfollowOrganization(organizationId);
      // Optionally refresh the organizations list
      await fetchAllOrganizations();
    } catch (error) {
      emit(OrganizationState.error('Failed to unfollow organization: ${error.toString()}'));
    }
  }

  Future<void> searchOrganizations(
    String query, {
    String language = 'en',
    String? sectorId,
  }) async {
    try {
      emit(const OrganizationState.loading());
      
      if (query.trim().isEmpty) {
        // If search query is empty, fetch all organizations
        await fetchAllOrganizations(language: language);
        return;
      }
      
      final organizations = await _repository.search(
        query,
        language: language,
        sectorId: sectorId,
      );
      
      emit(OrganizationState.loaded(organizations));
    } catch (error) {
      emit(OrganizationState.error('Failed to search organizations: ${error.toString()}'));
    }
  }

  void clearSearch({String language = 'en'}) {
    _debounceTimer?.cancel();
    fetchAllOrganizations(language: language);
  }

  Future<void> searchOrganizationsWithDebounce(
    String query, {
    String language = 'en',
    String? sectorId,
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    _debounceTimer?.cancel();
    
    _debounceTimer = Timer(delay, () {
      searchOrganizations(query, language: language, sectorId: sectorId);
    });
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
