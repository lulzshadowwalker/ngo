import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchHome extends HookWidget {
  const SearchHome({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final selectedFilter = useState('All');

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

    Widget buildSearchResultCard({
      required String title,
      required String subtitle,
      required String location,
      required String imageUrl,
      required bool isFollowing,
    }) {
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
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(subtitle),
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
              // Handle follow/unfollow action
            },
            child: Text(isFollowing ? 'Following' : 'Follow'),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search NGOs, programs, opportunities.',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildFilterChip('All'),
                buildFilterChip('NGOs'),
                buildFilterChip('Programs'),
                buildFilterChip('Opportunities'),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Search Results',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  buildSearchResultCard(
                    title: 'Youth Empowerment Foundation',
                    subtitle: 'Education & Development',
                    location: 'Zarqa, Jordan',
                    imageUrl:
                        'https://randomuser.me/api/portraits/men/45.jpg',
                    isFollowing: true,
                  ),
                  buildSearchResultCard(
                    title: 'Green Earth Jordan',
                    subtitle: 'Environmental Conservation',
                    location: 'Amman, Jordan',
                    imageUrl:
                        'https://randomuser.me/api/portraits/men/32.jpg',
                    isFollowing: true,
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Environmental Education Program Coordinator',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                  'https://randomuser.me/api/portraits/men/32.jpg',
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text('Green Earth Jordan'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              const Text('Amman, Jordan'),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              Chip(
                                label: const Text('Education'),
                                backgroundColor: Colors.green[50],
                                labelStyle: const TextStyle(color: Colors.green),
                              ),
                              Chip(
                                label: const Text('Environment'),
                                backgroundColor: Colors.green[50],
                                labelStyle: const TextStyle(color: Colors.green),
                              ),
                              Chip(
                                label: const Text('Project Management'),
                                backgroundColor: Colors.green[50],
                                labelStyle: const TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Application deadline 20/8/2025',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  buildSearchResultCard(
                    title: 'Youth Mentorship Program Volunteer',
                    subtitle: 'Youth Empowerment Foundation',
                    location: 'Zarqa, Jordan',
                    imageUrl:
                        'https://randomuser.me/api/portraits/men/45.jpg',
                    isFollowing: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
