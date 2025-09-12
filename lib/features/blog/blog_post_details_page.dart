import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/post/logic/post_cubit.dart';
import 'package:ngo/features/post/logic/post_state.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../core/constant/app_assets.dart';
import '../../core/theme/my_colors.dart';
import '../../service_locator.dart';

class PostDetailsPage extends HookWidget {
  const PostDetailsPage({super.key, required this.slug});
  final String slug;

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => sl<PostCubit>()..fetchSinglePost(slug: slug , language: lang.localeName),
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
              'Article',
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
                  final postCubit = context.read<PostCubit>();
                  final postState = postCubit.state;
                  if (postState.runtimeType.toString().contains('LoadedSinglePost')) {
                    final loadedState = postState as dynamic;
                    final post = loadedState.post;
                    final shareText = '${post.title}\n\n${post.content}\n\nRead more in the NGO app.';
                    Share.share(shareText);
                  }
                },
              ),
            ],
          ),
        body: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state.runtimeType.toString().contains('Loading') ||
                state.runtimeType.toString().contains('Initial')) {
              return _buildLoadingSkeleton();
            } else if (state.runtimeType.toString().contains('LoadedSinglePost')) {
              final loadedState = state as dynamic;
              final post = loadedState.post;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Article Title
                    Text(
                      post.title ?? 'Untitled Article',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Author Info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: post.organization?.logo != null
                              ? CachedNetworkImageProvider(post.organization!.logo!)
                              : null,
                          child: post.organization?.logo == null
                              ? const Icon(Icons.person, color: Colors.white)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.organization?.name ??
                                    'Anonymous Organization',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    post.createdAtReadable,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.access_time,
                                    size: 12,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '5 min read', // Default read time since it's not in the model
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Tags
                    if (post.sector != null)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _getTagColor(
                                post.sector!.name ?? 'General',
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              post.sector!.name ?? 'General',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),

                    // Article Image
                    if (post.cover.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: post.cover,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Article Content
                    Text(
                      post.content,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Comments Section
                    const Divider(),

                    const SizedBox(height: 32),
                  ],
                ),
              );
            } else if (state.runtimeType.toString().contains('Error')) {
              final errorState = state as dynamic;
              return _buildErrorState(
                errorState.message ?? 'Failed to load article',
                () {
                  context.read<PostCubit>().fetchSinglePost(slug: slug);
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

  Widget _buildLoadingSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title skeleton
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),

            // Author info skeleton
            Row(
              children: [
                CircleAvatar(radius: 20, backgroundColor: Colors.grey[300]),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 16,
                        color: Colors.grey[300],
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 180,
                        height: 12,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tags skeleton
            Row(
              children: [
                Container(
                  width: 80,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 100,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Image skeleton
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 20),

            // Content skeleton
            ...List.generate(
              8,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  width: double.infinity,
                  height: 16,
                  color: Colors.grey[300],
                ),
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
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'environment':
        return Colors.green;
      case 'youth action':
        return Colors.blue;
      case 'community':
        return Colors.orange;
      case 'sustainability':
        return Colors.teal;
      default:
        return Colors.purple;
    }
  }
}
