


import '../../core/theme/my_colors.dart';
import '../../export_tools.dart';

class EditProfileView extends HookWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNameController = useTextEditingController(text: 'Sarah Johnson');
    final bioController = useTextEditingController(text: 'Passionate about making a difference in education and youth development. Currently volunteering with local NGOs.');
    final emailController = useTextEditingController(text: 'sarah.johnson@email.com');
    final phoneController = useTextEditingController(text: '+1 234 567');
    
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
            child: _buildProfilePhotoSection(),
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

  Widget _buildProfilePhotoSection() {
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
                  child: Container(
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
            ],
          ),
          const SizedBox(height: 12),
          
          // Change Photo Text
          GestureDetector(
            onTap: () {
              // Handle change photo
            },
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
}
