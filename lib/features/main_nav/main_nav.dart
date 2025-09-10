import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngo/core/constant/app_assets.dart';
import 'package:ngo/features/main_nav/cubit/main_nav_cubit.dart';
import 'package:ngo/features/main_nav/cubit/main_nav_state.dart';

import '../../core/core_export.dart';
import '../../export_tools.dart';

class MainNav extends HookWidget {
  const MainNav({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MainNavCubit>();

    return BlocConsumer<MainNavCubit, MainNavState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: cubit.pages[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: MyColors.primaryColor,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: MyFonts.font12Black.copyWith(color: Colors.red),
            unselectedLabelStyle: MyFonts.font11Black.copyWith(
              color: Colors.black,
            ),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  cubit.currentIndex == 0 ? AppIcons.homeFill : AppIcons.home,
                ),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  cubit.currentIndex == 1
                      ? AppIcons.organizationsFill
                      : AppIcons.organizations,
                ),
                label: AppLocalizations.of(context)!.organizations,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  cubit.currentIndex == 2
                      ? AppIcons.opportunitiesFill
                      : AppIcons.opportunities,
                ),
                label: AppLocalizations.of(context)!.opportunities,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  cubit.currentIndex == 3 ? AppIcons.blogFill : AppIcons.blog,
                ),
                label: AppLocalizations.of(context)!.blog,
              ),

              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  cubit.currentIndex == 4
                      ? AppIcons.profileFill
                      : AppIcons.profile,
                ),
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
          ),
        );
      },
    );
  }
}
