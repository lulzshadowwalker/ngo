import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/organization/cubit/organization_cubit.dart';
import 'package:ngo/features/sectors_features/cubit/sectors_cubit.dart';
import 'package:ngo/service_locator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrganizationView extends HookWidget {
  const OrganizationView({super.key});

  void _showFilterBottomSheet(
    BuildContext context,
    AppLocalizations lang,
    ValueNotifier<String> selectedFilter,
    ValueNotifier<String?> selectedFilterId,
    List<dynamic> sectors,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext bottomSheetContext) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter Organizations',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(bottomSheetContext),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                
                Text(
                  'Filter by Sector:',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                
                sectors.isEmpty 
                  ? const Column(
                      children: [
                        Icon(Icons.hourglass_empty, size: 48, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Loading sectors...',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    )
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildFilterOption(
                          'All',
                          selectedFilter.value == 'All',
                          () {
                            selectedFilter.value = 'All';
                            selectedFilterId.value = null;
                            context.read<OrganizationCubit>().fetchAllOrganizations(
                              language: lang.localeName,
                            );
                            Navigator.pop(bottomSheetContext);
                          },
                        ),
                        ...sectors.map((sector) => _buildFilterOption(
                          sector.name ?? 'Unknown',
                          selectedFilter.value == sector.name,
                          () {
                            selectedFilter.value = sector.name ?? 'Unknown';
                            selectedFilterId.value = sector.id;
                            context.read<OrganizationCubit>().searchOrganizations(
                              '',
                              language: lang.localeName,
                              sectorId: sector.id,
                            );
                            Navigator.pop(bottomSheetContext);
                          },
                        )),
                      ],
                    ),
                
                const SizedBox(height: 16),
                
                // Current filter status
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue[700], size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          selectedFilter.value == 'All' 
                            ? 'Showing all organizations' 
                            : 'Filtered by: ${selectedFilter.value}',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          selectedFilter.value = 'All';
                          selectedFilterId.value = null;
                          context.read<OrganizationCubit>().fetchAllOrganizations(
                            language: lang.localeName,
                          );
                          Navigator.pop(bottomSheetContext);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Clear Filters'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(bottomSheetContext),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final selectedFilter = useState('All');
    final selectedFilterId = useState<String?>(null);
    final followedOrganizations = useState<List<String>>([]);
    final showSearchField = useState(false);

    Widget buildOrganizationCard({
      required String name,
      required String description,
      required String location,
      required String? imageUrl,
      required bool isFollowing,
      required String organizationId,
      required BuildContext context,
    }) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              imageUrl ?? "https://placehold.co/100",
            ),
            onBackgroundImageError: (exception, stackTrace) {
              // Handle image loading error silently
            },
            child: imageUrl == null || imageUrl.isEmpty
                ? const Icon(Icons.business, color: Colors.white, size: 30)
                : null,
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description, overflow: TextOverflow.ellipsis, maxLines: 2),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      location,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isFollowing ? Colors.grey[300] : Colors.green,
              foregroundColor: isFollowing ? Colors.black : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (isFollowing) {
                context.read<OrganizationCubit>().unfollowOrganization(
                  organizationId,
                );
                followedOrganizations.value = List.from(
                  followedOrganizations.value,
                )..remove(name);
              } else {
                context.read<OrganizationCubit>().followOrganization(
                  organizationId,
                );
                followedOrganizations.value = List.from(
                  followedOrganizations.value,
                )..add(name);
              }
            },
            child: Text(isFollowing ? 'Following' : 'Follow'),
          ),
        ),
      );
    }

    var lang = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<OrganizationCubit>()
                ..fetchAllOrganizations(language: lang.localeName),
        ),
        BlocProvider(
          create: (context) =>
              sl<SectorsCubit>()..fetchAllSectors(language: lang.localeName),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: Text(
            lang.organizations,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                showSearchField.value ? Icons.close : Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                showSearchField.value = !showSearchField.value;
                if (!showSearchField.value) {
                  searchController.clear();
                  // Reset to current filter or all organizations
                  if (selectedFilterId.value != null) {
                    context.read<OrganizationCubit>().searchOrganizations(
                      '',
                      language: lang.localeName,
                      sectorId: selectedFilterId.value,
                    );
                  } else {
                    context.read<OrganizationCubit>().fetchAllOrganizations(
                      language: lang.localeName,
                    );
                  }
                }
              },
            ),
            BlocBuilder<SectorsCubit, SectorsState>(
              builder: (context, sectorsState) {
                return IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.black),
                  onPressed: () {
                    List<dynamic> sectors = [];
                    if (sectorsState.runtimeType.toString().contains('Loaded')) {
                      final loadedState = sectorsState as dynamic;
                      sectors = loadedState.sectors as List<dynamic>;
                    }
                    _showFilterBottomSheet(context, lang, selectedFilter, selectedFilterId, sectors);
                  },
                );
              },
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search TextField Section (like blog_view)
                    if (showSearchField.value)
                      Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: lang.searchOrganizations,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      searchController.clear();
                                      // When clearing search, respect current filter
                                      if (selectedFilterId.value != null) {
                                        context.read<OrganizationCubit>().searchOrganizations(
                                          '',
                                          language: lang.localeName,
                                          sectorId: selectedFilterId.value,
                                        );
                                      } else {
                                        context.read<OrganizationCubit>().fetchAllOrganizations(
                                          language: lang.localeName,
                                        );
                                      }
                                    },
                                  )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(color: Colors.green),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          autofocus: true,
                          onChanged: (query) {
                            if (query.isEmpty) {
                              if (selectedFilterId.value != null) {
                                context.read<OrganizationCubit>().searchOrganizations(
                                  '',
                                  language: lang.localeName,
                                  sectorId: selectedFilterId.value,
                                );
                              } else {
                                context.read<OrganizationCubit>().fetchAllOrganizations(
                                  language: lang.localeName,
                                );
                              }
                            } else {
                              context.read<OrganizationCubit>().searchOrganizationsWithDebounce(
                                query,
                                language: lang.localeName,
                                sectorId: selectedFilterId.value,
                              );
                            }
                          },
                          onSubmitted: (query) {
                            if (query.trim().isNotEmpty) {
                              context.read<OrganizationCubit>().searchOrganizations(
                                query,
                                language: lang.localeName,
                                sectorId: selectedFilterId.value,
                              );
                            }
                          },
                        ),
                      ),

                    // Filter Chips Section
                    BlocBuilder<SectorsCubit, SectorsState>(
                      builder: (context, sectorsState) {
                        Widget buildFilterChipWithContext(String label, {String? sectorId}) {
                          return GestureDetector(
                            onTap: () {
                              // Clear search text when switching filters
                              searchController.clear();
                              selectedFilter.value = label;
                              selectedFilterId.value = sectorId;
                              
                              log("Selected filter: $label, Sector ID: $sectorId");
                              if (label == 'All') {
                                selectedFilterId.value = null;
                                context.read<OrganizationCubit>().fetchAllOrganizations(
                                  language: lang.localeName,
                                );
                              } else {
                                context.read<OrganizationCubit>().searchOrganizations(
                                  '',
                                  language: lang.localeName,
                                  sectorId: sectorId,
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: selectedFilter.value == label
                                    ? Colors.green
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                label,
                                style: TextStyle(
                                  color: selectedFilter.value == label
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }

                        if (sectorsState.runtimeType.toString().contains('Loaded')) {
                          final loadedState = sectorsState as dynamic;
                          final sectors = loadedState.sectors as List<dynamic>;
                    
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                buildFilterChipWithContext('All'),
                                const SizedBox(width: 8),
                                ...sectors.map<Widget>((sector) {
                                  return Row(
                                    children: [
                                      buildFilterChipWithContext(
                                        sector.name ?? 'Unknown',
                                        sectorId: sector.id,
                                      ),
                                      const SizedBox(width: 8),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          );
                        }
                        
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<OrganizationCubit, OrganizationState>(
              builder: (context, state) {
                if (state.runtimeType.toString().contains('Initial')) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('No data available'),
                      ),
                    ),
                  );
                } else if (state.runtimeType.toString().contains('Loading')) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Skeletonizer(
                        enabled: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: buildOrganizationCard(
                            name: 'Unknown Organization',
                            description: 'No description available',
                            location: 'Unknown location',
                            imageUrl: 'https://placehold.co/100',
                            isFollowing: false,
                            organizationId: '0',
                            context: context,
                          ),
                        ),
                      );
                    }, childCount: 10),
                  );
                } else if (state.runtimeType.toString().contains('Loaded')) {
                  final loadedState = state as dynamic;
                  final organizations = loadedState.organizations as List<dynamic>;

                  if (organizations.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                searchController.text.isNotEmpty
                                    ? 'No organizations match your search'
                                    : 'No organizations available',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                searchController.text.isNotEmpty
                                    ? 'Try different search terms'
                                    : 'Check your internet connection',
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final org = organizations[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: buildOrganizationCard(
                          name: org.name ?? 'Unknown Organization',
                          description: org.sector ?? 'No description',
                          location: org.location ?? 'Unknown location',
                          imageUrl: org.logo ?? org.image ?? org.avatar ?? 'https://placehold.co/100',
                          isFollowing: followedOrganizations.value.contains(org.name),
                          organizationId: org.slug ?? '0',
                          context: context,
                        ),
                      );
                    }, childCount: organizations.length),
                  );
                } else if (state.runtimeType.toString().contains('Error')) {
                  final errorState = state as dynamic;
                  final message = errorState.message ?? 'Unknown error';

                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Error: $message'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => context
                                  .read<OrganizationCubit>()
                                  .fetchAllOrganizations(
                                    language: lang.localeName,
                                  ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text('Unknown state'),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
