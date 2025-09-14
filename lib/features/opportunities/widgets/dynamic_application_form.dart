import 'package:file_picker/file_picker.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/models/application_form.dart';
import 'package:ngo/models/form_field.dart' as ngo_form;

class DynamicApplicationForm extends HookWidget {
  final ApplicationForm applicationForm;
  final Function(Map<String, dynamic>) onSubmit;
  final VoidCallback onCancel;

  const DynamicApplicationForm({
    super.key,
    required this.applicationForm,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final formData = useState<Map<String, dynamic>>({});
    final controllers = useMemoized(() => <String, TextEditingController>{});
    final selectedValues = useState<Map<String, dynamic>>({});
    final lang = AppLocalizations.of(context)!;

    // Initialize controllers for text fields
    useEffect(() {
      for (final field in applicationForm.formFields) {
        if (_needsController(field.type)) {
          controllers[field.id.toString()] = TextEditingController();
        }
      }
      return () {
        // Clean up controllers
        for (final controller in controllers.values) {
          controller.dispose();
        }
      };
    }, [applicationForm.formFields]);

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form Header
          Text(
            applicationForm.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (applicationForm.description?.isNotEmpty == true) ...[
            const SizedBox(height: 8),
            Text(
              applicationForm.description!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
          const SizedBox(height: 24),

          // Form Fields
          Expanded(
            child: ListView.separated(
              itemCount: applicationForm.formFields.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final field = applicationForm.formFields[index];
                return _buildFormField(
                  context,
                  field,
                  controllers,
                  formData,
                  selectedValues,
                );
              },
            ),
          ),

          // Submit Buttons
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onCancel,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: MyColors.primaryColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    lang.cancel_action,
                    style: TextStyle(
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _handleSubmit(
                    formKey,
                    controllers,
                    selectedValues.value,
                    onSubmit,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    lang.submit_action,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(
    BuildContext context,
    ngo_form.FormField field,
    Map<String, TextEditingController> controllers,
    ValueNotifier<Map<String, dynamic>> formData,
    ValueNotifier<Map<String, dynamic>> selectedValues,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label with required indicator
        RichText(
          text: TextSpan(
            text: field.label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            children: [
              if (field.isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
            ],
          ),
        ),
        if (field.helpText?.isNotEmpty == true) ...[
          const SizedBox(height: 4),
          Text(
            field.helpText!,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
        const SizedBox(height: 8),

        // Field Input
        _buildFieldInput(context, field, controllers, selectedValues),
      ],
    );
  }

  Widget _buildFieldInput(
    BuildContext context,
    ngo_form.FormField field,
    Map<String, TextEditingController> controllers,
    ValueNotifier<Map<String, dynamic>> selectedValues,
  ) {
    switch (field.type) {
      case ngo_form.FormFieldType.text:
      case ngo_form.FormFieldType.email:
      case ngo_form.FormFieldType.phone:
        return _buildTextFormField(field, controllers);

      case ngo_form.FormFieldType.textarea:
        return _buildTextAreaField(field, controllers);

      case ngo_form.FormFieldType.date:
        return _buildDateField(context, field, selectedValues);

      case ngo_form.FormFieldType.select:
        return _buildSelectField(field, selectedValues);

      case ngo_form.FormFieldType.checkbox:
        return _buildCheckboxField(field, selectedValues);

      case ngo_form.FormFieldType.file:
        return _buildFileField(context, field, selectedValues);
    }
  }

  Widget _buildTextFormField(
    ngo_form.FormField field,
    Map<String, TextEditingController> controllers,
  ) {
    final controller = controllers[field.id.toString()];
    return TextFormField(
      controller: controller,
      keyboardType: _getKeyboardType(field.type),
      decoration: InputDecoration(
        hintText: field.placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MyColors.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      validator: (value) => _validateField(field, value),
    );
  }

  Widget _buildTextAreaField(
    ngo_form.FormField field,
    Map<String, TextEditingController> controllers,
  ) {
    final controller = controllers[field.id.toString()];
    return TextFormField(
      controller: controller,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: field.placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MyColors.primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      validator: (value) => _validateField(field, value),
    );
  }

  Widget _buildDateField(
    BuildContext context,
    ngo_form.FormField field,
    ValueNotifier<Map<String, dynamic>> selectedValues,
  ) {
    final selectedDate = selectedValues.value[field.id.toString()] as DateTime?;
    
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          selectedValues.value = {
            ...selectedValues.value,
            field.id.toString(): date,
          };
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.grey[600], size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                selectedDate != null
                    ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                    : field.placeholder ?? 'Select date',
                style: TextStyle(
                  color: selectedDate != null ? Colors.black87 : Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectField(
    ngo_form.FormField field,
    ValueNotifier<Map<String, dynamic>> selectedValues,
  ) {
    final selectedValue = selectedValues.value[field.id.toString()] as String?;
    final options = field.options ?? [];

    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: MyColors.primaryColor),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      hint: Text(field.placeholder ?? 'Select an option'),
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          selectedValues.value = {
            ...selectedValues.value,
            field.id.toString(): value,
          };
        }
      },
      validator: (value) => _validateField(field, value),
    );
  }

  Widget _buildCheckboxField(
    ngo_form.FormField field,
    ValueNotifier<Map<String, dynamic>> selectedValues,
  ) {
    final isChecked = selectedValues.value[field.id.toString()] as bool? ?? false;

    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (value) {
            selectedValues.value = {
              ...selectedValues.value,
              field.id.toString(): value ?? false,
            };
          },
          activeColor: MyColors.primaryColor,
        ),
        Expanded(
          child: Text(
            field.placeholder ?? field.label,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildFileField(
    BuildContext context,
    ngo_form.FormField field,
    ValueNotifier<Map<String, dynamic>> selectedValues,
  ) {
    return ValueListenableBuilder<Map<String, dynamic>>(
      valueListenable: selectedValues,
      builder: (context, values, child) {
        final fileName = values[field.id.toString()] as String?;

        return InkWell(
          onTap: () async {
            print('File picker tapped for field: ${field.id}');
            try {
              // Use file_picker to pick a file with type restrictions
              print('Starting file picker...');
              final result = await FilePicker.platform.pickFiles(
                type: FileType.any,
                allowMultiple: false,
                allowedExtensions: null, // You can restrict file types here if needed
              );
              
              print('File picker result: $result');
              
              if (result != null && result.files.isNotEmpty) {
                final file = result.files.first;
                print('Selected file: ${file.name}, size: ${file.size}');
                
                // Optional: Check file size (e.g., max 10MB)
                if (file.size > 10 * 1024 * 1024) {
                  print('File too large: ${file.size} bytes');
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('File size must be less than 10MB'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  return;
                }
                
                print('Updating selectedValues with file: ${file.name}');
                selectedValues.value = {
                  ...selectedValues.value,
                  field.id.toString(): file.name,
                  // Also store the file path if available
                  '${field.id}_path': file.path,
                  // Store file bytes if needed for upload
                  '${field.id}_bytes': file.bytes,
                };
                print('Updated selectedValues: ${selectedValues.value}');
              } else {
                print('No file selected or result was null');
              }
            } catch (e) {
              print('Error during file picking: $e');
              // Handle any errors during file picking
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error picking file: ${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.attach_file, color: Colors.grey[600], size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    fileName ?? field.placeholder ?? 'Select file',
                    style: TextStyle(
                      color: fileName != null ? Colors.black87 : Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }






  TextInputType _getKeyboardType(ngo_form.FormFieldType type) {
    switch (type) {
      case ngo_form.FormFieldType.email:
        return TextInputType.emailAddress;
      case ngo_form.FormFieldType.phone:
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }

  String? _validateField(ngo_form.FormField field, String? value) {
    if (field.isRequired && (value == null || value.isEmpty)) {
      return '${field.label} is required';
    }

    if (value != null && value.isNotEmpty) {
      switch (field.type) {
        case ngo_form.FormFieldType.email:
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          break;
        case ngo_form.FormFieldType.phone:
          if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(value)) {
            return 'Please enter a valid phone number';
          }
          break;
        default:
          break;
      }

      // Apply custom validation rules if available
      final validationRules = field.validationRules;
      if (validationRules != null) {
        final minLength = validationRules['minLength'] as int?;
        final maxLength = validationRules['maxLength'] as int?;

        if (minLength != null && value.length < minLength) {
          return '${field.label} must be at least $minLength characters';
        }
        if (maxLength != null && value.length > maxLength) {
          return '${field.label} must not exceed $maxLength characters';
        }
      }
    }

    return null;
  }

  bool _needsController(ngo_form.FormFieldType type) {
    return [
      ngo_form.FormFieldType.text,
      ngo_form.FormFieldType.textarea,
      ngo_form.FormFieldType.email,
      ngo_form.FormFieldType.phone,
    ].contains(type);
  }

  void _handleSubmit(
    GlobalKey<FormState> formKey,
    Map<String, TextEditingController> controllers,
    Map<String, dynamic> selectedValues,
    Function(Map<String, dynamic>) onSubmit,
  ) {
    if (formKey.currentState?.validate() == true) {
      final responses = <String, dynamic>{};

      // Collect text field values
      for (final entry in controllers.entries) {
        responses[entry.key] = entry.value.text;
      }

      // Collect selected values (dropdowns, checkboxes, dates, files)
      responses.addAll(selectedValues);

      onSubmit(responses);
    }
  }
}
