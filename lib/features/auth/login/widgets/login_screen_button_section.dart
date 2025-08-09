import 'package:ngo/export_tools.dart';
import 'package:ngo/features/join_our_community/join_our_community.dart';

import '../../../../core/core_export.dart';

class LoginScreenButtonSection extends StatelessWidget {
  const LoginScreenButtonSection({super.key, required this.lang});

  final AppLocalizations lang;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomElevatedButtonComponent(
        buttonTextStyle: MyFonts.font14BlackBold.copyWith(color: Colors.white),
        buttonColor: MyColors.primaryColor,
        borderColor: MyColors.primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JionOurCommunity()),
          );
        },
        title: lang.login,
      ),
    );
  }
}
