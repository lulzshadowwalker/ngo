import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/organization/cubit/organization_cubit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constant/app_assets.dart';
import '../../core/theme/my_colors.dart';
import '../../service_locator.dart';

class OrgnizationDetlisView extends HookWidget {
  const OrgnizationDetlisView({super.key, required this.slug});
  final String slug;

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    final selectedTabIndex = useState(0);
    final isAboutExpanded = useState(false);

    return BlocProvider(
      create: (context) =>
          sl<OrganizationCubit>()
            ..fetchOrganization(slug, language: lang.localeName),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Organization Details',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: SvgPicture.asset(
                  AppIcons.sharedICon,
                  width: 24,
                  height: 24,
                ),
                onPressed: () async {
                  final organizationCubit = context.read<OrganizationCubit>();
                  final organizationState = organizationCubit.state;
                  if (organizationState.runtimeType.toString().contains(
                    'LoadedSingleOrganization',
                  )) {
                    final loadedState = organizationState as dynamic;
                    final organization = loadedState.organization;
                    final shareText =
                        '${organization.name}\n\n${organization.bio ?? ''}\n\nCheck out this organization in the NGO app.';
                    Share.share(shareText);
                  }
                },
              ),
            ],
          ),
          body: BlocBuilder<OrganizationCubit, OrganizationState>(
            builder: (context, state) {
              if (state.runtimeType.toString().contains('Loading') ||
                  state.runtimeType.toString().contains('Initial')) {
                return _buildLoadingSkeleton();
              } else if (state.runtimeType.toString().contains(
                'LoadedSingleOrganization',
              )) {
                final loadedState = state as dynamic;
                final organization = loadedState.organization;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Organization Header with Background Image
                      _buildOrganizationHeader(organization),

                      // Organization Info Card
                      _buildOrganizationInfo(organization),

                      // Contact Buttons
                      _buildContactButtons(organization),

                      // About Us Section
                      _buildAboutSection(organization, isAboutExpanded),

                      // Tab Navigation
                      _buildTabNavigation(selectedTabIndex),

                      // Tab Content
                      _buildTabContent(selectedTabIndex.value, organization),

                      const SizedBox(height: 20),
                    ],
                  ),
                );
              } else if (state.runtimeType.toString().contains('Error')) {
                final errorState = state as dynamic;
                return _buildErrorState(
                  errorState.message ?? 'Failed to load organization',
                  () {
                    context.read<OrganizationCubit>().fetchOrganization(
                      slug,
                      language: lang.localeName,
                    );
                  },
                );
              }

              return const Center(child: Text('Unknown state'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOrganizationHeader(dynamic organization) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        image: organization.logo.isNotEmpty
            ? DecorationImage(
                image: CachedNetworkImageProvider(organization.logo),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3),
                  BlendMode.darken,
                ),
              )
            : null,
      ),
      child: Stack(
        children: [
          if (organization.logo.isEmpty)
            Container(
              color: MyColors.primaryColor.withOpacity(0.8),
              child: const Center(
                child: Icon(Icons.business, size: 80, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOrganizationInfo(dynamic organization) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Organization Logo
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!, width: 2),
              color: Colors.white,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: organization.logo.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: organization.logo,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        color: MyColors.primaryColor,
                        child: const Icon(
                          Icons.business,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    )
                  : Container(
                      color: MyColors.primaryColor,
                      child: const Icon(
                        Icons.business,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 16),

          // Organization Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  organization.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 4),

                // Sector
                Row(
                  children: [
                    Icon(Icons.category, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        organization.sector,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Location
                Row(
                  children: [
                    Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        organization.location,
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
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

  Widget _buildContactButtons(dynamic organization) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Builder(
        builder: (context) => Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  _launchEmail(context, organization.name);
                },
                icon: const Icon(Icons.email, size: 18),
                label: const Text('Contact'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed:
                    organization.website != null &&
                        organization.website!.isNotEmpty
                    ? () {
                        _launchWebsite(context, organization.website!);
                      }
                    : null,
                icon: const Icon(Icons.language, size: 18),
                label: const Text('Website'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(
    dynamic organization,
    ValueNotifier<bool> isExpanded,
  ) {
    const int maxLines = 3; // Number of lines to show when collapsed
    final String bioText = organization.bio ?? 'No description available.';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          ValueListenableBuilder<bool>(
            valueListenable: isExpanded,
            builder: (context, expanded, child) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  // Create a TextPainter to measure text
                  final textPainter = TextPainter(
                    text: TextSpan(
                      text: bioText,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    maxLines: maxLines,
                    textDirection: TextDirection.ltr,
                  );
                  textPainter.layout(maxWidth: constraints.maxWidth);

                  final bool isTextOverflowing = textPainter.didExceedMaxLines;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Text(
                          bioText,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                          maxLines: expanded ? null : maxLines,
                          overflow: expanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                        ),
                      ),
                      if (isTextOverflowing) // Only show read more if text actually overflows
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: GestureDetector(
                            onTap: () {
                              isExpanded.value = !isExpanded.value;
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  expanded ? 'Read less' : 'Read more',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                AnimatedRotation(
                                  turns: expanded ? 0.5 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.blue,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavigation(ValueNotifier<int> selectedTabIndex) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildTabItem('Programs', 0, selectedTabIndex),
          // _buildTabItem('Volunteer', 1, selectedTabIndex),
          // _buildTabItem('Vacancies', 2, selectedTabIndex),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    String title,
    int index,
    ValueNotifier<int> selectedTabIndex,
  ) {
    final isSelected = selectedTabIndex.value == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => selectedTabIndex.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? MyColors.primaryColor : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? MyColors.primaryColor : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(int selectedIndex, dynamic organization) {
    switch (selectedIndex) {
      case 0:
        return _buildProgramsTab();
      // case 1:
      //   return _buildVolunteerTab();
      // case 2:
      //   return _buildVacanciesTab();
      default:
        return _buildProgramsTab();
    }
  }

  Widget _buildProgramsTab() {
    return Column(
      children: [
        _buildProgramCard(
          title: 'Integrity School',
          description:
              'Developing tomorrow\'s leaders through workshops and mentorship',
          duration: 'Sep 2025 - Dec 2027',
          status: 'Ongoing',
          statusColor: MyColors.primaryColor,
          imageUrl:
              'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=400',
        ),
        _buildProgramCard(
          title: 'Action For Integrity',
          description:
              'Teaching essential digital skills to empower youth in the modern workplace',
          duration: 'Sep 2025 - Dec 2027',
          status: 'Upcoming',
          statusColor: Colors.orange,
          imageUrl:
              'https://images.unsplash.com/photo-1531482615713-2afd69097998?w=400',
        ),
      ],
    );
  }

  Widget _buildVolunteerTab() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          'No volunteer opportunities available',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildVacanciesTab() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          'No vacancies available',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildProgramCard({
    required String title,
    required String description,
    required String duration,
    required String status,
    required Color statusColor,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Program Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                height: 150,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          // Program Details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      'Duration: $duration',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
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

  Widget _buildLoadingSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header skeleton
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
            ),

            // Organization info skeleton
            Container(
              margin: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 20, color: Colors.grey[300]),
                        const SizedBox(height: 8),
                        Container(
                          height: 16,
                          width: 150,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 16,
                          width: 120,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ],
              ),
            ),

            // About section skeleton
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20, width: 100, color: Colors.grey[300]),
                  const SizedBox(height: 8),
                  ...List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Container(height: 16, color: Colors.grey[300]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message, VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods for launching external apps
  void _handleFollowToggle(
    BuildContext context,
    dynamic organization,
    ValueNotifier<bool> isFollowLoading,
  ) {
    final organizationCubit = context.read<OrganizationCubit>();

    if (organization.isFollowed) {
      // Show confirmation dialog for unfollowing
      _showUnfollowConfirmation(
        context,
        organization,
        organizationCubit,
        isFollowLoading,
      );
    } else {
      // Follow immediately
      _performFollowAction(
        context,
        organizationCubit,
        organization,
        isFollowLoading,
        true,
      );
    }
  }

  Future<void> _performFollowAction(
    BuildContext context,
    OrganizationCubit cubit,
    dynamic organization,
    ValueNotifier<bool> isFollowLoading,
    bool isFollow,
  ) async {
    isFollowLoading.value = true;

    try {
      if (isFollow) {
        await cubit.followOrganization(organization.slug);
        _showSuccessSnackBar(
          context,
          'You are now following ${organization.name}',
        );
      } else {
        await cubit.unfollowOrganization(organization.slug);
        _showSuccessSnackBar(context, 'You unfollowed ${organization.name}');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Something went wrong. Please try again.');
    } finally {
      isFollowLoading.value = false;
    }
  }

  void _showUnfollowConfirmation(
    BuildContext context,
    dynamic organization,
    OrganizationCubit cubit,
    ValueNotifier<bool> isFollowLoading,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Unfollow Organization'),
          content: Text(
            'Are you sure you want to unfollow ${organization.name}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _performFollowAction(
                  context,
                  cubit,
                  organization,
                  isFollowLoading,
                  false,
                );
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Unfollow'),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: MyColors.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _launchEmail(
    BuildContext context,
    String organizationName,
  ) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: '', // You can add a default email here if available
      query:
          'subject=Contact Request for $organizationName&body=Hello $organizationName,\n\nI would like to get in touch with your organization.\n\nBest regards,',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showErrorSnackBar(context, 'Could not open email app');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error opening email: $e');
    }
  }

  Future<void> _launchWebsite(BuildContext context, String websiteUrl) async {
    // Ensure the URL has a proper scheme
    String url = websiteUrl;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final Uri websiteUri = Uri.parse(url);

    try {
      if (await canLaunchUrl(websiteUri)) {
        await launchUrl(websiteUri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar(context, 'Could not open website');
      }
    } catch (e) {
      _showErrorSnackBar(context, 'Error opening website: $e');
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[600],
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
