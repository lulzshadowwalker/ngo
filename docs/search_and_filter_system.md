# Reusable Search and Filter System

This document explains how to use the reusable `SearchAndFilterWidget` across different views in the NGO app.

## Overview

The `SearchAndFilterWidget` is a reusable component that provides:
- Search functionality with real-time search
- Dynamic filter chips loaded from sectors API
- Unified state management
- Consistent UI across all views

## Components

### 1. SearchAndFilterWidget
**Location**: `/lib/features/components/search_and_filter_widget.dart`

**Props**:
- `filterType`: Enum to specify which type of filtering (opportunities, blog, organization)
- `onSearch`: Callback for search functionality
- `onFilter`: Callback for filter selection (label, sectorId)
- `onClearFilters`: Callback to clear all filters
- `searchController`: Optional TextEditingController
- `searchHint`: Placeholder text for search field

## Implementation Examples

### 1. Opportunities View ✅ (Implemented)
**Location**: `/lib/features/opportunities/opportunities_view.dart`

```dart
SearchAndFilterWidget(
  filterType: FilterType.opportunities,
  searchController: searchController,
  searchHint: 'Search opportunities...',
  onSearch: (query) {
    context.read<OpportunitiesCubit>().searchOpportunities(
      query,
      language: lang.localeName,
    );
  },
  onFilter: (label, sectorId) {
    if (sectorId != null) {
      context.read<OpportunitiesCubit>().filterBySector(
        sectorId,
        language: lang.localeName,
      );
    } else {
      context.read<OpportunitiesCubit>().clearFilters(
        language: lang.localeName,
      );
    }
  },
  onClearFilters: () {
    context.read<OpportunitiesCubit>().clearFilters(
      language: lang.localeName,
    );
  },
),
```

### 2. Blog View (Example Implementation)
**Location**: `/lib/features/blog/blog_view.dart`

```dart
SearchAndFilterWidget(
  filterType: FilterType.blog,
  searchController: searchController,
  searchHint: 'Search blog posts...',
  onSearch: (query) {
    context.read<PostCubit>().searchPosts(
      query: query,
      language: lang.localeName,
    );
  },
  onFilter: (label, sectorId) {
    if (sectorId != null) {
      context.read<PostCubit>().searchPosts(
        query: '',
        language: lang.localeName,
        sectorId: sectorId.toString(),
      );
    } else {
      context.read<PostCubit>().fetchAllPost(
        language: lang.localeName,
      );
    }
  },
  onClearFilters: () {
    context.read<PostCubit>().fetchAllPost(
      language: lang.localeName,
    );
  },
),
```

### 3. Organization View (Example Implementation)
**Location**: `/lib/features/organization/organization_view.dart`

```dart
SearchAndFilterWidget(
  filterType: FilterType.organization,
  searchController: searchController,
  searchHint: 'Search organizations...',
  onSearch: (query) {
    context.read<OrganizationCubit>().searchOrganizations(query);
  },
  onFilter: (label, sectorId) {
    if (sectorId != null) {
      context.read<OrganizationCubit>().filterBySector(sectorId);
    } else {
      context.read<OrganizationCubit>().fetchAllOrganizations();
    }
  },
  onClearFilters: () {
    context.read<OrganizationCubit>().fetchAllOrganizations();
  },
),
```

## Required BlocProviders

Each view using the SearchAndFilterWidget must provide:

```dart
MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => sl<YourCubit>()..initialFetch(),
    ),
    BlocProvider(
      create: (context) => sl<SectorsCubit>()..fetchAllSectors(language: lang.localeName),
    ),
  ],
  child: YourView(),
)
```

## Cubit Requirements

Your cubit should implement these methods:

### For Search Functionality:
- `searchItems(String query, {String language})`
- `clearFilters({String language})`

### For Filter Functionality:
- `filterBySector(int sectorId, {String language})`

## Features

### ✅ Implemented Features:
1. **Dynamic Sector Loading**: Automatically loads sectors from API
2. **Real-time Search**: Search triggers immediately on text change
3. **Filter State Management**: Tracks selected filter with visual feedback
4. **Loading States**: Shows loading indicator while sectors load
5. **Error Handling**: Displays error message if sectors fail to load
6. **Consistent UI**: Same design across all views
7. **Language Support**: Supports localization

### 🎯 Key Benefits:
1. **Reusability**: Use same component across multiple views
2. **Consistency**: Unified UX across the app
3. **Maintainability**: Single source of truth for search/filter logic
4. **Scalability**: Easy to add new filter types or modify behavior
5. **Performance**: Efficient state management and API calls

## Usage Pattern

1. **Import the component**:
   ```dart
   import 'package:ngo/features/components/search_and_filter_widget.dart';
   ```

2. **Add BlocProviders** (both your cubit + SectorsCubit)

3. **Replace your search bar and filter chips** with SearchAndFilterWidget

4. **Implement the required callbacks** to connect with your cubit

5. **Test the implementation** with search and filter operations

## Current Status

- ✅ **OpportunitiesView**: Fully implemented and working
- 🔄 **BlogView**: Example provided (needs cubit method verification)
- 🔄 **OrganizationView**: Example provided (needs cubit method verification)

## Next Steps

1. Verify and update BlogCubit to support required search/filter methods
2. Verify and update OrganizationCubit to support required search/filter methods
3. Test implementations across all views
4. Add additional filter types if needed (location, date ranges, etc.)
