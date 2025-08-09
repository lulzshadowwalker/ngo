import 'package:ngo/core/core_export.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/auth/cubit/auth_cubit.dart';
import 'package:ngo/service_locator.dart';

import '../components/text_component.dart';
import '../landing/landing.dart';
import '../main_nav/main_nav.dart';

class Splash extends HookWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 1), () async {
        final authCubit = sl<AuthCubit>();
        await authCubit.restoreAuthState();
        final state = authCubit.state;
        final stateType = state.runtimeType.toString();
        
        // Check if the widget is still mounted before using context
        if (!context.mounted) return;
        
        if (stateType.contains('Authenticated')) {
          // User is authenticated, navigate to MainNav
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainNav()),
            (route) => false,
          );
        } else {
          // User is not authenticated, navigate to Landing
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Landing()),
            (route) => false,
          );
        }
      });

      return null;
    }, const []);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 60),
        children: [
          const SizedBox(height: 40),
          LogoApp(),
          const SizedBox(height: 20),
          TextComponent(
            title: AppLocalizations.of(context)!.app_name,
            style: MyFonts.font28BlackBold.copyWith(
              color: MyColors.primaryColor,
            ),
          ),
          const SizedBox(height: 30),
          TextComponent(
            title: AppLocalizations.of(context)!.connect_evaluate_volunteer,
            style: MyFonts.font22BlackBold,
          ),
          const SizedBox(height: 10),
          TextComponent(
            title: AppLocalizations.of(context)!.join_us,
            style: MyFonts.font16Black,
          ),
        ],
      ),
    );
  }
}
