import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
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
            selectedLabelStyle: MyFonts.font12Black.copyWith(
              color: Colors.red,
            ),
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
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedHome06,
                  color: cubit.currentIndex == 0
                      ? MyColors.primaryColor
                      : Colors.black,
                ),
                label: AppLocalizations.of(context)!.home,
              ),
              BottomNavigationBarItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedAppointment01,
                    color: cubit.currentIndex == 1
                      ? MyColors.primaryColor
                      : Colors.black,
                ),
                label: AppLocalizations.of(context)!.organizations,
              ),
              BottomNavigationBarItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedQuestion,
                       color: cubit.currentIndex == 2
                      ? MyColors.primaryColor
                      : Colors.black,
                ),
                label: AppLocalizations.of(context)!.opportunities,
              ),
              BottomNavigationBarItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedLicense,
                      color: cubit.currentIndex == 3
                      ? MyColors.primaryColor
                      : Colors.black,
                ),
                label: AppLocalizations.of(context)!.blog,
              ),
              BottomNavigationBarItem(
                icon: HugeIcon(
                  icon: HugeIcons.strokeRoundedUser,
                    color: cubit.currentIndex == 4
                      ? MyColors.primaryColor
                      : Colors.black,
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
