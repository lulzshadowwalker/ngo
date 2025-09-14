import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/components/search_and_filter_widget.dart';
import 'package:ngo/features/opportunities/cubit/opportunities_cubit.dart';
import 'package:ngo/features/opportunities/opportunity_detail_view.dart';
import 'package:ngo/models/opportunity.dart';
import 'package:ngo/service_locator.dart';

import '../sectors_features/cubit/sectors_cubit.dart';

class OpportunitiesView extends HookWidget {
  const OpportunitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final scrollController = useScrollController();
    var lang = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<OpportunitiesCubit>()
                ..fetchOpportunities(language: lang.localeName),
        ),
        BlocProvider(
          create: (context) =>
              sl<SectorsCubit>()..fetchAllSectors(language: lang.localeName),
        ),
      ],
      child: _OpportunitiesContent(
        searchController: searchController,
        scrollController: scrollController,
        lang: lang,
      ),
    );
  }
}

class _OpportunitiesContent extends HookWidget {
  final TextEditingController searchController;
  final ScrollController scrollController;
  final AppLocalizations lang;

  const _OpportunitiesContent({
    required this.searchController,
    required this.scrollController,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for scroll to implement pagination
    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          final cubit = context.read<OpportunitiesCubit>();
          if (cubit.hasMorePages) {
            cubit.loadMore(language: lang.localeName);
          }
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Volunteer Opportunities',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: () {
              _showFilterBottomSheet(context, lang);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search and Filter Component
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
            const SizedBox(height: 20),

            // Opportunities List
            Expanded(
              child: BlocBuilder<OpportunitiesCubit, OpportunitiesState>(
                builder: (context, state) {
                  final stateString = state.toString();
                  
                  // Handle loading and initial states
                  if (stateString.contains('loading') || stateString.contains('initial')) {
                    return _buildLoadingState();
                  }
                  
                  // Handle loaded state
                  if (stateString.contains('loaded')) {
                    try {
                      final dynamic loadedState = state;
                      final opportunities = loadedState.opportunities as List<Opportunity>;
                      
                      if (opportunities.isEmpty) {
                        return _buildEmptyState();
                      }

                      return ListView.builder(
                        controller: scrollController,
                        itemCount: opportunities.length +
                            (context.read<OpportunitiesCubit>().hasMorePages ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= opportunities.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final opportunity = opportunities[index];
                          return _buildOpportunityCard(opportunity, context);
                        },
                      );
                    } catch (e) {
                      return _buildErrorState(context, lang);
                    }
                  }
                  
                  // Handle error state
                  if (stateString.contains('error')) {
                    return _buildErrorState(context, lang);
                  }
                  
                  // Default fallback
                  return _buildLoadingState();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => _buildOpportunityCardSkeleton(),
    );
  }

  Widget _buildErrorState(BuildContext context, AppLocalizations lang) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your connection and try again',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<OpportunitiesCubit>().fetchOpportunities(
                language: lang.localeName,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No opportunities found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label, {
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? MyColors.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildOpportunityCard(Opportunity opportunity, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OpportunityDetailView(opportunityId: opportunity.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Opportunity Image
            SizedBox(
              width: 80,
              height: 100,
              child: _buildOpportunityImage(opportunity),
            ),

            // Opportunity Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      opportunity.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      opportunity.organization.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: MyColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      opportunity.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            opportunity.locationDescription ??
                                'Location ID: ${opportunity.locationId}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${opportunity.duration} ${opportunity.duration == 1 ? 'month' : 'months'}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOpportunityImage(Opportunity opportunity) {
    // For now, just use placeholder images
    // In the future, you can add imageUrl field to Program model or Opportunity model
    return _buildPlaceholderImage(opportunity);
  }

  Widget _buildPlaceholderImage(Opportunity opportunity) {
    // Create different colored placeholders based on opportunity type/sector
    final colors = [
      MyColors.primaryColor,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
    ];

    final color = colors[opportunity.id.hashCode % colors.length];

    return Icon(Icons.volunteer_activism, color: color, size: 30);
  }

  Widget _buildOpportunityCardSkeleton() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image skeleton
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),

          // Content skeleton
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 14,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 12,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context, AppLocalizations lang) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<SectorsCubit>()),
          BlocProvider.value(value: context.read<OpportunitiesCubit>()),
        ],
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.6,
            maxChildSize: 0.9,
            minChildSize: 0.3,
            expand: false,
            builder: (context, scrollController) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      lang.filter_opportunities,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                           lang.sector,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          BlocBuilder<SectorsCubit, SectorsState>(
                            builder: (context, sectorsState) {
                              return BlocBuilder<OpportunitiesCubit, OpportunitiesState>(
                                builder: (context, opportunitiesState) {
                                  // Get current selected sector ID
                                  int? selectedSectorId;
                                  try {
                                    final dynamic state = opportunitiesState;
                                    if (opportunitiesState.toString().contains('loaded')) {
                                      selectedSectorId = state.selectedSectorId;
                                    }
                                  } catch (e) {
                                    // Handle error accessing state
                                  }

                                  // Build sector chips
                                  List<Widget> sectorChips = [
                                    _buildFilterChip(
                                      'All',
                                      isSelected: selectedSectorId == null,
                                      onTap: () {
                                        context.read<OpportunitiesCubit>().clearFilters(
                                          language: lang.localeName,
                                        );
                                      },
                                    ),
                                  ];

                                  // Add sectors from SectorsCubit if available
                                  if (sectorsState.toString().contains('loaded')) {
                                    try {
                                      final dynamic state = sectorsState;
                                      final sectors = state.sectors as List<dynamic>;
                                      
                                      for (final sector in sectors) {
                                        final sectorId = int.parse(sector.id);
                                        final sectorName = sector.name;
                                        
                                        sectorChips.add(
                                          _buildFilterChip(
                                            sectorName,
                                            isSelected: selectedSectorId == sectorId,
                                            onTap: () {
                                              context.read<OpportunitiesCubit>().filterBySector(
                                                sectorId,
                                                language: lang.localeName,
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      // Handle error accessing sectors
                                    }
                                  }

                                  return Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: sectorChips,
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Duration',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                        
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    context.read<OpportunitiesCubit>().clearFilters(
                                      language: lang.localeName,
                                    );
                                    Navigator.pop(context);
                                  },
                                  child:  Text(lang.clear_filters),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: MyColors.primaryColor,
                                    foregroundColor: Colors.white,
                                  ),
                                  child:  Text(lang.apply_filters),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
