


import 'package:flutter_bloc/flutter_bloc.dart';

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
    final phoneController = useTextEditingController();
    
    
    final selectedSkills = useState<Set<String>>({
      'Leadership', 
      'Communication', 
      'Project Management'
    });
    
    final selectedInterests = useState<Set<String>>({
      'Education', 
      'Environment'
    });
    
    final phoneError = useState<String?>(null);

    return BlocConsumer<UserManagementCubit, UserManagementState>(
      listener: (context, state) {
        // Handle error states
        if (state.toString().contains('error')) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error loading profile data')),
          );
        }
      },
      builder: (context, state) {
        // Handle loading state
        if (state.toString().contains('loading') ||
            state.toString().contains('initial')) {
          return _buildLoadingScaffold(context);
        }
        
        // Handle error state
        if (state.toString().contains('error')) {
          return _buildErrorScaffold(context);
        }
        
        // Handle loaded state - extract user data
        User? user;
        if (state.toString().contains('loaded')) {
          user = _extractUserFromState(state);
          
          // Update controllers with user data when loaded
          WidgetsBinding.instance.addPostFrameCallback((_) {
            fullNameController.text = user?.name ?? '';
            bioController.text = user?.bio ?? '';
            emailController.text = user?.email ?? '';
            
            
          });
        }
        
        return _buildMainScaffoldWithUserData(
          context, 
          user,
          fullNameController,
          bioController,
          emailController,
          phoneController,
          selectedSkills,
          selectedInterests,
          phoneError,
        );
      },
    );
  }
  
  // Helper method to extract user from state string
  User? _extractUserFromState(UserManagementState state) {
    try {
      final stateString = state.toString();
      
      if (stateString.contains('User(')) {
        // Extract user data using regex similar to profile_view.dart
        final nameMatch = RegExp(r'name: ([^,\)]+)').firstMatch(stateString);
        final emailMatch = RegExp(r'email: ([^,\)]+)').firstMatch(stateString);
        final bioMatch = RegExp(r'bio: ([^,\)]+)').firstMatch(stateString);
        final avatarMatch = RegExp(r'avatar: ([^,\)]+)').firstMatch(stateString);
        final idMatch = RegExp(r'id: ([^,\)]+)').firstMatch(stateString);
        
        // Create a basic user object with available data
        if (nameMatch != null) {
          return User(
            id: idMatch?.group(1) ?? '0',
            name: nameMatch.group(1)?.trim() ?? '',
            email: emailMatch?.group(1)?.trim() ?? '',
            bio: bioMatch?.group(1)?.trim() != 'null' ? bioMatch?.group(1)?.trim() : null,
            avatar: avatarMatch?.group(1)?.trim() != 'null' ? avatarMatch?.group(1)?.trim() : null,
            birthdate: null,
            location: null,
            skills: [],
          );
        }
      }
    } catch (e) {
      debugPrint('Error extracting user from state: $e');
    }
    return null;
  }

  Widget _buildMainScaffoldWithUserData(
    BuildContext context, 
    User? user,
    TextEditingController fullNameController,
    TextEditingController bioController,
    TextEditingController emailController,
    TextEditingController phoneController,
    ValueNotifier<Set<String>> selectedSkills,
    ValueNotifier<Set<String>> selectedInterests,
    ValueNotifier<String?> phoneError,
  ) {
    final skills = [
      'Leadership', 'Communication', 'Project Management', 'Public Speaking',
      'Social Media', 'Event Planning'
    ];
    
    final interests = [
      'Education', 'Environment', 'Healthcare', 'Social Justice',
      'Youth Development', 'Arts & Culture'
    ];

    // Validate phone number
    void validatePhone(String value) {
      if (value.isEmpty) {
        phoneError.value = 'Please enter a valid phone number';
      } else if (value.length < 8) {
        phoneError.value = 'Please enter a valid phone number';
      } else {
        phoneError.value = null;
      }
    }

    return _buildMainScaffold(
      context,
      user: user,
      fullNameController: fullNameController,
      bioController: bioController,
      emailController: emailController,
      phoneController: phoneController,
      selectedSkills: selectedSkills,
      selectedInterests: selectedInterests,
      skills: skills,
      interests: interests,
      phoneError: phoneError,
      validatePhone: validatePhone,
    );
  }

  Widget _buildErrorScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Error loading profile data'),
            ElevatedButton(
              onPressed: () => context.read<UserManagementCubit>().fetchCurrentUser(),
              child: const Text('Retry'),
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
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }



  Widget _buildMainScaffold(
    BuildContext context, {
    User? user,
    required TextEditingController fullNameController,
    required TextEditingController bioController,
    required TextEditingController emailController,
    required TextEditingController phoneController,
    required ValueNotifier<Set<String>> selectedSkills,
    required ValueNotifier<Set<String>> selectedInterests,
    required List<String> skills,
    required List<String> interests,
    required ValueNotifier<String?> phoneError,
    required Function(String) validatePhone,
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
        title: const Text(
          'Edit Profile',
          style: TextStyle(
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
            child: _buildProfilePhotoSection(context, user),
          ),
          
          // Form Fields
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Full Name Field
                  _buildTextField(
                    label: 'Full Name',
                    controller: fullNameController,
                  ),
                  const SizedBox(height: 24),
                  
                  // Bio Field
                  _buildTextField(
                    label: 'Bio',
                    controller: bioController,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),
                  
                  // Skills Section
                  _buildChipSection(
                    title: 'Skills',
                    items: skills,
                    selectedItems: selectedSkills.value,
                    onSelectionChanged: (item) {
                      final newSelection = Set<String>.from(selectedSkills.value);
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
                    title: 'Interests',
                    items: interests,
                    selectedItems: selectedInterests.value,
                    onSelectionChanged: (item) {
                      final newSelection = Set<String>.from(selectedInterests.value);
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
                    label: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  
                  // Phone Number Field
                  _buildTextField(
                    label: 'Phone Number',
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    errorText: phoneError.value,
                    onChanged: validatePhone,
                  ),
                  const SizedBox(height: 32),
                  
                  // Save Changes Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        validatePhone(phoneController.text);
                        if (phoneError.value == null) {
                          // Handle save changes
                          _saveChanges(context);
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
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(
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

  Widget _buildProfilePhotoSection(BuildContext context, User? user) {
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
                  border: Border.all(
                    color: MyColors.primaryColor,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: user?.avatar != null && user!.avatar!.isNotEmpty
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
                  onTap: () => _showImageSourceDialog(context),
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
            onTap: () => _showImageSourceDialog(context),
            child: const Text(
              'Change Photo',
              style: TextStyle(
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
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? errorText,
    void Function(String)? onChanged,
  }) {
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
            hintText: 'Enter $label',
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
            style: const TextStyle(
              fontSize: 12,
              color: Colors.red,
            ),
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

  void _saveChanges(BuildContext context) {
    // Handle save changes logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: MyColors.primaryColor,
      ),
    );
    Navigator.pop(context);
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text('Cancel'),
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

  void _pickImageFromCamera(BuildContext context) {
    // TODO: Implement camera image picker
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Camera functionality will be implemented'),
        backgroundColor: MyColors.primaryColor,
      ),
    );
  }

  void _pickImageFromGallery(BuildContext context) {
    // TODO: Implement gallery image picker
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gallery functionality will be implemented'),
        backgroundColor: MyColors.primaryColor,
      ),
    );
  }
}
