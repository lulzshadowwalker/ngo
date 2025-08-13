import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../export_tools.dart';
import '../../blog/blog_export.dart';
import '../../home/home_export.dart';
import '../../opportunities/opportunities_export.dart';
import '../../organization/organization_view_export.dart';
import '../../profile/profile_view.dart'; // Direct import instead of export
import 'main_nav_state.dart';

class MainNavCubit extends Cubit<MainNavState> {
  MainNavCubit() : super(MainNavInitial());

  List<Widget> pages = [
    const Home(),
    const OrganizationView(),
    const OpportunitiesView(),
    const BlogView(),
    const ProfileView(), // Re-enable ProfileView
  ];

  int currentIndex = 0;
  void changeIndex(int index) {
    if (index != currentIndex) {
      currentIndex = index;
      emit(MainNavIndexChanged(currentIndex));

      // Call fetchUserData when the index changes
    }
  }
}
