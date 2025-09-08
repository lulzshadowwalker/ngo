
import 'dart:developer';

import '../../core/hooks/use_image_picker.dart';
import '../../core/theme/my_fonts.dart';
import '../../export_tools.dart';

class CompleteYourProfile extends HookWidget {
  const CompleteYourProfile({super.key , required this.fullName, required this.email, required this.password});
  final String fullName;
  final String email;
  final String password;
  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final aboutController = useTextEditingController();
    final locationController = useTextEditingController();
    final selectedDate = useState<DateTime?>(null);
    final skills = useState<List<String>>(['Communication', 'Leadership']);
    final interests = useState<List<String>>(['Education', 'Environment']);
    final followedOrgs = useState<List<String>>([]);
    
    // Use the custom image picker hook
    final imagePickerResult = useImagePicker(imageQuality: 80);

    Widget stepIndicator(int step) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          return Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: i <= step
                    ? Colors.green[700]
                    : Colors.grey[300],
                child: i <= step
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
              if (i < 2)
                Container(
                  width: 40,
                  height: 4,
                  color: i < step
                      ? Colors.green[700]
                      : Colors.grey[300],
                ),
            ],
          );
        }),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Complete Your Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Step 1
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                stepIndicator(0),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Step 1 of 3',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () => imagePickerResult.showImageSourceDialog(context),
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.green,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                            image: imagePickerResult.selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(imagePickerResult.selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: imagePickerResult.selectedImage == null
                              ? const Icon(
                                  Icons.camera_alt,
                                  color: Colors.green,
                                  size: 40,
                                )
                              : null,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          imagePickerResult.selectedImage == null
                              ? 'Add Profile Picture'
                              : 'Change Profile Picture',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text('About Me'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: aboutController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Tell us about yourself...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Date of Birth'),
                const SizedBox(height: 8),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: selectedDate.value == null
                        ? 'Select date'
                        : '${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today, color: Colors.green),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) selectedDate.value = picked;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 32),
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
                    onPressed: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    ),
                    child:  Text('Next',      style: MyFonts.font16Black.copyWith(color: Colors.white),),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Handle skip
                    },
                    child: const Text(
                      'Skip for Now',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Step 2
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                stepIndicator(1),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Step 2 of 3',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text('Location'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    hintText: 'City, Area',
                    border: const OutlineInputBorder(),
                    suffixIcon: Icon(Icons.location_on, color: Colors.green),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Skills'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: skills.value
                      .map((skill) => Chip(
                            label: Text(skill),
                            backgroundColor: Colors.green[50],
                            labelStyle: const TextStyle(color: Colors.green),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () {
                              skills.value = List.from(skills.value)..remove(skill);
                            },
                          ))
                      .toList(),
                ),
                const SizedBox(height: 20),
                const Text('Volunteering Interests'),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: interests.value
                      .map((interest) => Chip(
                            label: Text(interest),
                            backgroundColor: Colors.green[50],
                            labelStyle: const TextStyle(color: Colors.green),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () {
                              interests.value = List.from(interests.value)..remove(interest);
                            },
                          ))
                      .toList(),
                ),
                const SizedBox(height: 32),
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
                    onPressed: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    ),
                    child:  Text('Next',      style: MyFonts.font16Black.copyWith(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
          // Step 3
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                stepIndicator(2),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Step 3 of 3',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Follow Interest Organizations',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const SizedBox(height: 16),
                ...[
                  {
                    'name': 'Youth Empowerment Foundation',
                    'desc': 'Education & Development',
                    'location': 'Zarqa, Jordan',
                    'img': null,
                  },
                  {
                    'name': 'Green Earth Jordan',
                    'desc': 'Environmental Conservation',
                    'location': 'Amman, Jordan',
                    'img': null,
                  },
                ].map((org) => Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!, width: 1)  ),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: org['img'] == null
                              ? null
                              : NetworkImage(org['img'] as String),
                          child: org['img'] == null
                              ? const Icon(Icons.business, color: Colors.green)
                              : null,
                        ),
                        title: Text(
                          org['name'] as String,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(org['desc'] as String),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(org['location'] as String),
                              ],
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: followedOrgs.value.contains(org['name'])
                                ? Colors.grey[300]
                                : Colors.green[700],
                            foregroundColor: followedOrgs.value.contains(org['name'])
                                ? Colors.black
                                : Colors.white,
                          ),
                          onPressed: () {
                            if (followedOrgs.value.contains(org['name'])) {
                              followedOrgs.value = List.from(followedOrgs.value)..remove(org['name']);
                            } else {
                              followedOrgs.value = List.from(followedOrgs.value)..add(org['name'] as String);
                            }
                          },
                          child: Text(
                            followedOrgs.value.contains(org['name']) ? 'Following' : 'Follow',
                          ),
                        ),
                      ),
                    )),
                const SizedBox(height: 32),
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
                     /// print all collected data
                     log("Full Name: $fullName");
                     log("Email: $email");
                     log("Password: $password");
                     log("About: ${aboutController.text}");
                     log("DOB: ${selectedDate.value}");
                     log("Location: ${locationController.text}");
                     log("Skills: ${skills.value}");
                     log("Interests: ${interests.value}");
                     log("Followed Orgs: ${followedOrgs.value}");
                     /// print selected image path
                     log("Profile Image Path: ${imagePickerResult.selectedImage?.path}");
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> MainNav()));
                    },
                    child:  Text('Save Profile',      style: MyFonts.font16Black.copyWith(color: Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );  
  }
}
