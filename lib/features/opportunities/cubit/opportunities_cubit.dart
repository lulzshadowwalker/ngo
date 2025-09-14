import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ngo/core/contracts/opportunities_repository.dart';
import 'package:ngo/models/api_response.dart';
import 'package:ngo/models/opportunity.dart';

part 'opportunities_cubit.freezed.dart';
part 'opportunities_state.dart';

class OpportunitiesCubit extends Cubit<OpportunitiesState> {
  final OpportunitiesRepository _repository;

  OpportunitiesCubit(this._repository) : super(const OpportunitiesState.initial());

  /// Fetch all opportunities with optional filtering
  Future<void> fetchOpportunities({
    String language = 'en',
    int page = 1,
    int perPage = 20,
    String? search,
    List<String>? tags,
    int? sectorId,
    int? organizationId,
    int? locationId,
    double? lat,
    double? lng,
    double? radius,
    int? durationMax,
    DateTime? expiryAfter,
    bool? isFeatured,
    String? sort,
    String? direction,
    bool isLoadMore = false,
  }) async {
    try {
      if (!isLoadMore) {
        emit(const OpportunitiesState.loading());
      }

      final response = await _repository.fetchAll(
        language: language,
        page: page,
        perPage: perPage,
        search: search,
        tags: tags,
        sectorId: sectorId,
        organizationId: organizationId,
        locationId: locationId,
        lat: lat,
        lng: lng,
        radius: radius,
        durationMax: durationMax,
        expiryAfter: expiryAfter,
        isFeatured: isFeatured,
        sort: sort,
        direction: direction,
      );

      if (isLoadMore && state is _Loaded) {
        final currentState = state as _Loaded;
        final updatedOpportunities = List<Opportunity>.from(currentState.opportunities)
          ..addAll(response.data);
        
        emit(OpportunitiesState.loaded(
          opportunities: updatedOpportunities,
          meta: response.meta,
          links: response.links,
          currentPage: page,
          searchQuery: search ?? '',
          selectedTags: tags ?? [],
          selectedSectorId: sectorId,
          selectedLocationId: locationId,
          isFeatured: isFeatured ?? false,
        ));
      } else {
        emit(OpportunitiesState.loaded(
          opportunities: response.data,
          meta: response.meta,
          links: response.links,
          currentPage: page,
          searchQuery: search ?? '',
          selectedTags: tags ?? [],
          selectedSectorId: sectorId,
          selectedLocationId: locationId,
          isFeatured: isFeatured ?? false,
        ));
      }
    } catch (e) {
      emit(OpportunitiesState.error(e.toString()));
    }
  }

  /// Fetch featured opportunities
  Future<void> fetchFeaturedOpportunities({
    String language = 'en',
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      emit(const OpportunitiesState.loading());

      final response = await _repository.fetchFeatured(
        language: language,
        page: page,
        perPage: perPage,
      );

      emit(OpportunitiesState.loaded(
        opportunities: response.data,
        meta: response.meta,
        links: response.links,
        currentPage: page,
        isFeatured: true,
      ));
    } catch (e) {
      emit(OpportunitiesState.error(e.toString()));
    }
  }

  /// Search opportunities
  Future<void> searchOpportunities(
    String query, {
    String language = 'en',
    int? sectorId,
  }) async {
    try {
      emit(const OpportunitiesState.loading());

      final opportunities = await _repository.search(
        query,
        language: language,
        sectorId: sectorId,
      );

      emit(OpportunitiesState.loaded(
        opportunities: opportunities,
        meta: const ApiMeta(
          total: 0,
          perPage: 20,
          currentPage: 1,
          lastPage: 1,
          from: 1,
          to: 0,
        ),
        links: const ApiLinks(
          first: '',
          last: '',
          prev: null,
          next: null,
        ),
        currentPage: 1,
        searchQuery: query,
        selectedTags: [],
        selectedSectorId: sectorId,
        selectedLocationId: null,
        isFeatured: false,
      ));
    } catch (e) {
      emit(OpportunitiesState.error(e.toString()));
    }
  }

  /// Filter opportunities by sector
  Future<void> filterBySector(
    int? sectorId, {
    String language = 'en',
  }) async {
    final currentState = state;
    if (currentState is _Loaded) {
      await fetchOpportunities(
        language: language,
        search: currentState.searchQuery.isNotEmpty ? currentState.searchQuery : null,
        tags: currentState.selectedTags.isNotEmpty ? currentState.selectedTags : null,
        sectorId: sectorId,
        locationId: currentState.selectedLocationId,
        isFeatured: currentState.isFeatured ? true : null,
      );
    } else {
      await fetchOpportunities(
        language: language,
        sectorId: sectorId,
      );
    }
  }

  /// Filter opportunities by location
  Future<void> filterByLocation(
    int? locationId, {
    String language = 'en',
  }) async {
    final currentState = state;
    if (currentState is _Loaded) {
      await fetchOpportunities(
        language: language,
        search: currentState.searchQuery.isNotEmpty ? currentState.searchQuery : null,
        tags: currentState.selectedTags.isNotEmpty ? currentState.selectedTags : null,
        sectorId: currentState.selectedSectorId,
        locationId: locationId,
        isFeatured: currentState.isFeatured ? true : null,
      );
    } else {
      await fetchOpportunities(
        language: language,
        locationId: locationId,
      );
    }
  }

  /// Filter opportunities by tags
  Future<void> filterByTags(
    List<String> tags, {
    String language = 'en',
  }) async {
    final currentState = state;
    if (currentState is _Loaded) {
      await fetchOpportunities(
        language: language,
        search: currentState.searchQuery.isNotEmpty ? currentState.searchQuery : null,
        tags: tags.isNotEmpty ? tags : null,
        sectorId: currentState.selectedSectorId,
        locationId: currentState.selectedLocationId,
        isFeatured: currentState.isFeatured ? true : null,
      );
    } else {
      await fetchOpportunities(
        language: language,
        tags: tags.isNotEmpty ? tags : null,
      );
    }
  }

  /// Load more opportunities (pagination)
  Future<void> loadMore({String language = 'en'}) async {
    final currentState = state;
    if (currentState is _Loaded && currentState.meta.currentPage < currentState.meta.lastPage) {
      try {
        final nextPage = currentState.currentPage + 1;
        
        final response = await _repository.fetchAll(
          language: language,
          page: nextPage,
          search: currentState.searchQuery.isNotEmpty ? currentState.searchQuery : null,
          tags: currentState.selectedTags.isNotEmpty ? currentState.selectedTags : null,
          sectorId: currentState.selectedSectorId,
          locationId: currentState.selectedLocationId,
          isFeatured: currentState.isFeatured ? true : null,
        );

        // Append new opportunities to existing list
        final updatedOpportunities = List<Opportunity>.from(currentState.opportunities)
          ..addAll(response.data);
        
        emit(OpportunitiesState.loaded(
          opportunities: updatedOpportunities,
          meta: response.meta,
          links: response.links,
          currentPage: nextPage,
          searchQuery: currentState.searchQuery,
          selectedTags: currentState.selectedTags,
          selectedSectorId: currentState.selectedSectorId,
          selectedLocationId: currentState.selectedLocationId,
          isFeatured: currentState.isFeatured,
        ));
      } catch (e) {
        // Don't emit error state for load more failures, just ignore
        // This prevents the UI from showing error state when pagination fails
      }
    }
  }

  /// Clear all filters
  Future<void> clearFilters({String language = 'en'}) async {
    await fetchOpportunities(language: language);
  }

  /// Get platform statistics
  Future<Map<String, dynamic>?> getStats() async {
    try {
      return await _repository.getStats();
    } catch (e) {
      return null;
    }
  }

  /// Check if there are more pages to load
  bool get hasMorePages {
    final currentState = state;
    if (currentState is _Loaded) {
      return currentState.meta.currentPage < currentState.meta.lastPage;
    }
    return false;
  }

  /// Get current filter summary
  String get filterSummary {
    final currentState = state;
    if (currentState is _Loaded) {
      final filters = <String>[];
      
      if (currentState.searchQuery.isNotEmpty) {
        filters.add('Search: "${currentState.searchQuery}"');
      }
      
      if (currentState.selectedSectorId != null) {
        filters.add('Sector filter');
      }
      
      if (currentState.selectedLocationId != null) {
        filters.add('Location filter');
      }
      
      if (currentState.selectedTags.isNotEmpty) {
        filters.add('${currentState.selectedTags.length} tag(s)');
      }
      
      if (currentState.isFeatured) {
        filters.add('Featured only');
      }
      
      if (filters.isEmpty) {
        return 'All opportunities';
      }
      
      return filters.join(', ');
    }
    return 'No filters applied';
  }
}
