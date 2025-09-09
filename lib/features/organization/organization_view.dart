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
    final showClearButton = useState(false);

    // مراقبة تغييرات النص لإظهار/إخفاء زر المسح
    useEffect(() {
      void listener() {
        showClearButton.value = searchController.text.isNotEmpty;
      }
      
      searchController.addListener(listener);
      return () => searchController.removeListener(listener);
    }, [searchController]);

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
              color: selectedFilter.value == label
                  ? Colors.white
                  : Colors.black,
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
                ? const Icon(
                    Icons.business,
                    color: Colors.white,
                    size: 30,
                  )
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
              Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
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
                context.read<OrganizationCubit>().unfollowOrganization(organizationId);
                followedOrganizations.value = List.from(
                  followedOrganizations.value,
                )..remove(name);
              } else {
                context.read<OrganizationCubit>().followOrganization(organizationId);
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
    return BlocProvider(
      create: (context) =>
          sl<OrganizationCubit>()..fetchAllOrganizations(language: lang.localeName),
      child: Builder(
        builder: (context) {
          return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title:  Text(
           lang.organizations,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                      onChanged: (query) {
                        // استخدام البحث مع الـ debounce
                        context.read<OrganizationCubit>().searchOrganizationsWithDebounce(query , language: lang.localeName);
                      },
                      onSubmitted: (query) {
                        context.read<OrganizationCubit>().searchOrganizations(query , language: lang.localeName);
                      },
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.searchOrganizations,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        suffixIcon: showClearButton.value
                            ? IconButton(
                                icon: const Icon(Icons.clear, color: Colors.grey),
                                onPressed: () {
                                  searchController.clear();
                                  context.read<OrganizationCubit>().clearSearch(language: lang.localeName);
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // إظهار مؤشر البحث إذا كان المستخدم يبحث
                    if (searchController.text.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search, size: 16, color: Colors.blue[700]),
                            const SizedBox(width: 4),
                            Text(
                              'البحث عن: "${searchController.text}"',
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    if (searchController.text.isNotEmpty)
                      const SizedBox(height: 12),
                      
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
                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Skeletonizer(
                        enabled: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: buildOrganizationCard(
                            name: 'Unknown Organization',
                            // Check what properties are available in your Organization model
                            // Replace 'description' with the correct property name
                            description: 'No description available',
                            location: 'Unknown location',
                            imageUrl: 'https://placehold.co/100',
                            isFollowing: false,
                            organizationId: '0', // placeholder for loading state
                            context: context,
                          ),
                        ),
                      );
                    }, childCount: 10),
                  );
                } else if (state.runtimeType.toString().contains('Loaded')) {
                  // Access organizations from the loaded state
                  final loadedState = state as dynamic;
                  final organizations =
                      loadedState.organizations as List<dynamic>;

                  // إذا كانت نتائج البحث فارغة
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
                                    ? 'لا توجد منظمات تطابق بحثك'
                                    : 'لا توجد منظمات متاحة',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                searchController.text.isNotEmpty
                                    ? 'جرب البحث بكلمات مختلفة'
                                    : 'تحقق من الاتصال بالإنترنت',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
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
                          // Check what properties are available in your Organization model
                          // Replace 'description' with the correct property name
                          description: org.sector ?? 'لا يوجد وصف',
                          location: org.location ?? 'موقع غير محدد',
                          imageUrl:
                              org.logo ??
                              org.image ??
                              org.avatar ??
                             'https://placehold.co/100',
                          isFollowing: followedOrganizations.value.contains(
                            org.name,
                          ),
                          organizationId: org.slug ?? '0', // Add organization ID
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
                                  .fetchAllOrganizations(language: lang.localeName),
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
        );
        }
      ),
    );
  }
}
