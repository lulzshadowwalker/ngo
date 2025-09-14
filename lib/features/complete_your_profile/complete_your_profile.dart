import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/features/location_section/cubit/location_cubit.dart';
import 'package:ngo/features/main_nav/main_nav.dart';

import '../../core/hooks/use_image_picker.dart';
import '../../core/theme/my_colors.dart';
import '../../core/theme/my_fonts.dart';
import '../../export_tools.dart';
import '../../models/location.dart';
import '../../models/sectors.dart';
import '../../models/skill.dart';
import '../../service_locator.dart';
import '../auth/cubit/auth_cubit.dart';
import '../organization/cubit/organization_cubit.dart';
import '../sectors_features/cubit/sectors_cubit.dart';
import '../skills/cubit/skills_cubit.dart';

class CompleteYourProfile extends HookWidget {
  const CompleteYourProfile({
    super.key,
    required this.fullName,
    required this.email,
    required this.password,
  });
  final String fullName;
  final String email;
  final String password;
  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<SkillsCubit>()..fetchAllSkills(language: lang.localeName),
        ),
        BlocProvider(
          create: (context) =>
              sl<LocationCubit>()..fetchAllLocation(language: lang.localeName),
        ),
        BlocProvider(
          create: (context) =>
              sl<OrganizationCubit>()
                ..fetchAllOrganizations(language: lang.localeName),
        ),
        BlocProvider(
          create: (context) =>
              sl<SectorsCubit>()..fetchAllSectors(language: lang.localeName),
        ),
      ],
      child: _CompleteYourProfileView(
        fullName: fullName,
        email: email,
        password: password,
      ),
    );
  }
}

class _CompleteYourProfileView extends HookWidget {
  const _CompleteYourProfileView({
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String email;
  final String password;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final aboutController = useTextEditingController();
    final locationController = useTextEditingController();
    final selectedDate = useState<DateTime?>(null);
    final selectedLocation = useState<Location?>(null);
    final selectedSkills = useState<List<Skill>>([]);
    final selectedSectors = useState<List<Sector>>([]);
    final followedOrgs = useState<List<dynamic>>([]);

    // Use the custom image picker hook
    final imagePickerResult = useImagePicker(imageQuality: 80);
    var lang = AppLocalizations.of(context)!;
    Widget stepIndicator(int step) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          return Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: i <= step
                    ? MyColors.primaryColor
                    : Colors.grey[300],
                child: i <= step
                    ? const Icon(Icons.check, color: Colors.white)
                    : null,
              ),
              if (i < 2)
                Container(
                  width: 40,
                  height: 4,
                  color: i < step ? MyColors.primaryColor : Colors.grey[300],
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
        title: Text(
          lang.complete_your_profile,
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
            child: ListView(
              children: [
                stepIndicator(0),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    lang.step_1_of_3,
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () =>
                        imagePickerResult.showImageSourceDialog(context),
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: MyColors.primaryColor,
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                            image: imagePickerResult.selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(
                                      imagePickerResult.selectedImage!,
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: imagePickerResult.selectedImage == null
                              ? const Icon(
                                  Icons.camera_alt,
                                  color: MyColors.primaryColor,
                                  size: 40,
                                )
                              : null,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          imagePickerResult.selectedImage == null
                              ? lang.addProfilePicture
                              : lang.changeProfilePicture,
                          style: const TextStyle(
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(lang.aboutYou),
                const SizedBox(height: 8),
                TextFormField(
                  controller: aboutController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: lang.tellUsAboutYourself,
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Text(lang.dateOfBirth),
                const SizedBox(height: 8),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: selectedDate.value == null
                        ? lang.selectYourDateOfBirth
                        : '${selectedDate.value!.day}/${selectedDate.value!.month}/${selectedDate.value!.year}',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.calendar_today,
                        color: MyColors.primaryColor,
                      ),
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
                      backgroundColor: MyColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    ),
                    child: Text(
                      lang.next,
                      style: MyFonts.font16Black.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Step 2
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                stepIndicator(1),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    lang.step_2_of_3,
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(lang.location),
                const SizedBox(height: 8),

                BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    if (state.runtimeType.toString() == '_Loading') {
                      return Container(
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text('Loading locations...'),
                            ],
                          ),
                        ),
                      );
                    } else if (state.runtimeType.toString() == '_Loaded') {
                      final loadedState = state as dynamic;
                      final locations = loadedState.locations as List<Location>;

                      return DropdownSearch<Location>(
                        items: (filter, infiniteScrollProps) async {
                          return locations.where((location) {
                            if (filter.isEmpty) {
                              return true;
                            }
                            final searchTerm = filter.toLowerCase();
                            return location.city.toLowerCase().contains(
                                  searchTerm,
                                ) ||
                                location.country.toLowerCase().contains(
                                  searchTerm,
                                );
                          }).toList();
                        },
                        itemAsString: (Location location) =>
                            "${location.city}, ${location.country}",
                        // Add the compareFn to fix the error
                        compareFn: (Location? item1, Location? item2) {
                          if (item1 == null && item2 == null) return true;
                          if (item1 == null || item2 == null) return false;
                          // Compare based on a unique identifier (assuming Location has an id field)
                          // If Location doesn't have an id, compare based on city and country combination
                          return item1.id ==
                              item2.id; // Use this if Location has an id field
                          // OR use this if Location doesn't have an id field:
                          // return item1.city == item2.city && item1.country == item2.country;
                        },
                        onChanged: (Location? location) {
                          selectedLocation.value = location;
                          if (location != null) {
                            locationController.text =
                                "${location.city}, ${location.country}";
                          }
                        },
                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            hintText: lang.select_your_location,
                            border: const OutlineInputBorder(),
                            suffixIcon: Icon(
                              Icons.location_on,
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ),
                        popupProps: PopupProps.menu(
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              hintText: 'Search locations...',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        selectedItem: selectedLocation.value,
                      );
                    } else if (state.runtimeType.toString() == '_Error') {
                      return Container(
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.red, size: 16),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Error loading locations',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () => context
                                    .read<LocationCubit>()
                                    .fetchAllLocation(),
                                child: Text(
                                  'Retry',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(
                          hintText: 'City, Area',
                          border: const OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.location_on,
                            color: MyColors.primaryColor,
                          ),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                Text(lang.skills),
                const SizedBox(height: 8),
                // Selected skills display
                if (selectedSkills.value.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    children: selectedSkills.value
                        .map(
                          (skill) => Chip(
                            label: Text(skill.name),
                            backgroundColor: Colors.green[50],
                            labelStyle: const TextStyle(
                              color: MyColors.primaryColor,
                            ),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () {
                              selectedSkills.value = List.from(
                                selectedSkills.value,
                              )..remove(skill);
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                ],
                // Add skills button
                BlocBuilder<SkillsCubit, SkillsState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () => _showSkillsBottomSheet(
                        context,
                        state,
                        selectedSkills,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: MyColors.primaryColor),
                            const SizedBox(width: 8),
                            Text(
                              lang.add_skills,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
                Text(lang.sectors),
                const SizedBox(height: 8),
                // Selected sectors display
                if (selectedSectors.value.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    children: selectedSectors.value
                        .map(
                          (sector) => Chip(
                            label: Text(sector.name),
                            backgroundColor: Colors.green[50],
                            labelStyle: const TextStyle(
                              color: MyColors.primaryColor,
                            ),
                            deleteIcon: const Icon(Icons.close, size: 18),
                            onDeleted: () {
                              selectedSectors.value = List.from(
                                selectedSectors.value,
                              )..remove(sector);
                            },
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                ],
                // Add sectors button
                BlocBuilder<SectorsCubit, SectorsState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () => _showSectorsBottomSheet(
                        context,
                        state,
                        selectedSectors,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: MyColors.primaryColor),
                            const SizedBox(width: 8),
                            Text(
                              'Add Interests',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),

                BlocProvider(
                  create: (context) => sl<AuthCubit>(),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      final stateType = state.runtimeType.toString();
                      if (stateType.contains('Authenticated')) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      } else if (stateType.contains('RegisterError')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Registration failed. Please try again.',
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      final stateType = state.runtimeType.toString();
                      final isLoading = stateType.contains('Registering');

                      return SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: isLoading
                              ? null
                              : () async {
                                  // Validate required fields
                                  if (selectedLocation.value == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Please select a location',
                                        ),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                    return;
                                  }
                                  if (selectedSkills.value.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Please add at least one skill',
                                        ),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                    return;
                                  }
                                  if (selectedSectors.value.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Please add at least one interest',
                                        ),
                                        backgroundColor: Colors.orange,
                                      ),
                                    );
                                    return;
                                  }

                                  try {
                                    await context
                                        .read<AuthCubit>()
                                        .registerIndividual(
                                          name: fullName,
                                          email: email,
                                          password: password,
                                          locationId:
                                              int.tryParse(
                                                selectedLocation.value!.id,
                                              ) ??
                                              0,
                                          avatar: imagePickerResult
                                              .selectedImage
                                              ?.path,
                                        );
                                  } catch (e) {
                                    log("Registration error: $e");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Registration failed: ${e.toString()}',
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                },
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
                                  lang.next,
                                  style: MyFonts.font16Black.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      );
                    },
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
                Center(
                  child: Text(
                    lang.step_3_of_3,
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  lang.follow_interest_organizations,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: BlocBuilder<OrganizationCubit, OrganizationState>(
                    builder: (context, state) {
                      if (state.runtimeType.toString() == '_Loading') {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text('Loading organizations...'),
                            ],
                          ),
                        );
                      } else if (state.runtimeType.toString() == '_Loaded') {
                        final loadedState = state as dynamic;
                        final organizations =
                            loadedState.organizations as List<dynamic>;

                        if (organizations.isEmpty) {
                          return Center(
                            child: Text('No organizations available'),
                          );
                        }

                        return ListView.builder(
                          itemCount: organizations.length,
                          itemBuilder: (context, index) {
                            final org = organizations[index];
                            final isFollowed = followedOrgs.value.any(
                              (followed) => (followed as dynamic).id == org.id,
                            );

                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 1,
                                ),
                              ),
                              margin: const EdgeInsets.only(bottom: 16),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: org.logo.isNotEmpty
                                      ? NetworkImage(org.logo)
                                      : null,
                                  child: org.logo.isEmpty
                                      ? const Icon(
                                          Icons.business,
                                          color: MyColors.primaryColor,
                                        )
                                      : null,
                                ),
                                title: Text(
                                  org.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(org.sector),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(child: Text(org.location)),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isFollowed
                                        ? Colors.grey[300]
                                        : MyColors.primaryColor,
                                    foregroundColor: isFollowed
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                  onPressed: () async {
                                    if (isFollowed) {
                                      followedOrgs.value = followedOrgs.value
                                          .where(
                                            (followed) =>
                                                (followed as dynamic).slug !=
                                                org.slug,
                                          )
                                          .toList();
                                      // Call API to unfollow
                                      await context
                                          .read<OrganizationCubit>()
                                          .unfollowOrganization(org.slug);
                                    } else {
                                      followedOrgs.value = [
                                        ...followedOrgs.value,
                                        org,
                                      ];
                                      // Call API to follow
                                      await context
                                          .read<OrganizationCubit>()
                                          .followOrganization(org.slug);
                                    }
                                  },
                                  child: Text(
                                    isFollowed
                                        ? AppLocalizations.of(
                                            context,
                                          )!.following
                                        : AppLocalizations.of(context)!.follow,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state.runtimeType.toString() == '_Error') {
                        final errorState = state as dynamic;
                        final message = errorState.message as String;
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.red, size: 48),
                              SizedBox(height: 16),
                              Text(
                                'Error loading organizations',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(message, textAlign: TextAlign.center),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => context
                                    .read<OrganizationCubit>()
                                    .fetchAllOrganizations(),
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(child: Text('Loading organizations...'));
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Navigate to main app screen
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MainNav()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      lang.next,
                      style: MyFonts.font16Black.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSkillsBottomSheet(
    BuildContext context,
    SkillsState state,
    ValueNotifier<List<Skill>> selectedSkills,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.only(
                bottom: 60,
                left: 16,
                right: 16,
                top: 8,
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.select_skills,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: () {
                      if (state.runtimeType.toString() == '_Loading') {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.runtimeType.toString() == '_Loaded') {
                        final loadedState = state as dynamic;
                        final skills = loadedState.skills as List<Skill>;
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: skills.length,
                          itemBuilder: (context, index) {
                            final skill = skills[index];
                            final isSelected = selectedSkills.value.any(
                              (s) => s.id == skill.id,
                            );
                            return CheckboxListTile(
                              title: Text(skill.name),
                              value: isSelected,
                              activeColor: MyColors.primaryColor,
                              onChanged: (bool? value) {
                                if (value == true) {
                                  selectedSkills.value = [
                                    ...selectedSkills.value,
                                    skill,
                                  ];
                                } else {
                                  selectedSkills.value = selectedSkills.value
                                      .where((s) => s.id != skill.id)
                                      .toList();
                                }
                                // Trigger modal state update
                                setModalState(() {});
                              },
                            );
                          },
                        );
                      } else if (state.runtimeType.toString() == '_Error') {
                        final errorState = state as dynamic;
                        final message = errorState.message as String;
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.red, size: 48),
                              const SizedBox(height: 16),
                              Text(
                                'Error loading skills',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(message),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () =>
                                    sl<SkillsCubit>().fetchAllSkills(),
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: Text('Loading skills...'));
                      }
                    }(),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24, top: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 24,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          AppLocalizations.of(context)!.done,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSectorsBottomSheet(
    BuildContext context,
    SectorsState state,
    ValueNotifier<List<Sector>> selectedSectors,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.only(
                bottom: 70,
                left: 16,
                right: 16,
                top: 8,
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.select_sectors,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: () {
                      if (state.runtimeType.toString() == '_Loading') {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.runtimeType.toString() == '_Loaded') {
                        final loadedState = state as dynamic;
                        final sectors = loadedState.sectors as List<Sector>;
                        return ListView.builder(
                          controller: scrollController,
                          itemCount: sectors.length,
                          itemBuilder: (context, index) {
                            final sector = sectors[index];
                            final isSelected = selectedSectors.value.any(
                              (s) => s.id == sector.id,
                            );
                            return CheckboxListTile(
                              title: Text(sector.name),

                              value: isSelected,
                              activeColor: MyColors.primaryColor,
                              onChanged: (bool? value) {
                                if (value == true) {
                                  selectedSectors.value = [
                                    ...selectedSectors.value,
                                    sector,
                                  ];
                                } else {
                                  selectedSectors.value = selectedSectors.value
                                      .where((s) => s.id != sector.id)
                                      .toList();
                                }
                                // Trigger modal state update
                                setModalState(() {});
                              },
                            );
                          },
                        );
                      } else if (state.runtimeType.toString() == '_Error') {
                        final errorState = state as dynamic;
                        final message = errorState.message as String;
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.red, size: 48),
                              const SizedBox(height: 16),
                              Text(
                                'Error loading sectors',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(message),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () =>
                                    sl<SectorsCubit>().fetchAllSectors(),
                                child: Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return const Center(child: Text('Loading sectors...'));
                      }
                    }(),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        AppLocalizations.of(context)!.done,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
