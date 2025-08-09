
import '../../export_tools.dart';
import '../notifications/notifications_home_export.dart';
import '../post/ui/post_ui.dart';
import '../search_home/search_home_export.dart';

class Home extends HookWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);

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
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.black),
                onPressed: () {
                  // Handle search action
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchHome()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {
                  // Handle notifications action
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationsHome()));
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
                  // padding: const EdgeInsets.symmetric(horizontal: 50),
                  tabAlignment: TabAlignment.center,
                  controller: tabController,
                  indicatorColor: Colors.green,
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.green, width: 1.0),
                    ),
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  tabs:  [
                    Tab(text: AppLocalizations.of(context)!.following_ng),
                            Tab(text: AppLocalizations.of(context)!.recentlyNg),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/women/44.jpg',
                    ),
                  ),
                  title: const Text('Complete Your Profile'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 0.33,
                              color: Colors.green,
                              backgroundColor: Colors.grey[200],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Step 1 of 3',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Option 1: Simple approach - PostUi in SliverToBoxAdapter
          SliverToBoxAdapter(
            child: PostUi(),
          ),

          // Option 2: Alternative approach for better performance with individual slivers
          // Uncomment below and comment above if you want posts as individual slivers
          /*
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return BlocProvider(
                  create: (context) => sl<PostCubit>()..fetchAllPost(language: 'en'),
                  child: BlocBuilder<PostCubit, PostState>(
                    builder: (context, state) {
                      if (state is Loaded && index < state.posts.length) {
                        return AnimatedPostTile(
                          post: state.posts[index], 
                          index: index
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                );
              },
              childCount: 10, // Set expected maximum posts
            ),
          ),
          */
    
        ],
      ),
    );
  }
}
