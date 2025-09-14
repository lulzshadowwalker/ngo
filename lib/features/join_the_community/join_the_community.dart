import 'dart:developer';

import 'package:hugeicons/hugeicons.dart';

import '../../core/core_export.dart';
import '../../core/widgets/toast_message.dart';
import '../../export_tools.dart';
import '../complete_your_profile/complete_your_profile_export.dart';

class JoinTheCommunity extends HookWidget {
  const JoinTheCommunity({super.key});

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
        leading: IconButton(
          icon: HugeIcon(
            icon: lang.localeName == "ar"
                ? HugeIcons.strokeRoundedArrowRight01
                : HugeIcons.strokeRoundedArrowLeft01,
            color: MyColors.primaryColor,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              buildLabel(lang.fullName),
              TextFormField(
                controller: nameController,
                decoration:  InputDecoration(
                  hintText: lang.enterFullName,
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${lang.fullName} is required';
                  }
                  if (value.trim().length < 2) {
                    return 'Name must be at least 2 characters';
                  }
                  if (value.trim().length > 50) {
                    return 'Name must not exceed 50 characters';
                  }
                  if (!RegExp(r'^[a-zA-Z\s\u0600-\u06FF]+$').hasMatch(value.trim())) {
                    return 'Name can only contain letters and spaces';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              buildLabel(lang.emailAddress),
              TextFormField(
                controller: emailController,
                decoration:  InputDecoration(
                  hintText: lang.enterEmailAddress,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${lang.emailAddress} is required';
                  }
                  // Email format validation
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                    return 'Please enter a valid email address';
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
                    return '${lang.password} is required';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  if (value.length > 128) {
                    return 'Password must not exceed 128 characters';
                  }
                  // Check for at least one uppercase letter
                  if (!RegExp(r'[A-Z]').hasMatch(value)) {
                    return 'Password must contain at least one uppercase letter';
                  }
                  // Check for at least one lowercase letter
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return 'Password must contain at least one lowercase letter';
                  }
                  // Check for at least one digit
                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Password must contain at least one number';
                  }
                  // Check for at least one special character
                  if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                    return 'Password must contain at least one special character';
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
                    activeColor: Colors.green[700],
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
                    
                    // Validate form first
                    if (formKey.currentState?.validate() != true) {
                      // Show error toast for form validation
                   
                      return;
                    }
                    
                    // Check terms agreement
                    if (!agreedToTerms.value) {
                      ToastMessage.showWarning(
                        context,
                        title: 'Terms Required',
                        message: 'Please agree to the Terms of Service and Privacy Policy',
                      );
                      return;
                    }
                    
                    
                    
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CompleteYourProfile(
                      fullName: nameController.text.trim(),
                      email: emailController.text.trim().toLowerCase(),
                      password: passwordController.text,
                    )));
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
                      style: TextStyle(
                        color: Colors.green[700],
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
