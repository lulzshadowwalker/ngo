import 'dart:developer';

import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/export_tools.dart';

import '../../core/widgets/back_button.dart';
import 'compelete_register_organization.dart';

class RegisterOrganizationView extends HookWidget {
  const RegisterOrganizationView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);
    final agreedToTerms = useState(false);
    var lang = AppLocalizations.of(context)!;
    Widget buildLabel(String label) => Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const Text('  *', style: TextStyle(color: Colors.red, fontSize: 16)),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: BackButtonWidgets(lang: lang),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                lang.joinTheCommunity,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              buildLabel(lang.fullName),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: lang.enterFullName,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              buildLabel(lang.emailAddress),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: lang.enterEmailAddress,
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              buildLabel(lang.password),
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword.value,
                decoration: InputDecoration(
                  hintText: lang.enterPassword,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscurePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () =>
                        obscurePassword.value = !obscurePassword.value,
                  ),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: agreedToTerms.value,
                    onChanged: (val) => agreedToTerms.value = val ?? false,
                  ),
                  Expanded(
                    child: Wrap(
                      children: [
                        Text(lang.iAgreeToThe),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            lang.termsOfService,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(lang.andA),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            lang.privacyPolicy,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    log("This Email is: ${emailController.text}");
                    log("This Password is: ${passwordController.text}");
                    log("This Name is: ${nameController.text}");
                    if (formKey.currentState?.validate() == true &&
                        agreedToTerms.value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CompeleteRegisterOrganization(
                            fullName: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    lang.create_account,
                    style: MyFonts.font16Black.copyWith(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(lang.alreadyHaveAnAccount),
                  GestureDetector(
                    onTap: () {
                      // Handle sign in navigation
                    },
                    child: Text(
                      lang.signIn,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
