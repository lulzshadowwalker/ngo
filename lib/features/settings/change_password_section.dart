import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/features/auth/login/login_export.dart';

import '../../core/theme/my_fonts.dart';
import '../../export_tools.dart';
import '../../service_locator.dart';
import '../auth/cubit/auth_cubit.dart';

class ChangePasswordSection extends HookWidget {
  const ChangePasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the existing AuthCubit from the parent context instead of creating a new one
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: const _ChangePasswordView(),
    );
  }
}

class _ChangePasswordView extends HookWidget {
  const _ChangePasswordView();

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final oldPasswordController = useTextEditingController();
    final newPasswordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final showOldPassword = useState(false);
    final showNewPassword = useState(false);
    final showConfirmPassword = useState(false);
    final isLoading = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                'Update Your Password',
                style: MyFonts.font20BlackBold.copyWith(
                  color: Colors.green[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please enter your current password and choose a new secure password.',
                style: MyFonts.font14Black.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(height: 32),

              // Old Password Field
              Text(
                'Current Password',
                style: MyFonts.font16Black.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: oldPasswordController,
                obscureText: !showOldPassword.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your current password',
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showOldPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      showOldPassword.value = !showOldPassword.value;
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.green[700]!, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // New Password Field
              Text(
                'New Password',
                style: MyFonts.font16Black.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: newPasswordController,
                obscureText: !showNewPassword.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters long';
                  }
                  if (value == oldPasswordController.text) {
                    return 'New password must be different from current password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter your new password',
                  prefixIcon: const Icon(Icons.lock, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showNewPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      showNewPassword.value = !showNewPassword.value;
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.green[700]!, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Confirm Password Field
              Text(
                'Confirm New Password',
                style: MyFonts.font16Black.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: !showConfirmPassword.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Confirm your new password',
                  prefixIcon: const Icon(Icons.lock_clock, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showConfirmPassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      showConfirmPassword.value = !showConfirmPassword.value;
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.green[700]!, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [ForgotPasswordSection()],
              ),
              const SizedBox(height: 16),
              // Password Requirements
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password Requirements:',
                      style: MyFonts.font14Black.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildRequirement('At least 8 characters long'),
                    _buildRequirement('Different from current password'),
                    _buildRequirement('Must match confirmation password'),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Update Password Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        final stateType = state.runtimeType.toString();
                        if (stateType.contains('PasswordChangeSuccess')) {
                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                'Password updated successfully!',
                              ),
                              backgroundColor: Colors.green[700],
                              behavior: SnackBarBehavior.floating,
                            ),
                          );

                          // Clear form
                          oldPasswordController.clear();
                          newPasswordController.clear();
                          confirmPasswordController.clear();

                          // Navigate back
                          Navigator.pop(context);
                        } else if (stateType.contains('PasswordChangeError')) {
                          isLoading.value = false;
                          final errorState = state as dynamic;
                          final message = errorState.message as String;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final stateType = state.runtimeType.toString();
                        final isAuthLoading = stateType.contains(
                          'PasswordChangeLoading',
                        );

                        return SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: (isLoading.value || isAuthLoading)
                                ? null
                                : () async {
                                    if (formKey.currentState!.validate()) {
                                      isLoading.value = true;

                                      try {
                                        // Call AuthCubit to change password
                                        await context
                                            .read<AuthCubit>()
                                            .changePassword(
                                              currentPassword:
                                                  oldPasswordController.text,
                                              newPassword:
                                                  newPasswordController.text,
                                              confirmPassword:
                                                  confirmPasswordController
                                                      .text,
                                            );
                                      } catch (error) {
                                        // Error handling is done in BlocListener
                                        // This catch block is for any unexpected errors
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'An unexpected error occurred: ${error.toString()}',
                                            ),
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                          ),
                                        );
                                        isLoading.value = false;
                                      }
                                    }
                                  },
                            child: (isLoading.value || isAuthLoading)
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Update Password',
                                    style: MyFonts.font16Black.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: Colors.grey[300]!),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: MyFonts.font16Black.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequirement(String requirement) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(Icons.check_circle_outline, size: 16, color: Colors.green[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              requirement,
              style: MyFonts.font12Black.copyWith(color: Colors.green[700]),
            ),
          ),
        ],
      ),
    );
  }
}
