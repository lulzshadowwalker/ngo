import '../../core/theme/my_colors.dart';
import '../../export_tools.dart';
import '../edit_proflie/edit_profle_export.dart';
import '../settings/settings_export.dart';

class ProfileView extends HookWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(
      0,
    ); // 0: Following, 1: My Applications, 2: My Evaluations

    // Sample following organizations data
    final followingOrganizations = [
      {
        'name': 'Youth Empowerment Foundation',
        'description': 'Education & Development',
        'location': 'Zarqa, Jordan',
        'image': 'assets/images/youth_foundation.jpg',
        'isVerified': true,
      },
      {
        'name': 'Global Health Connect',
        'description': 'Healthcare & Development',
        'location': 'Aqaba, Jordan',
        'image': 'assets/images/health_connect.jpg',
        'isVerified': false,
      },
      {
        'name': 'Green Earth Jordan',
        'description': 'Environmental Conservation',
        'location': 'Amman, Jordan',
        'image': 'assets/images/green_earth.jpg',
        'isVerified': true,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
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
          // Profile Header Section
          SliverToBoxAdapter(child: _buildProfileHeader(context)),

          // Tab Navigation
          SliverToBoxAdapter(child: _buildTabNavigation(selectedTab)),

          // Tab Content
          SliverToBoxAdapter(
            child: _buildTabContent(selectedTab, followingOrganizations),
          ),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Profile Picture
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: MyColors.primaryColor, width: 3),
            ),
            child: ClipOval(
              child: Container(
                color: Colors.grey[200],
                child: const Icon(Icons.person, size: 50, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Name and Username
          const Text(
            'Sarah Johnson',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '@sarahjohnson',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),

          // Location
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.location_on, size: 16, color: Colors.grey),
              SizedBox(width: 4),
              Text(
                'Amman, Jordan',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('24', 'Following'),
              _buildStatItem('12', 'Evaluations'),
              _buildStatItem('8', 'Applications'),
            ],
          ),
          const SizedBox(height: 20),

          // Bio
          const Text(
            'Passionate about community development and sustainable initiatives in Jordan',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.4),
          ),
          const SizedBox(height: 24),

          // Edit Profile Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileView(),
                  ),
                );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsView(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildTabNavigation(ValueNotifier<int> selectedTab) {
    final tabs = ['Following', 'My Applications', 'My Evaluations'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final title = entry.value;
          final isSelected = selectedTab.value == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                selectedTab.value = index;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected
                          ? MyColors.primaryColor
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? MyColors.primaryColor : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabContent(
    ValueNotifier<int> selectedTab,
    List<Map<String, dynamic>> followingOrganizations,
  ) {
    switch (selectedTab.value) {
      case 0:
        return _buildFollowingTab(followingOrganizations);
      case 1:
        return _buildMyApplicationsTab();
      case 2:
        return _buildMyEvaluationsTab();
      default:
        return Container();
    }
  }

  Widget _buildFollowingTab(List<Map<String, dynamic>> organizations) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: organizations
            .map(
              (org) => _buildOrganizationCard(
                name: org['name'] as String,
                description: org['description'] as String,
                location: org['location'] as String,
                image: org['image'] as String,
                isVerified: org['isVerified'] as bool,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildOrganizationCard({
    required String name,
    required String description,
    required String location,
    required String image,
    required bool isVerified,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          // Organization Image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.primaryColor.withValues(alpha: 0.1),
            ),
            child: const Icon(
              Icons.business,
              color: MyColors.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          // Organization Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (isVerified)
                      const Icon(Icons.verified, size: 16, color: Colors.blue),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      location,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Following Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.primaryColor),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Following',
              style: TextStyle(
                fontSize: 12,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyApplicationsTab() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: const Center(
        child: Column(
          children: [
            Icon(Icons.assignment, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No Applications Yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your volunteer applications will appear here',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyEvaluationsTab() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: const Center(
        child: Column(
          children: [
            Icon(Icons.rate_review, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No Evaluations Yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your volunteer evaluations will appear here',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
