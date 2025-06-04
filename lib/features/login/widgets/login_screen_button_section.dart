import 'package:ngo/export_tools.dart';
import '../../../core/core_export.dart';

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
        onPressed: () {},
        title: lang.login,
      ),
    );
  }
}
