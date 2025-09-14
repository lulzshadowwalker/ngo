import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/core/contracts/organizations_repository.dart';
import 'package:ngo/models/organization.dart';

import '../../../core/helpers/helper.dart';

part 'organization_cubit.freezed.dart';
part 'organization_state.dart';

class OrganizationCubit extends Cubit<OrganizationState> {
  final OrganizationsRepository _repository;
  Timer? _debounceTimer;

  OrganizationCubit(this._repository)
    : super(const OrganizationState.initial());

  Future<void> fetchAllOrganizations({String language = 'en'}) async {
    try {
      final authorization = await SharedPrefHelper.getAccessToken();
      emit(const OrganizationState.loading());

      final organizations = await _repository.fetchAll(
        authorization,
        language: language,
      );

      emit(OrganizationState.loaded(organizations));
    } catch (error) {
      emit(OrganizationState.error(error.toString()));
    }
  }

  Future<void> fetchOrganization(String slug, {String language = 'en'}) async {
    try {
      final authorization = await SharedPrefHelper.getAccessToken();
      emit(const OrganizationState.loading());

      final organization = await _repository.fetch(
        slug,
        authorization,
        language: language,
      );

      emit(OrganizationState.loadedSingleOrgnization(organization));
    } catch (error) {
      emit(OrganizationState.error(error.toString()));
    }
  }

  Future<void> followOrganization(String organizationId) async {
    try {
      log('Following organization with ID: $organizationId');
      await _repository.followOrganization(organizationId);

      // Update the current state
      final currentState = state;
      log('Current state type: ${currentState.runtimeType}');

      if (currentState is _LoadedSingleOrganization &&
          currentState.organization.id == organizationId) {
        log('Updating single organization view');
        // Update single organization view
        final updatedOrganization = currentState.organization.copyWith(
          isFollowed: true,
        );
        emit(OrganizationState.loadedSingleOrgnization(updatedOrganization));
      } else if (currentState is _Loaded) {
        log(
          'Updating organization list. Current orgs count: ${currentState.organizations.length}',
        );
        // Update organization in the list
        final updatedOrganizations = currentState.organizations.map((org) {
          log(
            'Comparing org.id "${org.id}" with organizationId "$organizationId"',
          );
          if (org.id == organizationId) {
            log('Found matching organization, updating isFollowed to true');
            return org.copyWith(isFollowed: true);
          }
          return org;
        }).toList();
        emit(OrganizationState.loaded(updatedOrganizations));
      }
    } catch (error) {
      emit(
        OrganizationState.error(
          'Failed to follow organization: ${error.toString()}',
        ),
      );
    }
  }

  Future<void> unfollowOrganization(String organizationId) async {
    try {
      log('Unfollowing organization with ID: $organizationId');
      await _repository.unfollowOrganization(organizationId);

      // Update the current state
      final currentState = state;
      log('Current state type: ${currentState.runtimeType}');

      if (currentState is _LoadedSingleOrganization &&
          currentState.organization.id == organizationId) {
        log('Updating single organization view');
        // Update single organization view
        final updatedOrganization = currentState.organization.copyWith(
          isFollowed: false,
        );
        emit(OrganizationState.loadedSingleOrgnization(updatedOrganization));
      } else if (currentState is _Loaded) {
        log(
          'Updating organization list. Current orgs count: ${currentState.organizations.length}',
        );
        // Update organization in the list
        final updatedOrganizations = currentState.organizations.map((org) {
          log(
            'Comparing org.id "${org.id}" with organizationId "$organizationId"',
          );
          if (org.id == organizationId) {
            log('Found matching organization, updating isFollowed to false');
            return org.copyWith(isFollowed: false);
          }
          return org;
        }).toList();
        emit(OrganizationState.loaded(updatedOrganizations));
      }
    } catch (error) {
      emit(
        OrganizationState.error(
          'Failed to unfollow organization: ${error.toString()}',
        ),
      );
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
      emit(
        OrganizationState.error(
          'Failed to search organizations: ${error.toString()}',
        ),
      );
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
