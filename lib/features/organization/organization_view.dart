import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/export_tools.dart';

class OrganizationView extends HookWidget {
  const OrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final selectedFilter = useState('All');
    final followingStates = useState<Map<String, bool>>({
      'Youth Empowerment Foundation': false,
      'Global Health Connect': false,
      'Green Earth Jordan': true,
      'Youth Education Alliance': false,
      'Justice For All': true,
    });

    // Sample organizations data
    final organizations = [
      {
        'name': 'Youth Empowerment Foundation',
        'description': 'Education & Development',
        'location': 'Zarqa, Jordan',
        'imageUrl': 'https://randomuser.me/api/portraits/men/45.jpg',
        'category': 'Education',
      },
      {
        'name': 'Global Health Connect',
        'description': 'Healthcare & Development',
        'location': 'Aqaba, Jordan',
        'imageUrl': 'https://randomuser.me/api/portraits/men/32.jpg',
        'category': 'Healthcare',
      },
      {
        'name': 'Green Earth Jordan',
        'description': 'Environmental Conservation',
        'location': 'Amman, Jordan',
        'imageUrl': 'https://randomuser.me/api/portraits/men/33.jpg',
        'category': 'Environmental',
      },
      {
        'name': 'Youth Education Alliance',
        'description': 'Education & Development',
        'location': 'Amman, Jordan',
        'imageUrl': 'https://randomuser.me/api/portraits/men/34.jpg',
        'category': 'Education',
      },
      {
        'name': 'Justice For All',
        'description': 'Human Rights Advocacy',
        'location': 'Amman, Jordan',
        'imageUrl': 'https://randomuser.me/api/portraits/men/35.jpg',
        'category': 'Healthcare',
      },
    ];

    // Filter organizations based on selected filter
    final filteredOrganizations = organizations.where((org) {
      if (selectedFilter.value == 'All') return true;
      return org['category'] == selectedFilter.value;
    }).toList();

    Widget buildFilterChip(String label) {
      final isSelected = selectedFilter.value == label;
      return GestureDetector(
        onTap: () {
          selectedFilter.value = label;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? MyColors.primaryColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
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
      required String imageUrl,
    }) {
      final isFollowing = followingStates.value[name] ?? false;
      
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(
            name,
          style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
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
              backgroundColor: isFollowing ? Colors.grey[300] : MyColors.primaryColor,
              foregroundColor: isFollowing ? Colors.black : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              // Toggle follow state using hooks
              final currentStates = Map<String, bool>.from(followingStates.value);
              currentStates[name] = !isFollowing;
              followingStates.value = currentStates;
            },
            child: Text(isFollowing ? 'Following' : 'Follow'),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
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
                  // Search Bar
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
                  
                  // Filter Chips
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
          
          // Organizations List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final org = filteredOrganizations[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: buildOrganizationCard(
                    name: org['name'] as String,
                    description: org['description'] as String,
                    location: org['location'] as String,
                    imageUrl: org['imageUrl'] as String,
                  ),
                );
              },
              childCount: filteredOrganizations.length,
            ),
          ),
        ],
      ),
    );
  }
}
