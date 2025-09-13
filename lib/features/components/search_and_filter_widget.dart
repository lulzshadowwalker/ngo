import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/sectors_features/cubit/sectors_cubit.dart';

enum FilterType { opportunities, blog, organization }

class SearchAndFilterWidget extends HookWidget {
  final FilterType filterType;
  final Function(String) onSearch;
  final Function(String?, int?) onFilter; // (label, sectorId)
  final Function() onClearFilters;
  final TextEditingController? searchController;
  final String searchHint;

  const SearchAndFilterWidget({
    super.key,
    required this.filterType,
    required this.onSearch,
    required this.onFilter,
    required this.onClearFilters,
    this.searchController,
    this.searchHint = 'Search...',
  });

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('All');
    final controller = searchController ?? useTextEditingController();
    final lang = AppLocalizations.of(context)!;

    return Column(
      children: [
        // Search Bar
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: searchHint,
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty) {
                onSearch(value);
              } else {
                onClearFilters();
              }
            },
          ),
        ),
        const SizedBox(height: 16),

        // Filter Chips
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: BlocBuilder<SectorsCubit, SectorsState>(
            builder: (context, sectorsState) {
              return _buildFilterChips(
                context,
                sectorsState,
                selectedFilter,
                lang,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips(
    BuildContext context,
    SectorsState sectorsState,
    ValueNotifier<String> selectedFilter,
    AppLocalizations lang,
  ) {
    Widget buildFilterChip(String label, {String? sectorId}) {
      final isSelected = selectedFilter.value == label;
      return GestureDetector(
        onTap: () {
          selectedFilter.value = label;

          if (label == 'All') {
            onFilter(null, null); // Clear filters
          } else {
            onFilter(label, int.tryParse(sectorId ?? ''));
          }
        },
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? MyColors.primaryColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      );
    }

    if (sectorsState.runtimeType.toString().contains('Loaded')) {
      final loadedState = sectorsState as dynamic;
      final sectors = loadedState.sectors as List<dynamic>;

      return ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          buildFilterChip('All'),
          ...sectors.map(
            (sector) => buildFilterChip(
              sector.name ?? 'Unknown',
              sectorId: sector.id?.toString(),
            ),
          ),
        ],
      );
    } else if (sectorsState.runtimeType.toString().contains('Loading')) {
      return const Center(child: CircularProgressIndicator());
    } else if (sectorsState.runtimeType.toString().contains('Error')) {
      return Center(
        child: Text('Error loading categories', style: MyFonts.font12Black),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
