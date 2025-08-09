


import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/export_tools.dart';

class OpportunitiesView extends HookWidget {
  const OpportunitiesView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final selectedFilter = useState('All');

    // Sample opportunities data
    final opportunities = [
      {
        'title': 'Youth Education Program',
        'organization': 'Jordan Education Initiative',
        'description': 'Support local students with their studies and help develop educational',
        'location': 'Amman, Jordan',
        'duration': '6 months',
        'image': 'assets/images/education.jpg',
        'category': 'Education',
      },
      {
        'title': 'Community Health Outreach',
        'organization': 'Health Care Society',
        'description': 'Assist in organizing health awareness campaigns and medical',
        'location': 'Zarqa, Jordan',
        'duration': '6 months',
        'image': 'assets/images/health.jpg',
        'category': 'Healthcare',
      },
      {
        'title': 'Environmental Conservation',
        'organization': 'Green Jordan',
        'description': 'Help teach basic computer skills to underprivileged communities.',
        'location': 'Aqaba, Jordan',
        'duration': '1 month',
        'image': 'assets/images/environment.jpg',
        'category': 'Environmental',
      },
      {
        'title': 'Digital Skills Workshop',
        'organization': 'Tech for All',
        'description': 'Help teach basic computer skills to underprivileged communities.',
        'location': 'Irbid, Jordan',
        'duration': '1 month',
        'image': 'assets/images/digital.jpg',
        'category': 'Education',
      },
    ];

    // Filter opportunities based on selected filter
    final filteredOpportunities = opportunities.where((opportunity) {
      if (selectedFilter.value == 'All') return true;
      return opportunity['category'] == selectedFilter.value;
    }).toList();

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
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // Handle filter action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search opportunities...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Filter Chips
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildFilterChip('All', selectedFilter),
                  const SizedBox(width: 8),
                  _buildFilterChip('Environmental', selectedFilter),
                  const SizedBox(width: 8),
                  _buildFilterChip('Education', selectedFilter),
                  const SizedBox(width: 8),
                  _buildFilterChip('Healthcare', selectedFilter),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Opportunities List
            Expanded(
              child: ListView.builder(
                itemCount: filteredOpportunities.length,
                itemBuilder: (context, index) {
                  final opportunity = filteredOpportunities[index];
                  return _buildOpportunityCard(
                    title: opportunity['title'] as String,
                    organization: opportunity['organization'] as String,
                    description: opportunity['description'] as String,
                    location: opportunity['location'] as String,
                    duration: opportunity['duration'] as String,
                    image: opportunity['image'] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, ValueNotifier<String> selectedFilter) {
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
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildOpportunityCard({
    required String title,
    required String organization,
    required String description,
    required String location,
    required String duration,
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Opportunity Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.primaryColor.withValues(alpha: 0.1),
            ),
            child: const Icon(
              Icons.volunteer_activism,
              color: MyColors.primaryColor,
              size: 30,
            ),
          ),
          const SizedBox(width: 12),
          
          // Opportunity Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  organization,
                  style: TextStyle(
                    fontSize: 14,
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
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
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      duration,
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
        ],
      ),
    );
  }
}
