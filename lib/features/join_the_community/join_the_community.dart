import 'package:hugeicons/hugeicons.dart';

import '../../core/core_export.dart';
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
              const Text(
                'Join the Community',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              buildLabel('Full Name'),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your full name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              buildLabel('Email Address'),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),
              buildLabel('Password'),
              TextFormField(
                controller: passwordController,
                obscureText: obscurePassword.value,
                decoration: InputDecoration(
                  hintText: 'Create a password',
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
                        const Text('I agree to the '),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Terms of Service',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Text(' and '),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Privacy Policy',
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
                    if (formKey.currentState?.validate() == true &&
                        agreedToTerms.value) {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> CompleteYourProfile()));
                    }
                  },
                  child: Text(
                    'Create Account',
                    style: MyFonts.font16Black.copyWith(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  GestureDetector(
                    onTap: () {
                      // Handle sign in navigation
                    },
                    child: Text(
                      'Sign In',
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
