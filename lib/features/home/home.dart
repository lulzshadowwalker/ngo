import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/features/opportunities/opportunity_detail_view.dart';
import 'package:ngo/features/post/data/model/post.dart';
import 'package:ngo/service_locator.dart';

import '../../export_tools.dart';
import '../../models/opportunity.dart';
import '../blog/blog_post_details_page.dart';
import '../notifications/notifications_home_export.dart';
import '../search_home/search_home_export.dart';
import 'cubit/home_cubit.dart';

class Home extends HookWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    var lang = AppLocalizations.of(context)!.localeName;
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..loadFollowingFeed(language: lang),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: const Text(
                    'NGO 962',
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search, color: Colors.black),
                      onPressed: () {
                        // Handle search action
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchHome()),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // Handle notifications action
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationsHome(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              
              
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      TabBar(
                        
                        dividerColor: Colors.transparent,
                        tabAlignment: TabAlignment.center,
                        controller: tabController,
                        indicatorColor: MyColors.primaryColor,
                        indicator: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: MyColors.primaryColor, width: 1.0),
                          ),
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        onTap: (index) {
                          if (index == 0) {
                            context.read<HomeCubit>().loadFollowingFeed();
                          } else {
                            context.read<HomeCubit>().loadRecentFeed();
                          }
                        },
                        tabs: [
                          Tab(text: AppLocalizations.of(context)!.following_ng),
                          Tab(text: AppLocalizations.of(context)!.recentlyNg),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),


                
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            'https://randomuser.me/api/portraits/women/44.jpg',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Complete Your Profile',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: 0.33,
                                      backgroundColor: Colors.grey[200],
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            MyColors.primaryColor,
                                          ),
                                      minHeight: 4,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Step 1 of 3',
                                    style: TextStyle(
                                       color: MyColors.primaryColor.withOpacity(0.8),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                
                
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 480, // Fixed height for TabBarView
                    child: TabBarView(
                      
                      controller: tabController,
                      children: [
                        // Following Feed
                        _buildFeedView(context, state, true),
                        // Recent Feed
                        _buildFeedView(context, state, false),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeedView(
    BuildContext context,
    HomeState state,
    bool isFollowing,
  ) {
    if (state.runtimeType.toString() == '_Initial') {
      return const Center(child: Text('Tap a tab to load content'));
    } else if (state.runtimeType.toString() == '_Loading') {
      return const Center(
        child: CircularProgressIndicator(color: MyColors.primaryColor),
      );
    } else if (state.runtimeType.toString() == '_FollowingLoaded') {
      final followingState = state as dynamic;
      if (!isFollowing) {
        return const Center(
          child: Text('Switch to Recent tab to see recent content'),
        );
      }
      final posts = followingState.posts as List;
      final opportunities = followingState.opportunities as List;
      if (posts.isEmpty && opportunities.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No following content yet',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                'Follow organizations to see their posts here',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              ),
            ],
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: () async {
          context.read<HomeCubit>().refreshFeed(isFollowing: true);
        },
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: posts.length + opportunities.length,
          itemBuilder: (context, index) {
            if (index < posts.length) {
              final post = posts[index];
              return _buildPostCard(post , context);
            } else {
              final opportunity = opportunities[index - posts.length];
              return _buildOpportunityCard(opportunity, context);
            }
          },
        ),
      );
    } else if (state.runtimeType.toString() == '_RecentLoaded') {
      final recentState = state as dynamic;
      if (isFollowing) {
        return const Center(
          child: Text('Switch to Following tab to see following content'),
        );
      }
      final posts = recentState.posts as List;
      final opportunities = recentState.opportunities as List;
      if (posts.isEmpty && opportunities.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.access_time, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              Text(
                'No recent content yet',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              const SizedBox(height: 8),
              Text(
                'Check back later for new posts and opportunities',
                style: TextStyle(fontSize: 14, color: Colors.grey[500]),
              ),
            ],
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: () async {
          context.read<HomeCubit>().refreshFeed(isFollowing: false);
        },
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: posts.length + opportunities.length,
          itemBuilder: (context, index) {
            if (index < posts.length) {
              final post = posts[index];
              return _buildPostCard(post, context);
            } else {
              final opportunity = opportunities[index - posts.length];
              return _buildOpportunityCard(opportunity, context);
            }
          },
        ),
      );
    } else if (state.runtimeType.toString() == '_Error') {
      final errorState = state as dynamic;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text(
              'Error loading feed',
              style: TextStyle(fontSize: 18, color: Colors.red[600]),
            ),
            const SizedBox(height: 8),
            Text(
              errorState.message ?? 'Unknown error',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<HomeCubit>().refreshFeed(isFollowing: isFollowing);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return const Center(child: Text('Unknown state'));
  }

  Widget _buildPostCard(Post post , BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle post tap action
        // For example, navigate to post detail view
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailsPage(slug: post.slug,),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
       
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: post.organization?.logo != null
                        ? NetworkImage(post.organization!.logo)
                        : null,
                    child: post.organization?.logo == null
                        ? Text(
                            post.organization?.name
                                    .substring(0, 1)
                                    .toUpperCase() ??
                                'O',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.organization?.name ?? 'Unknown Organization',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          post.createdAtReadable,
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                
                ],
              ),
            ),
            // Post Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                post.content,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ),
            const SizedBox(height: 12),
            // Post Image
            if (post.cover.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    post.cover,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.image, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
              ),
           const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildOpportunityCard(Opportunity opportunity, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Opportunity Image
          if (opportunity.cover.isNotEmpty)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: Image.network(
                  opportunity.cover,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image, color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Opportunity Type Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Featured Opportunity',
                    style: TextStyle(
                      color: MyColors.primaryColor.withValues(alpha: 0.4),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Title
                Text(
                  opportunity.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Organization Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(opportunity.organization.logo),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      opportunity.organization.name,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Location
                if (opportunity.locationDescription != null)
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey[600],
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        opportunity.locationDescription ?? "",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                const SizedBox(height: 12),
                // Description
                Text(
                  opportunity.description,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                // Apply Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OpportunityDetailView(
                            opportunityId: opportunity.id,
                          ),
                        ),
                      );
                      // Handle apply action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Apply Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
