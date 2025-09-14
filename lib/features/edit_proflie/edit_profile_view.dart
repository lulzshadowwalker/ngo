import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/theme/my_colors.dart';
import '../../export_tools.dart';
import '../../models/user.dart';
import '../../service_locator.dart';
import '../user_management/cubit/user_management_cubit.dart';

class EditProfileView extends HookWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserManagementCubit>()..fetchCurrentUser(),
      child: const _EditProfileContent(),
    );
  }
}

class _EditProfileContent extends HookWidget {
  const _EditProfileContent();

  @override
  Widget build(BuildContext context) {
    // Initialize all hooks at the top level of build method
    final fullNameController = useTextEditingController();
    final bioController = useTextEditingController();
    final emailController = useTextEditingController();

    final selectedSkills = useState<Set<String>>({
      AppLocalizations.of(context)!.leadership,
      AppLocalizations.of(context)!.communication,
      AppLocalizations.of(context)!.project_management,
    });

    final selectedInterests = useState<Set<String>>({
      AppLocalizations.of(context)!.education,
      AppLocalizations.of(context)!.environment,
    });

    final selectedImage = useState<File?>(null);

    return BlocConsumer<UserManagementCubit, UserManagementState>(
      listener: (context, state) {
        // Handle error states
        if (state.runtimeType.toString().contains('Error')) {
          try {
            final dynamic errorState = state;
            final message = errorState.message ?? AppLocalizations.of(context)!.unknown_error;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('${AppLocalizations.of(context)!.error_occurred}: $message')));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppLocalizations.of(context)!.error_loading_profile_data)),
            );
          }
        }
      },
      builder: (context, state) {
        final stateType = state.runtimeType.toString();

        // Handle loading and initial states
        if (stateType.contains('Loading') || stateType.contains('Initial')) {
          return _buildLoadingScaffold(context);
        }

        // Handle error state
        if (stateType.contains('Error')) {
          return _buildErrorScaffold(context);
        }

        // Handle loaded state - extract user data
        User? user;
        if (stateType.contains('Loaded')) {
          try {
            final dynamic loadedState = state;
            user = loadedState.user;

            // Update controllers with user data when loaded
            if (user != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                fullNameController.text = user?.name ?? '';
                bioController.text = user?.bio ?? '';
                emailController.text = user?.email ?? '';
                // Note: User model may not have phone field, checking if it exists
              });
            }
          } catch (e) {
            debugPrint('Error extracting user from loaded state: $e');
          }
        }

        return _buildMainScaffoldWithUserData(
          context,
          user,
          fullNameController,
          bioController,
          emailController,
          selectedSkills,
          selectedInterests,
          selectedImage,
        );
      },
    );
  }

  Widget _buildMainScaffoldWithUserData(
    BuildContext context,
    User? user,
    TextEditingController fullNameController,
    TextEditingController bioController,
    TextEditingController emailController,
    ValueNotifier<Set<String>> selectedSkills,
    ValueNotifier<Set<String>> selectedInterests,
    ValueNotifier<File?> selectedImage,
  ) {
    final skills = [
      AppLocalizations.of(context)!.leadership,
      AppLocalizations.of(context)!.communication,
      AppLocalizations.of(context)!.project_management,
      AppLocalizations.of(context)!.public_speaking,
      AppLocalizations.of(context)!.social_media,
      AppLocalizations.of(context)!.event_planning,
    ];

    final interests = [
      AppLocalizations.of(context)!.education,
      AppLocalizations.of(context)!.environment,
      AppLocalizations.of(context)!.healthcare,
      AppLocalizations.of(context)!.social_justice,
      AppLocalizations.of(context)!.youth_development,
      AppLocalizations.of(context)!.arts_culture,
    ];

    return _buildMainScaffold(
      context,
      user: user,
      fullNameController: fullNameController,
      bioController: bioController,
      emailController: emailController,
      selectedSkills: selectedSkills,
      selectedInterests: selectedInterests,
      selectedImage: selectedImage,
      skills: skills,
      interests: interests,
    );
  }

  Widget _buildErrorScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit_profile),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.error_loading_profile_data),
            ElevatedButton(
              onPressed: () =>
                  context.read<UserManagementCubit>().fetchCurrentUser(),
              child: Text(AppLocalizations.of(context)!.retry),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.edit_profile,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildMainScaffold(
    BuildContext context, {
    User? user,
    required TextEditingController fullNameController,
    required TextEditingController bioController,
    required TextEditingController emailController,
    required ValueNotifier<Set<String>> selectedSkills,
    required ValueNotifier<Set<String>> selectedInterests,
    required ValueNotifier<File?> selectedImage,
    required List<String> skills,
    required List<String> interests,
  }) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.edit_profile,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          // Profile Photo Section
          SliverToBoxAdapter(
            child: _buildProfilePhotoSection(context, user, selectedImage),
          ),

          // Form Fields
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Name Field
                  _buildTextField(
                    context: context,
                    label: AppLocalizations.of(context)!.full_name,
                    controller: fullNameController,
                  ),
                  const SizedBox(height: 24),

                  // Bio Field
                  _buildTextField(
                    context: context,
                    label: AppLocalizations.of(context)!.bio,
                    controller: bioController,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),

                  // Skills Section
                  _buildChipSection(
                    title: AppLocalizations.of(context)!.skills,
                    items: skills,
                    selectedItems: selectedSkills.value,
                    onSelectionChanged: (item) {
                      final newSelection = Set<String>.from(
                        selectedSkills.value,
                      );
                      if (newSelection.contains(item)) {
                        newSelection.remove(item);
                      } else {
                        newSelection.add(item);
                      }
                      selectedSkills.value = newSelection;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Interests Section
                  _buildChipSection(
                    title: AppLocalizations.of(context)!.interests,
                    items: interests,
                    selectedItems: selectedInterests.value,
                    onSelectionChanged: (item) {
                      final newSelection = Set<String>.from(
                        selectedInterests.value,
                      );
                      if (newSelection.contains(item)) {
                        newSelection.remove(item);
                      } else {
                        newSelection.add(item);
                      }
                      selectedInterests.value = newSelection;
                    },
                  ),
                  const SizedBox(height: 24),

                  // Email Field
                  _buildTextField(
                    context: context,
                    label: AppLocalizations.of(context)!.email,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 32),

                  // Save Changes Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle save changes - need to pass user data
                        if (user != null) {
                          _saveChanges(
                            context,
                            user,
                            fullNameController,
                            bioController,
                            emailController,
                            selectedSkills,
                            selectedInterests,
                            selectedImage,
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
                      child: Text(
                        AppLocalizations.of(context)!.save_changes,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePhotoSection(
    BuildContext context,
    User? user,
    ValueNotifier<File?> selectedImage,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Profile Picture
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: MyColors.primaryColor, width: 3),
                ),
                child: ClipOval(
                  child: selectedImage.value != null
                      ? Image.file(
                          selectedImage.value!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : user?.avatar != null && user!.avatar!.isNotEmpty
                      ? Image.network(
                          user.avatar!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _showImageSourceDialog(context, selectedImage),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Change Photo Text
          GestureDetector(
            onTap: () => _showImageSourceDialog(context, selectedImage),
            child: Text(
              AppLocalizations.of(context)!.change_photo,
              style: const TextStyle(
                fontSize: 14,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? errorText,
    void Function(String)? onChanged,
  }) {
    // Create proper placeholder based on label
    String hintText;
    if (label == AppLocalizations.of(context)!.full_name) {
      hintText = AppLocalizations.of(context)!.enter_full_name;
    } else if (label == AppLocalizations.of(context)!.bio) {
      hintText = AppLocalizations.of(context)!.enter_bio;
    } else if (label == AppLocalizations.of(context)!.email) {
      hintText = AppLocalizations.of(context)!.enter_email;
    } else {
      hintText = 'Enter $label';
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.grey[300]!,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.grey[300]!,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : MyColors.primaryColor,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText,
            style: const TextStyle(fontSize: 12, color: Colors.red),
          ),
        ],
      ],
    );
  }

  Widget _buildChipSection({
    required String title,
    required List<String> items,
    required Set<String> selectedItems,
    required Function(String) onSelectionChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            final isSelected = selectedItems.contains(item);
            return GestureDetector(
              onTap: () => onSelectionChanged(item),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? MyColors.primaryColor : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _saveChanges(
    BuildContext context,
    User user,
    TextEditingController fullNameController,
    TextEditingController bioController,
    TextEditingController emailController,
    ValueNotifier<Set<String>> selectedSkills,
    ValueNotifier<Set<String>> selectedInterests,
    ValueNotifier<File?> selectedImage,
  ) {
    // Call the API to update profile
    context.read<UserManagementCubit>().updateProfile(
      name: fullNameController.text.trim().isEmpty
          ? null
          : fullNameController.text.trim(),
      email: emailController.text.trim().isEmpty
          ? null
          : emailController.text.trim(),
      bio: bioController.text.trim().isEmpty ? null : bioController.text.trim(),
      // TODO: Add other fields like birthdate, website, etc. when UI fields are added
      // For now, we're only updating the basic fields that are in the current UI
      avatarFile: selectedImage.value,
    );
  }

  void _showImageSourceDialog(
    BuildContext context,
    ValueNotifier<File?> selectedImage,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(AppLocalizations.of(context)!.camera),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera(context, selectedImage);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(AppLocalizations.of(context)!.gallery),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery(context, selectedImage);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: Text(AppLocalizations.of(context)!.cancel),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImageFromCamera(
    BuildContext context,
    ValueNotifier<File?> selectedImage,
  ) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        selectedImage.value = File(image.path);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.image_selected_from_camera),
            backgroundColor: MyColors.primaryColor,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppLocalizations.of(context)!.error_accessing_camera}: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _pickImageFromGallery(
    BuildContext context,
    ValueNotifier<File?> selectedImage,
  ) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        selectedImage.value = File(image.path);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.image_selected_from_gallery),
            backgroundColor: MyColors.primaryColor,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${AppLocalizations.of(context)!.error_accessing_gallery}: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
