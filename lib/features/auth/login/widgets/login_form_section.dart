import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/components/text_component.dart';
import 'package:ngo/features/components/text_from_field.dart';
import 'package:ngo/features/main_nav/main_nav_export.dart';
import 'package:ngo/service_locator.dart';

import '../../../../core/widgets/toast_message.dart';
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
          log("State: $stateType");
          if (stateType.contains('Authenticated')) {
            ToastMessage.showSuccess(
              context,

              message: AppLocalizations.of(context)!.login_successful,
            );

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainNav()),
              (route) => false,
            );
          } else if (stateType.contains('LoginError')) {
            ToastMessage.showError(
              context,
              message: AppLocalizations.of(context)!.login_failed,
            );
          } else if (stateType.contains('RegisterError')) {
            ToastMessage.showError(
              context,
              message: AppLocalizations.of(context)!.registration_failed,
            );
          } else if (stateType.contains('LogoutError')) {
            ToastMessage.showError(
              context,
              message: AppLocalizations.of(context)!.logout_failed,
            );
          } else if (stateType.contains('Error')) {
            ToastMessage.showError(
              context,
              message: AppLocalizations.of(context)!.error_occurred,
            );
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
                  TextComponent(
                    title: AppLocalizations.of(context)!.email,
                    style: MyFonts.font14BlackBold,
                  ),
                  const SizedBox(height: 10),
                  AppTextFormField(
                    controller: emailController,
                    prefixIcon: const HugeIcon(
                      icon: HugeIcons.strokeRoundedMail01,
                      size: 20,
                      color: MyColors.darkGrayColor,
                    ),
                    hintText: AppLocalizations.of(context)!.enter_your_email,
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
                    title: AppLocalizations.of(context)!.password,
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
                    hintText: AppLocalizations.of(context)!.enter_your_password,
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
                          : Text(
                              AppLocalizations.of(context)!.login,
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
