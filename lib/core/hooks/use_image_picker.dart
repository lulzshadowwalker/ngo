import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:ngo/export_tools.dart';

import '../theme/my_colors.dart';

/// A custom hook for handling image selection from camera or gallery
/// 
/// Returns a [UseImagePickerResult] which contains:
/// - [selectedImage]: The currently selected image file
/// - [pickImage]: Function to pick image from specified source
/// - [showImageSourceDialog]: Function to show camera/gallery selection dialog
/// - [clearImage]: Function to clear the selected image
class UseImagePickerResult {
  const UseImagePickerResult({
    required this.selectedImage,
    required this.pickImage,
    required this.showImageSourceDialog,
    required this.clearImage,
  });

  final File? selectedImage;
  final Future<void> Function(ImageSource source) pickImage;
  final Future<void> Function(BuildContext context) showImageSourceDialog;
  final void Function() clearImage;
}

/// Custom hook for image picking functionality
UseImagePickerResult useImagePicker({
  int imageQuality = 80,
  double? maxWidth,
  double? maxHeight,
}) {
  final selectedImage = useState<File?>(null);
  final imagePicker = useMemoized(() => ImagePicker());

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await imagePicker.pickImage(
        source: source,
        imageQuality: imageQuality,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
      );
      
      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      // Handle error (you might want to show a snackbar or dialog)
      debugPrint('Error picking image: $e');
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }

  Future<void> showImageSourceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading:  Icon(Icons.camera_alt, color: MyColors.primaryColor),
                title:  Text(AppLocalizations.of(context)!.camera),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading:  Icon(Icons.photo_library, color: MyColors.primaryColor),
                title:  Text(AppLocalizations.of(context)!.gallery),
                onTap: () {
                  Navigator.of(context).pop();
                  pickImage(ImageSource.gallery);
                },
              ),
              if (selectedImage.value != null)
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title:  Text(AppLocalizations.of(context)!.remove),
                  onTap: () {
                    Navigator.of(context).pop();
                    clearImage();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  return UseImagePickerResult(
    selectedImage: selectedImage.value,
    pickImage: pickImage,
    showImageSourceDialog: showImageSourceDialog,
    clearImage: clearImage,
  );
}
