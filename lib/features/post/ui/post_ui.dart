import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:ngo/features/post/data/model/post.dart';
import 'package:ngo/features/post/data/repo/posts_repository.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/post/logic/post_cubit.dart';
import 'package:ngo/features/post/logic/post_state.dart';
import 'package:ngo/service_locator.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PostUi extends HookWidget {
  const PostUi({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) =>
          PostCubit(postsRepository: sl<PostsRepository>())
            ..fetchAllPost(language: lang.localeName),
      child: Scaffold(
        body: BlocBuilder<PostCubit, PostState>(
          buildWhen: (previous, current) =>
              current is Loading || current is Loaded || current is Error,
          builder: (context, state) {
            switch (state) {
              case Loading():
                return Skeletonizer(
                  enabled: true,
                  child: ListView.builder(
                    itemCount: 5, // Optional: use a placeholder count
                    itemBuilder: (context, index) {
                      return AnimatedPostTile(
                        post: Post(
                          id: 'post_12345',
                          title: 'Winter Supplies Distributed to 100 Families',
                          slug: 'winter-supplies-amman',
                          content:
                              'Today we distributed winter supplies including blankets and food parcels to 100 families in Amman. Thank you to all volunteers who made this possible!',
                          cover:
                              'https://images.unsplash.com/photo-1605733160314-4c0b5560e80e?auto=format&fit=crop&w=800&q=60',
                          organization: null,
                          createdAt: DateTime.now().subtract(
                            const Duration(hours: 2),
                          ),
                          createdAtReadable: '2 hours ago',
                          updatedAt: DateTime.now(),
                        ),
                        index: 0,
                      ); // Create a loading variant if needed
                    },
                  ),
                );

              case Loaded():
                final loadedState = state;
                return Skeletonizer(
                  enabled: false, // Now skeleton is disabled
                  child: ListView.builder(
                    itemCount: loadedState.posts.length,
                    itemBuilder: (context, index) {
                      final post = loadedState.posts[index];
                      return AnimatedPostTile(post: post, index: index);
                    },
                  ),
                );

              case Error():
                return Center(
                  child: Text(state.message, style: MyFonts.font12Black),
                );

              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            HeaderPostCardSection(post: post),
            const SizedBox(height: 12),

            // Content
            ContentPostCardSection(post: post),
            const SizedBox(height: 12),

            // Cover Image
            CoverImagePostCardSection(post: post),
            const SizedBox(height: 12),

            // Interaction Row
            InteractionRowPostCardSection(),
          ],
        ),
      ),
    );
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Colors.grey[200],
          child: Icon(Icons.home_work, size: 18, color: Colors.grey[700]),
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
