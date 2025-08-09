

import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/export_tools.dart';

class BlogView extends HookWidget {
  const BlogView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('All');

    // Sample blog posts data
    final blogPosts = [
      {
        'title': 'Youth-Led Climate Action: Making a Difference in Local Communities',
        'description': 'Discover how young environmental activists are leading innovative projects to combat climate change.',
        'category': 'Environment',
        'image': 'assets/images/climate_action.jpg',
        'readTime': '5 min read',
        'author': 'Sarah Ahmad',
        'date': '2 days ago',
      },
      {
        'title': 'Digital Learning Revolution: Bridging Educational Gaps',
        'description': 'How technology and community initiatives are working together to ensure equal access to education.',
        'category': 'Education',
        'image': 'assets/images/digital_learning.jpg',
        'readTime': '7 min read',
        'author': 'Ahmed Hassan',
        'date': '4 days ago',
      },
      {
        'title': 'Youth Voices in Social Reform: Creating Lasting Change',
        'description': 'Young activists share their experiences and strategies in advocating for social justice and reform.',
        'category': 'Social Justice',
        'image': 'assets/images/social_reform.jpg',
        'readTime': '6 min read',
        'author': 'Layla Ibrahim',
        'date': '1 week ago',
      },
      {
        'title': 'Sustainable Agriculture: Growing Hope in Rural Jordan',
        'description': 'Community-led farming initiatives are transforming rural landscapes and providing food security.',
        'category': 'Environment',
        'image': 'assets/images/agriculture.jpg',
        'readTime': '8 min read',
        'author': 'Omar Khalil',
        'date': '1 week ago',
      },
      {
        'title': 'Breaking Barriers: Women in Leadership Roles',
        'description': 'Empowering women to take leadership positions in community development and social change.',
        'category': 'Social Justice',
        'image': 'assets/images/women_leadership.jpg',
        'readTime': '5 min read',
        'author': 'Fatima Al-Zahra',
        'date': '2 weeks ago',
      },
    ];

    // Filter blog posts based on selected filter
    final filteredPosts = blogPosts.where((post) {
      if (selectedFilter.value == 'All') return true;
      return post['category'] == selectedFilter.value;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Community Blog',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Filter Chips Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildFilterChip('All', selectedFilter),
                    const SizedBox(width: 12),
                    _buildFilterChip('Environment', selectedFilter),
                    const SizedBox(width: 12),
                    _buildFilterChip('Education', selectedFilter),
                    const SizedBox(width: 12),
                    _buildFilterChip('Social Justice', selectedFilter),
                  ],
                ),
              ),
            ),
          ),
          
          // Blog Posts List
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final post = filteredPosts[index];
                  return _buildBlogPostCard(
                    title: post['title'] as String,
                    description: post['description'] as String,
                    category: post['category'] as String,
                    image: post['image'] as String,
                    readTime: post['readTime'] as String,
                    author: post['author'] as String,
                    date: post['date'] as String,
                  );
                },
                childCount: filteredPosts.length,
              ),
            ),
          ),
          
          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

  Widget _buildBlogPostCard({
    required String title,
    required String description,
    required String category,
    required String image,
    required String readTime,
    required String author,
    required String date,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blog Image
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: _getCategoryColor(category).withValues(alpha: 0.1),
            ),
            child: Stack(
              children: [
                // Placeholder for image - you can replace with actual image
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        _getCategoryColor(category).withValues(alpha: 0.3),
                        _getCategoryColor(category).withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                ),
                // Category Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(category),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      category,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Blog Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      author,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      readTime,
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Environment':
        return const Color(0xFF4CAF50);
      case 'Education':
        return const Color(0xFF2196F3);
      case 'Social Justice':
        return const Color(0xFFFF9800);
      default:
        return MyColors.primaryColor;
    }
  }
}
