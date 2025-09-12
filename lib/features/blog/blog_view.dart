import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:ngo/features/post/data/model/post.dart';
import 'package:ngo/features/post/logic/post_cubit.dart';
import 'package:ngo/features/post/logic/post_state.dart';
import 'package:ngo/features/sectors_features/cubit/sectors_cubit.dart';
import 'package:ngo/service_locator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BlogView extends HookWidget {
  const BlogView({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<PostCubit>()..fetchAllPost(language: lang.localeName),
        ),
        BlocProvider(
          create: (context) =>
              sl<SectorsCubit>()..fetchAllSectors(language: lang.localeName),
        ),
      ],
      child: const _BlogContent(),
    );
  }
}

class _BlogContent extends HookWidget {
  const _BlogContent();

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('All');
    final showSearchField = useState(false);
    final searchController = useTextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
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
            icon: Icon(
              showSearchField.value ? Icons.close : Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              showSearchField.value = !showSearchField.value;
              if (!showSearchField.value) {
                searchController.clear();
                // Reset to all posts when closing search
                final lang = AppLocalizations.of(context)!;
                context.read<PostCubit>().fetchAllPost(language: lang.localeName);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search TextField Section
          if (showSearchField.value)
            Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search posts...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            final lang = AppLocalizations.of(context)!;
                            context.read<PostCubit>().fetchAllPost(language: lang.localeName);
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: MyColors.primaryColor),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                autofocus: true,
                onChanged: (query) {
                  if (query.isEmpty) {
                    final lang = AppLocalizations.of(context)!;
                    context.read<PostCubit>().fetchAllPost(language: lang.localeName);
                  }
                },
                onSubmitted: (query) {
                  if (query.trim().isNotEmpty) {
                    _performSearch(context, query.trim());
                  }
                },
              ),
            ),
          
          // Filter Chips Section
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: BlocBuilder<SectorsCubit, SectorsState>(
              builder: (context, sectorsState) {
                return _buildFilterChips(context, sectorsState, selectedFilter);
              },
            ),
          ),
          
          // Posts List Section
          Expanded(
            child: BlocBuilder<PostCubit, PostState>(
              buildWhen: (previous, current) =>
                  current is Loading || current is Loaded || current is Error,
              builder: (context, state) {
                return _buildPostsList(context, state, selectedFilter);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(
    BuildContext context,
    SectorsState sectorsState,
    ValueNotifier<String> selectedFilter,
  ) {
    Widget buildFilterChip(String label, {String? sectorId}) {
      final isSelected = selectedFilter.value == label;
      return GestureDetector(
        onTap: () {
          selectedFilter.value = label;
          final lang = AppLocalizations.of(context)!;
          
          if (label == 'All') {
            context.read<PostCubit>().fetchAllPost(language: lang.localeName);
          } else {
            context.read<PostCubit>().searchPosts(
              query: '',
              language: lang.localeName,
              sectorId: sectorId,
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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

    if (sectorsState.runtimeType.toString().contains('Loaded')) {
      final loadedState = sectorsState as dynamic;
      final sectors = loadedState.sectors as List<dynamic>;
      
      return ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          buildFilterChip('All'),
          ...sectors.map((sector) => buildFilterChip(
            sector.name ?? 'Unknown',
            sectorId: sector.id,
          )),
        ],
      );
    } else if (sectorsState.runtimeType.toString().contains('Loading')) {
      return const Center(child: CircularProgressIndicator());
    } else if (sectorsState.runtimeType.toString().contains('Error')) {
      return Center(
        child: Text(
          'Error loading categories',
          style: MyFonts.font12Black,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildPostsList(
    BuildContext context,
    PostState state,
    ValueNotifier<String> selectedFilter,
  ) {
    switch (state) {
      case Loading():
        return _buildLoadingSkeleton();
      case Loaded():
        final posts = state.posts;
        if (posts.isEmpty) {
          return _buildEmptyState(context);
        }
        return _buildPostsGrid(posts);
      case Error():
        return _buildErrorState(context, state.message);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildLoadingSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: List.generate(3, (index) {
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
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      color: Colors.grey[300],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 16,
                          width: double.infinity * 0.7,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPostsGrid(List<Post> posts) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return AnimatedPostTile(post: post, index: index);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.article_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Posts Available',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'There are no blog posts to display at the moment.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final lang = AppLocalizations.of(context)!;
              context.read<PostCubit>().fetchAllPost(language: lang.localeName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            'Error loading posts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              final lang = AppLocalizations.of(context)!;
              context.read<PostCubit>().fetchAllPost(language: lang.localeName);
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _performSearch(BuildContext context, String query) {
    final lang = AppLocalizations.of(context)!;
    context.read<PostCubit>().searchPosts(
      query: query,
      language: lang.localeName,
    );
  }
}

class AnimatedPostTile extends HookWidget {
  final Post post;
  final int index;

  const AnimatedPostTile({super.key, required this.post, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: Duration(milliseconds: 400 + index * 40),
    )..forward();

    final animation = useAnimation(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );

    return Opacity(  
      opacity: animation,
      child: Transform.translate(
        offset: Offset(0, 20 * (1 - animation)),
        child: PostCard(post: post),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("Post tapped: ${post.slug}");
        // Navigate to post details page
      },
      child: Container(
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
            // Cover Image with Category Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    post.cover,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                // Category Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(post.sector?.name ?? 'General'),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      post.sector?.name ?? 'General',
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

            // Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Content preview
                  Text(
                    post.content.length > 150
                        ? '${post.content.substring(0, 150)}...'
                        : post.content,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Meta Information Row
                  Row(
                    children: [
                      Text(
                        post.organization?.name ?? 'Unknown Author',
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
                        post.createdAtReadable,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${_calculateReadTime(post.content)} min read',
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
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'environment':
        return const Color(0xFF4CAF50);
      case 'education':
        return const Color(0xFF2196F3);
      case 'social justice':
        return const Color(0xFFFF9800);
      case 'health':
        return const Color(0xFFE91E63);
      default:
        return MyColors.primaryColor;
    }
  }

  int _calculateReadTime(String content) {
    // Average reading speed is about 200 words per minute
    final plainText = content.replaceAll(RegExp(r'<[^>]*>'), '');
    final wordCount = plainText
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;
    final readTime = (wordCount / 200).ceil();
    return readTime < 1 ? 1 : readTime;
  }
}

class InteractionRowPostCardSection extends StatelessWidget {
  const InteractionRowPostCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.favorite_border, color: Colors.grey[700], size: 20),
        const SizedBox(width: 4),
        const Text("245", style: TextStyle(fontSize: 13)),

        const SizedBox(width: 20),
        Icon(Icons.comment_outlined, color: Colors.grey[700], size: 20),
        const SizedBox(width: 4),
        const Text("18", style: TextStyle(fontSize: 13)),
      ],
    );
  }
}

class CoverImagePostCardSection extends StatelessWidget {
  const CoverImagePostCardSection({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        post.cover,
        fit: BoxFit.cover,
        width: double.infinity,
        height: 180,
        errorBuilder: (_, __, ___) => Container(
          height: 180,
          color: Colors.grey[200],
          alignment: Alignment.center,
          child: const Icon(Icons.broken_image, size: 40),
        ),
      ),
    );
  }
}

class ContentPostCardSection extends StatelessWidget {
  const ContentPostCardSection({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return TextComponent(
      title: post.content,
      style: MyFonts.font14Black,
      textAlign: TextAlign.start,
      maxLines: 2,
    );
  }
}

class HeaderPostCardSection extends StatelessWidget {
  const HeaderPostCardSection({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return post.organization == null
        ? Container()
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(post.organization!.logo),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      title: post.organization?.name ?? "Unknown Organization",
                      style: MyFonts.font14BlackBold,
                    ),
                    TextComponent(
                      title: post.createdAtReadable,
                      style: MyFonts.font12Black,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz, color: Colors.grey),
            ],
          );
  }
}
