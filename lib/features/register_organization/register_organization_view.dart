import 'dart:developer';

import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/landing/landing.dart';

import '../../core/theme/my_colors.dart';
import '../../core/widgets/back_button.dart';
import '../../core/widgets/toast_message.dart';
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return lang.fullNameRequired;
                  }
                  if (value.trim().length < 3) {
                    return lang.fullNameMinLength;
                  }
                  if (value.trim().length > 50) {
                    return lang.fullNameMaxLength;
                  }
                  if (!RegExp(
                    r'^[a-zA-Z\s\u0600-\u06FF]+$',
                  ).hasMatch(value.trim())) {
                    return lang.nameOnlyContainsLetters;
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return lang.emailRequired;
                  }
                  // Email format validation
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value.trim())) {
                    return lang.invalidEmail;
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return lang.password_required;
                  }
                  if (value.length < 8) {
                    return lang.password_min_length;
                  }
                  if (value.length > 128) {
                    return lang.password_max_length;
                  }
                  // Check for at least one uppercase letter
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return lang.password_uppercase;
                  }
                  // Check for at least one lowercase letter
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return lang.password_lowercase;
                  }
                  // Check for at least one digit
                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return lang.password_number;
                  }
                  // Check for at least one special character
                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    return lang.password_special_char;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Checkbox(
                    value: agreedToTerms.value,
                    onChanged: (val) => agreedToTerms.value = val ?? false,
                    activeColor: MyColors.primaryColor,
                  ),
                  Expanded(
                    child: Wrap(
                      children: [
                        Text(lang.iAgreeToThe),
                        GestureDetector(
                          onTap: () {
                            // TODO: Navigate to Terms of Service
                          },
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
                          onTap: () {
                            // TODO: Navigate to Privacy Policy
                          },
                          child: Text(
                            lang.privacyPolicy,
                            style: TextStyle(
                              color: MyColors.primaryColor,
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

                          if (formKey.currentState?.validate() != true) {
                      // Show error toast for form validation

                      return;
                    }

                    // Check terms agreement
                    if (!agreedToTerms.value) {
                      ToastMessage.showWarning(
                        context,
                        title: lang.terms_required,
                        message: lang.plase_agree_to_terms,
                      );
                      return;
                    }
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
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Landing()), (route) => false);
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
