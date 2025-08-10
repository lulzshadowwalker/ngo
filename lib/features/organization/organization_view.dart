import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/organization/cubit/organization_cubit.dart';
import 'package:ngo/service_locator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrganizationView extends HookWidget {
  const OrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final selectedFilter = useState('All');
    final followedOrganizations = useState<List<String>>([]);

    Widget buildFilterChip(String label) {
      return GestureDetector(
        onTap: () {
          selectedFilter.value = label;
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
              color: selectedFilter.value == label ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    Widget buildOrganizationCard({
      required String name,
      required String description,
      required String location,
      required String? imageUrl,
      required bool isFollowing,
    }) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl??"https://via.placeholder.com/150"),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(location),
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
                followedOrganizations.value = List.from(followedOrganizations.value)
                  ..remove(name);
              } else {
                followedOrganizations.value = List.from(followedOrganizations.value)
                  ..add(name);
              }
            },
            child: Text(isFollowing ? 'Following' : 'Follow'),
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => sl<OrganizationCubit>()..fetchAllOrganizations(language: 'en'),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            'Organizations',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list, color: Colors.black),
              onPressed: () {
                // Handle filter action
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
                    TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search organizations...',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          buildFilterChip('All'),
                          const SizedBox(width: 8),
                          buildFilterChip('Environmental'),
                          const SizedBox(width: 8),
                          buildFilterChip('Education'),
                          const SizedBox(width: 8),
                          buildFilterChip('Healthcare'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
BlocBuilder<OrganizationCubit, OrganizationState>(
  builder: (context, state) {
    // Use runtimeType or instanceof checks instead of when()
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
      return  SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
        
            return Skeletonizer(
              enabled: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: buildOrganizationCard(
                  name:  'Unknown Organization',
                  // Check what properties are available in your Organization model
                  // Replace 'description' with the correct property name
                  description:  'No description available',
                  location:  'Unknown location',
                  imageUrl: ',
                  isFollowing: false,
                ),
              ),
            );
          },
          childCount: 10,
        ),
      );
    } else if (state.runtimeType.toString().contains('Loaded')) {
      // Access organizations from the loaded state
      final loadedState = state as dynamic;
      final organizations = loadedState.organizations as List<dynamic>;
      
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final org = organizations[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildOrganizationCard(
                name: org.name ?? 'Unknown Organization',
                // Check what properties are available in your Organization model
                // Replace 'description' with the correct property name
                description:  'No description available',
                location:  'Unknown location',
                imageUrl: org.logo ?? org.image ?? org.avatar ?? 'https://via.placeholder.com/150',
                isFollowing: followedOrganizations.value.contains(org.name),
              ),
            );
          },
          childCount: organizations.length,
        ),
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
                  onPressed: () => context.read<OrganizationCubit>()
                      .fetchAllOrganizations(language: 'en'),
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
