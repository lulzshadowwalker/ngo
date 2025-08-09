import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:ngo/features/components/text_from_field.dart';
import 'package:ngo/features/main_nav/main_nav_export.dart';
import 'package:ngo/service_locator.dart';

import '../../cubit/auth_cubit.dart';
import 'forgot_password_section.dart';

class LoginFromSection extends HookWidget {
  const LoginFromSection({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPasswordVisible = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          final stateType = state.runtimeType.toString();
          if (stateType.contains('Authenticated')) {
            CustomSnackBar.showSuccess(context, message: 'Login successful!');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainNav()),
              (route) => false,
            );
          } else if (stateType.contains('LoginError')) {
            CustomSnackBar.showError(context, message: 'Login failed');
          } else if (stateType.contains('RegisterError')) {
            CustomSnackBar.showError(context, message: 'Registration failed');
          } else if (stateType.contains('LogoutError')) {
            CustomSnackBar.showError(context, message: 'Logout failed');
          } else if (stateType.contains('Error')) {
            CustomSnackBar.showWarning(context, message: 'An error occurred');
          }
        },
        builder: (context, state) {
          final stateType = state.runtimeType.toString();
          final isLoading =
              stateType.contains('Loading') ||
              stateType.contains('LoggingIn') ||
              stateType.contains('Registering') ||
              stateType.contains('LoggingOut');

          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent(title: "Email", style: MyFonts.font14BlackBold),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    controller: emailController,
                    prefixIcon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedMail01,
                      size: 20,
                      color: MyColors.darkGrayColor,
                    ),
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextComponent(
                    title: "Password",
                    style: MyFonts.font14BlackBold,
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    controller: passwordController,
                    prefixIcon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedLockPassword,
                      size: 20,
                      color: MyColors.darkGrayColor,
                    ),
                    hintText: "Enter your password",
                    obscureText: !isPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                      icon: HugeIcon(
                        icon: isPasswordVisible.value
                            ? HugeIcons.strokeRoundedView
                            : HugeIcons.strokeRoundedViewOffSlash,
                        size: 20,
                        color: MyColors.darkGrayColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ForgotPasswordSection(),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthCubit>().login(
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
