import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/theme/my_colors.dart';
import '../../core/theme/my_fonts.dart';
import '../../export_tools.dart';
import '../../models/organization.dart';
import '../../models/user.dart';
import '../../service_locator.dart';
import '../auth/cubit/auth_cubit.dart';
import '../edit_proflie/edit_profle_export.dart';
import '../organization/cubit/organization_cubit.dart';
import '../organization/orgnization_detlis_view.dart';
import '../settings/settings_export.dart';
import '../splash/splash.dart';
import '../user_management/cubit/user_management_cubit.dart';

class ProfileView extends HookWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState(
      0,
    ); // 0: Following, 1: My Applications, 2: My Evaluations

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UserManagementCubit>()..fetchUserData(),
        ),
        BlocProvider(create: (context) => sl<OrganizationCubit>()),
      ],
      child: _ProfileViewContent(selectedTab: selectedTab),
    );
  }
}

class _ProfileViewContent extends HookWidget {
  final ValueNotifier<int> selectedTab;

  const _ProfileViewContent({required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextComponent(
          title: AppLocalizations.of(context)!.profile,
          style: MyFonts.font20Black.copyWith(fontWeight: FontWeight.w600),
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
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: BlocListener<OrganizationCubit, OrganizationState>(
        listener: (context, orgState) {
          final stateType = orgState.runtimeType.toString();
          // Listen for successful unfollow operations
          if (stateType.contains('LoadedSingleOrganization') ||
              stateType.contains('Loaded')) {
            // Refresh user data to update the following list
            context.read<UserManagementCubit>().fetchUserData();
          } else if (stateType.contains('Error')) {
            final errorState = orgState as dynamic;
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorState.message ?? 'An error occurred'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<UserManagementCubit, UserManagementState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                // Profile Header Section
                SliverToBoxAdapter(child: _buildProfileHeader(context, state)),

                // Tab Navigation
                SliverToBoxAdapter(
                  child: _buildTabNavigation(selectedTab, context),
                ),

                // Tab Content
                SliverToBoxAdapter(
                  child: _buildTabContent(context, selectedTab, state),
                ),

                // Bottom padding
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserManagementState state) {
    final stateType = state.runtimeType.toString();

    if (stateType.contains('Loading') || stateType.contains('Initial')) {
      return _buildLoadingHeader();
    } else if (stateType.contains('Error')) {
      return _buildErrorHeader(context, 'Error loading profile');
    } else if (stateType.contains('Loaded')) {
      // Cast the state to access the user data
      final loadedState = state as dynamic;
      if (loadedState.user != null) {
        return _buildUserHeaderWithData(context, loadedState.user);
      } else {
        return _buildErrorHeader(context, 'No user data available');
      }
    } else {
      return _buildLoadingHeader();
    }
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
              style: MyFonts.font20BlackBold.copyWith(color: Colors.black87),
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
              title:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
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

  Widget _buildUserHeaderWithData(BuildContext context, User user) {
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
              child: user.avatar != null && user.avatar!.isNotEmpty
                  ? Image.network(
                      user.avatar!,
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
            title: user.name.isNotEmpty ? user.name : 'User Name',
            style: MyFonts.font20BlackBold,
          ),

          const SizedBox(height: 4),

          TextComponent(
            title: user.email.isNotEmpty ? user.email : '@username',
            style: MyFonts.font14Black.copyWith(color: Colors.grey),
          ),

          const SizedBox(height: 8),

          // Location
          if (user.location != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                TextComponent(
                  title: user.location!.city,
                  style: MyFonts.font14Black.copyWith(color: Colors.grey),
                ),
              ],
            ),
          const SizedBox(height: 20),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(
                (user.following?.length ?? 0).toString(),
                AppLocalizations.of(context)!.following,
              ),
              _buildStatItem(
                (0).toString(),
                AppLocalizations.of(context)!.my_applications,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Bio
          if (user.bio != null && user.bio!.isNotEmpty)
            TextComponent(title: user.bio!, style: MyFonts.font14Black),

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
                  title: AppLocalizations.of(context)!.edit_profile,
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
          style: MyFonts.font20BlackBold.copyWith(color: Colors.black87),
        ),
        const SizedBox(height: 4),
        TextComponent(
          title: label,
          style: MyFonts.font14Black.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTabNavigation(
    ValueNotifier<int> selectedTab,
    BuildContext context,
  ) {
    final tabs = [
      AppLocalizations.of(context)!.following,
      AppLocalizations.of(context)!.my_applications,
    ];

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
    BuildContext context,
    ValueNotifier<int> selectedTab,
    UserManagementState state,
  ) {
    // Extract following organizations from state
    List<Organization> followingOrganizations = [];
    if (state.runtimeType.toString().contains('Loaded')) {
      final loadedState = state as dynamic;
      if (loadedState.user?.following != null) {
        followingOrganizations =
            loadedState.user.following as List<Organization>;
      }
    }

    switch (selectedTab.value) {
      case 0:
        return _buildFollowingTab(context, followingOrganizations);
      case 1:
        return _buildMyApplicationsTab();
      // case 2:
      //   return _buildMyEvaluationsTab();
      default:
        return Container();
    }
  }

  Widget _buildFollowingTab(
    BuildContext context,
    List<Organization> organizations,
  ) {
    if (organizations.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.people_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              TextComponent(
                title: 'No Organizations Followed',
                style: MyFonts.font18BlackBold.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              TextComponent(
                title: 'Start following organizations to see them here',
                style: MyFonts.font14Black.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: organizations
            .map((org) => _buildOrganizationCard(context, organization: org))
            .toList(),
      ),
    );
  }

  Widget _buildOrganizationCard(
    BuildContext context, {
    required Organization organization,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to organization details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OrgnizationDetlisView(slug: organization.slug),
          ),
        );
      },
      child: Container(
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
              child: organization.logo.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        organization.logo,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.business,
                            color: MyColors.primaryColor,
                            size: 24,
                          );
                        },
                      ),
                    )
                  : const Icon(
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
                          title: organization.name,
                          style: MyFonts.font16Black.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(width: 2),
                      if (organization.isFollowed)
                        const Icon(
                          Icons.verified,
                          size: 16,
                          color: Colors.blue,
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (organization.bio != null && organization.bio!.isNotEmpty)
                    TextComponent(
                      textAlign: TextAlign.start,
                      title: organization.bio!,
                      style: MyFonts.font14Black.copyWith(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  const SizedBox(height: 4),
                  if (organization.location.isNotEmpty)
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: TextComponent(
                            title: organization.location,
                            style: MyFonts.font12Black.copyWith(
                              color: Colors.grey,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // Following Button
            GestureDetector(
              onTap: () {
                _showUnfollowDialog(context, organization);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.primaryColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextComponent(
                  title: AppLocalizations.of(context)!.following,
                  style: MyFonts.font12Black.copyWith(
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: sl<AuthCubit>(),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              final stateType = state.runtimeType.toString();
              if (stateType.contains('Unauthenticated')) {
                // Close dialog first
                Navigator.of(dialogContext).pop();
                // Navigate to splash screen and remove all routes
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Splash()),
                  (route) => false,
                );
              } else if (stateType.contains('LogoutError')) {
                // Close dialog and show error
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logout failed. Please try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final stateType = state.runtimeType.toString();
                final isLoggingOut = stateType.contains('LoggingOut');

                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.logout),
                  content: isLoggingOut
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 16),
                            Text(AppLocalizations.of(context)!.logging_out),
                          ],
                        )
                      : Text(AppLocalizations.of(context)!.are_you_sure_logout),
                  actions: isLoggingOut
                      ? []
                      : [
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                            },
                            child: Text(AppLocalizations.of(context)!.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              final authCubit = context.read<AuthCubit>();
                              authCubit.logout();
                            },
                            child: Text(AppLocalizations.of(context)!.logout),
                          ),
                        ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showUnfollowDialog(BuildContext context, Organization organization) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Unfollow ${organization.name}?'),
          content: Text('Are you sure you want to unfollow this organization?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<OrganizationCubit>().unfollowOrganization(
                  organization.slug,
                );
                context.read<UserManagementCubit>().fetchUserData();
              },
              child: Text('Unfollow', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
