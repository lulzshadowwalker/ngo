import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/theme/my_colors.dart';
import '../../core/theme/my_fonts.dart';
import '../../export_tools.dart';
import '../../service_locator.dart';
import '../edit_proflie/edit_profle_export.dart';
import '../settings/settings_export.dart';
import '../user_management/cubit/user_management_cubit.dart';

class ProfileView extends HookWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(
      0,
    ); // 0: Following, 1: My Applications, 2: My Evaluations

    return BlocProvider(
      create: (context) => sl<UserManagementCubit>()..fetchUserData(),
      child: _ProfileViewContent(selectedTab: selectedTab),
    );
  }
}

class _ProfileViewContent extends HookWidget {
  final ValueNotifier<int> selectedTab;

  const _ProfileViewContent({required this.selectedTab});

  @override
  Widget build(BuildContext context) {
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
        title: TextComponent(
          title: 'Profile',
          style: MyFonts.font20Black.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              context.read<UserManagementCubit>().fetchUserData();
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Handle search action
            },
          ),
        ],
      ),
      body: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // Profile Header Section
              SliverToBoxAdapter(child: _buildProfileHeader(context, state)),

              // Tab Navigation
              SliverToBoxAdapter(child: _buildTabNavigation(selectedTab)),

              // Tab Content
              SliverToBoxAdapter(
                child: _buildTabContent(selectedTab, followingOrganizations),
              ),

              // Bottom padding
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserManagementState state) {
    // Handle different states properly
    if (state.toString().contains('loading') ||
        state.toString().contains('initial')) {
      return _buildLoadingHeader();
    } else if (state.toString().contains('error')) {
      return _buildErrorHeader(context, 'Error loading profile');
    } else if (state.toString().contains('loaded')) {
      // Extract user data from the loaded state
      return _buildUserHeaderFromState(context, state);
    } else {
      return _buildLoadingHeader();
    }
  }

  Widget _buildUserHeaderFromState(
    BuildContext context,
    UserManagementState state,
  ) {
    Map<String, dynamic>? userData;

    try {
      final stateString = state.toString();

      if (stateString.contains('User(')) {
        // Extract user name
        final nameMatch = RegExp(r'name: ([^,\)]+)').firstMatch(stateString);
        final emailMatch = RegExp(r'email: ([^,\)]+)').firstMatch(stateString);
        final avatarMatch = RegExp(
          r'avatar: ([^,\)]+)',
        ).firstMatch(stateString);
        final locationMatch = RegExp(
          r'Location\([^)]*city: ([^,\)]+)',
        ).firstMatch(stateString);
        final bioMatch = RegExp(r'bio: ([^,\)]+)').firstMatch(stateString);

        userData = {
          'name': nameMatch?.group(1)?.trim() ?? 'User Name',
          'email': emailMatch?.group(1)?.trim() ?? '@username',
          'avatar': avatarMatch?.group(1)?.trim() != 'null'
              ? avatarMatch?.group(1)?.trim()
              : null,
          'location': locationMatch?.group(1)?.trim() != 'null'
              ? locationMatch?.group(1)?.trim()
              : null,
          'bio': bioMatch?.group(1)?.trim() != 'null'
              ? bioMatch?.group(1)?.trim()
              : null,
        };
      }
    } catch (e) {
      debugPrint('Error parsing user data: $e');
    }

    return _buildUserHeaderWithData(context, userData);
  }

  Widget _buildLoadingHeader() {
    return Skeletonizer(
      enabled: true,
      child: Container(
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
                  child: Icon(Icons.person, size: 50, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Name and Email
            TextComponent(
              title: 'User Name',
              style: MyFonts.font20BlackBold.copyWith(
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            TextComponent(
              title: '@username',
              style: MyFonts.font16Black.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 8),

            // Location
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                TextComponent(
                  title: "South Logan",
                  style: MyFonts.font14Black.copyWith(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 20),
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
            TextComponent(
              title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: MyFonts.font14Black.copyWith(
                color: Colors.black54,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // Edit Profile Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
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
                  child: TextComponent(
                    title: 'Edit Profile',
                    style: MyFonts.font16Black.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorHeader(BuildContext context, String error) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          TextComponent(
            title: 'Error loading profile',
            style: MyFonts.font18BlackBold.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          TextComponent(
            title: error,
            style: MyFonts.font14Black.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<UserManagementCubit>().fetchUserData();
            },
            child: TextComponent(
              title: 'Retry',
              style: MyFonts.font14Black.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildUserHeaderWithData(BuildContext context, dynamic user) {
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
              child: user != null && user['avatar'] != null
                  ? Image.network(
                      user['avatar'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 16),

          // Name and Email
          TextComponent(
            title: user != null ? user['name'] ?? 'User Name' : 'User Name',
            style: MyFonts.font20BlackBold,
          ),

          const SizedBox(height: 4),

          TextComponent(
            title: user != null ? user['email'] ?? '@username' : '@username',
            style: MyFonts.font14Black.copyWith(color: Colors.grey),
          ),

          const SizedBox(height: 8),

          // Location
          if (user != null && user['location'] != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                TextComponent(
                  title: user['location'],
                  style: MyFonts.font14Black.copyWith(color: Colors.grey),
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
          if (user != null && user['bio'] != null)
            TextComponent(title: user['bio'], style: MyFonts.font14Black),

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
                child: TextComponent(
                  title: "Edit Profile",
                  style: MyFonts.font16Black.copyWith(color: Colors.white),
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
        TextComponent(
          title: number,
          style: MyFonts.font20BlackBold.copyWith(
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        TextComponent(
          title: label,
          style: MyFonts.font14Black.copyWith(color: Colors.grey),
        ),
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
                child: TextComponent(
                  title: title,
                  style: MyFonts.font14Black.copyWith(
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextComponent(
                        textAlign: TextAlign.start,
                        title: name,
                        style: MyFonts.font16Black.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(width: 2),
                    if (isVerified)
                      const Icon(Icons.verified, size: 16, color: Colors.blue),
                  ],
                ),
                const SizedBox(height: 4),
                TextComponent(
                  textAlign: TextAlign.start,
                  title: description,
                  style: MyFonts.font14Black.copyWith(color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    TextComponent(
                      title: location,
                      style: MyFonts.font12Black.copyWith(color: Colors.grey),
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
            child: TextComponent(
              title: 'Following',
              style: MyFonts.font12Black.copyWith(
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
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.assignment, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            TextComponent(
              title: 'No Applications Yet',
              style: MyFonts.font18BlackBold.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            TextComponent(
              title: 'Your volunteer applications will appear here',
              style: MyFonts.font14Black.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyEvaluationsTab() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.rate_review, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            TextComponent(
              title: 'No Evaluations Yet',
              style: MyFonts.font18BlackBold.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            TextComponent(
              title: 'Your volunteer evaluations will appear here',
              style: MyFonts.font14Black.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
