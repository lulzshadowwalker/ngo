import '../../../core/constant/app_assets.dart';
import '../../../export_tools.dart';
import 'login_export.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return Scaffold(
      body: ListView(
        children: [
          LogoApp(logoApp: AppAssets.logo2, height: 320),
          const SizedBox(height: 40),

          LoginFromSection(),
          const SizedBox(height: 20),

          DontHaveAcountSection(lang: lang),

          // LoginScreenButtonSection(lang: lang),
          // const SizedBox(height: 15),
        ],
      ),
    );
  }
}
