import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/core/theme/my_fonts.dart';
import 'package:ngo/features/components/text_component.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../components/text_from_field.dart';
import '../../cubit/auth_cubit.dart';

class ForgotPasswordSection extends StatelessWidget {
  const ForgotPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AppLocalizations.of(context)!.localeName == "en" ?  Alignment.centerLeft : Alignment.centerRight,
      child: TextButton(
        onPressed: () => _showForgotPasswordDialog(context),
        child: TextComponent(
          title: AppLocalizations.of(context)!.forgot_fassword,
          style: MyFonts.font14BlackBold.copyWith(
            color: MyColors.primaryColor,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<AuthCubit>(),
        child: const ForgotPasswordDialog(),
      ),
    );
  }
}

class ForgotPasswordDialog extends HookWidget {
  const ForgotPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        final stateType = state.runtimeType.toString();
        if (stateType.contains('ForgotPasswordSuccess')) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('If this email is registered, you will receive a password reset link shortly.'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (stateType.contains('ForgotPasswordError')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to send reset email. Please try again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.forgot_fassword,
                  style: MyFonts.font18BlackBold,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Enter your email address to receive a password reset link.',
                  style: MyFonts.font14Black.copyWith(color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                AppTextFormField(
                  controller: emailController,
                  hintText: AppLocalizations.of(context)!.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final stateType = state.runtimeType.toString();
                    final isLoading = stateType.contains('ForgotPasswordLoading');
                    return Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: isLoading ? null : () => Navigator.of(context).pop(),
                            child: Text(
                              'Cancel',
                              style: MyFonts.font14BlackBold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isLoading ? null : () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthCubit>().forgotPassword(
                                  email: emailController.text.trim(),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
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
                                    'Send',
                                    style: MyFonts.font14BlackBold.copyWith(color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
