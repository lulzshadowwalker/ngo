import 'package:flutter_hooks/flutter_hooks.dart';

import '../../export_tools.dart';
import '../notifications/notifications_home_export.dart';
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
                  tabs: const [
                    Tab(text: 'Following'),
                    Tab(text: 'Recently'),
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
          SliverList(
            delegate: SliverChildListDelegate([
          PostUi(),
          PostUi(),
          PostUi(),
            ]),
          ),
        ],
      ),
    );
  }
}






class PostUi extends StatelessWidget {
  const PostUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: GestureDetector(
        onTap: () {
          print("Post tapped");
          // Handle post tap
        },
        child: Container(
          decoration: BoxDecoration(
            
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha:  0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
         
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/men/32.jpg',
                  ),
                ),
                title: const Text(
                  'UNRWA Jordan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('2 hours ago'),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // Handle more options
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  'Today we distributed winter supplies to 100 families in Amman. Thank you to all our volunteers who made this possible!',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite_border, color: Colors.grey),
                      onPressed: () {
                        // Handle like action
                      },
                    ),
                    const Text('245'),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline, color: Colors.grey),
                      onPressed: () {
                        // Handle comment action
                      },
                    ),
                    const Text('18'),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.grey),
                      onPressed: () {
                        // Handle share action
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
