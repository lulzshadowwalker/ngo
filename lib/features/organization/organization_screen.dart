import 'package:flutter/material.dart';

class OrganizationScreen extends StatelessWidget {
  const OrganizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.grey[200],
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
                        buildFilterChip('All', true, () {
                          // Handle filter selection
                        }),
                        const SizedBox(width: 8),
                        buildFilterChip('Environmental', false, () {
                          // Handle filter selection
                        }),
                        const SizedBox(width: 8),
                        buildFilterChip('Education', false, () {
                          // Handle filter selection
                        }),
                        const SizedBox(width: 8),
                        buildFilterChip('Healthcare', false, () {
                          // Handle filter selection
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              buildOrganizationCard(
                name: 'Youth Empowerment Foundation',
                description: 'Education & Development',
                location: 'Zarqa, Jordan',
                imageUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
                isFollowing: false,
              ),
              buildOrganizationCard(
                name: 'Global Health Connect',
                description: 'Healthcare & Development',
                location: 'Aqaba, Jordan',
                imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
                isFollowing: false,
              ),
              buildOrganizationCard(
                name: 'Green Earth Jordan',
                description: 'Environmental Conservation',
                location: 'Amman, Jordan',
                imageUrl: 'https://randomuser.me/api/portraits/men/33.jpg',
                isFollowing: true,
              ),
              buildOrganizationCard(
                name: 'Youth Education Alliance',
                description: 'Education & Development',
                location: 'Amman, Jordan',
                imageUrl: 'https://randomuser.me/api/portraits/men/34.jpg',
                isFollowing: false,
              ),
              buildOrganizationCard(
                name: 'Justice For All',
                description: 'Human Rights Advocacy',
                location: 'Amman, Jordan',
                imageUrl: 'https://randomuser.me/api/portraits/men/35.jpg',
                isFollowing: true,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
