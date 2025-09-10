import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/hooks/use_image_picker.dart';
import '../../core/widgets/back_button.dart';
import '../../export_tools.dart';
import '../../models/location.dart';
import '../../models/sectors.dart';
import '../../service_locator.dart';
import '../auth/cubit/auth_cubit.dart';
import '../location_section/cubit/location_cubit.dart';
import '../main_nav/main_nav.dart';
import '../sectors_features/cubit/sectors_cubit.dart';

class CompeleteRegisterOrganization extends HookWidget {
  const CompeleteRegisterOrganization({
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
        BlocProvider(create: (context) => sl<SectorsCubit>()..fetchAllSectors(language: lang.localeName)),
        BlocProvider(
          create: (context) => sl<LocationCubit>()..fetchAllLocation(
            language: lang.localeName,
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: BackButtonWidgets(lang: lang),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: _CompleteRegisterOrganizationBody(
          fullName: fullName,
          email: email,
          password: password,
        ),
      ),
    );
  }
}

class _CompleteRegisterOrganizationBody extends HookWidget {
  const _CompleteRegisterOrganizationBody({
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

    final selectedLocation = useState<Location?>(null);
    final selectedSector = useState<Sector?>(null); // required

    final locationController = useTextEditingController();
    final imagePickerResult = useImagePicker(imageQuality: 80);
    final aboutController = useTextEditingController();
    final contactEmailController = useTextEditingController();
    final websiteController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final errorMessage = useState<String?>(null);
    final isSubmitting = useState<bool>(false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Form(
        key: formKey,
        child: ListView(
          children: [
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
            Text('${lang.location} *'),
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
                            child: CircularProgressIndicator(strokeWidth: 2),
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
                            location.country.toLowerCase().contains(searchTerm);
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
                    validator: (location) {
                      if (location == null) {
                        return 'Location is required';
                      }
                      return null;
                    },
                    decoratorProps: DropDownDecoratorProps(
                      decoration: InputDecoration(
                        hintText: lang.select_your_location,
                        border: const OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.location_on,
                          color: Colors.green,
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
                              style: TextStyle(color: Colors.red, fontSize: 12),
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
                      suffixIcon: Icon(Icons.location_on, color: Colors.green),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
         Text("Sectors *"),
         BlocBuilder<SectorsCubit, SectorsState>(
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
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: 8),
                          Text('Loading sectors...'),
                        ],
                      ),
                    ),
                  );
                } else if (state.runtimeType.toString() == '_Loaded') {
                  final loadedState = state as dynamic;
                  final sectors = loadedState.sectors as List<Sector>;
                  return DropdownSearch<Sector>(
                    items: (filter, infiniteScrollProps) async {
                      return sectors.where((sector) {
                        if (filter.isEmpty) return true;
                        final searchTerm = filter.toLowerCase();
                        return sector.name.toLowerCase().contains(searchTerm) ||
                               sector.description.toLowerCase().contains(searchTerm);
                      }).toList();
                    },
                    itemAsString: (Sector sector) => sector.name,
                    compareFn: (Sector? item1, Sector? item2) {
                      if (item1 == null && item2 == null) return true;
                      if (item1 == null || item2 == null) return false;
                      return item1.id == item2.id;
                    },
                    onChanged: (Sector? sector) {
                      selectedSector.value = sector;
                    },
                    validator: (sector) {
                      if (sector == null) {
                        return 'Sector is required';
                      }
                      return null;
                    },
                    decoratorProps: DropDownDecoratorProps(
                      decoration: InputDecoration(
                        hintText: 'Select your sector',
                        border: const OutlineInputBorder(),
                        suffixIcon: Icon(Icons.business, color: Colors.green),
                      ),
                    ),
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          hintText: 'Search sectors...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    selectedItem: selectedSector.value,
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
                              'Error loading sectors',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                          TextButton(
                            onPressed: () => context.read<SectorsCubit>().fetchAllSectors(language: lang.localeName),
                            child: Text('Retry', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Sector',
                      border: const OutlineInputBorder(),
                      suffixIcon: Icon(Icons.business, color: Colors.green),
                    ),
                    validator: (value) {
                      if (selectedSector.value == null) {
                        return 'Sector is required';
                      }
                      return null;
                    },
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            const Text('Bio'),
            const SizedBox(height: 8),
            TextFormField(
              controller: aboutController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'About your organization',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Contact Email'),
            const SizedBox(height: 8),
            TextFormField(
              controller: contactEmailController,
              decoration: const InputDecoration(
                hintText: 'Contact Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Website'),
            const SizedBox(height: 8),
            TextFormField(
              controller: websiteController,
              decoration: const InputDecoration(
                hintText: 'Website URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: isSubmitting.value
                    ? null
                    : () async {
                        errorMessage.value = null;
                        if (formKey.currentState?.validate() != true) {
                          errorMessage.value = null;
                          return;
                        }
                      
                        if (selectedLocation.value == null) {
                          errorMessage.value = 'Location is required.';
                          return;
                        }
                        if (selectedSector.value == null) {
                          errorMessage.value = 'Sector is required.';
                          return;
                        }
                        isSubmitting.value = true;
                        try {
                          // Get sectorId from selectedSkills (first skill for demo, or adapt as needed)
                       
                          final logoPath = imagePickerResult.selectedImage?.path;
                          await sl<AuthCubit>().registerOrganization(
                            name: fullName,
                            email: email,
                            password: password,
                            locationId: int.tryParse(selectedLocation.value!.id) ?? 0,
                            sectorId: int.tryParse(selectedSector.value!.id) ?? 0,
                            bio: aboutController.text.isNotEmpty
                                ? aboutController.text
                                : null,
                            contactEmail: contactEmailController.text.isNotEmpty
                                ? contactEmailController.text
                                : null,
                            website: websiteController.text.isNotEmpty
                                ? websiteController.text
                                : null,
                            logo: logoPath,
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MainNav()),
                            (route) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Organization registered successfully!'),
                            ),
                          );
                          // Example navigation:
                          // Navigator.pushReplacementNamed(context, '/completeProfile');
                        } catch (e) {
                          log("this error is: $e");
                          errorMessage.value = e.toString();
                        } finally {
                          isSubmitting.value = false;
                        }
                      },
                child: isSubmitting.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
