import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class TestFilePicker extends StatefulWidget {
  const TestFilePicker({super.key});

  @override
  State<TestFilePicker> createState() => _TestFilePickerState();
}

class _TestFilePickerState extends State<TestFilePicker> {
  String? selectedFileName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Picker Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedFileName ?? 'No file selected',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  print('Starting file picker...');
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.any,
                    allowMultiple: false,
                  );

                  print('File picker result: $result');

                  if (result != null && result.files.isNotEmpty) {
                    final file = result.files.first;
                    print('Selected file: ${file.name}');
                    setState(() {
                      selectedFileName = file.name;
                    });
                  } else {
                    print('No file selected');
                  }
                } catch (e) {
                  print('Error: $e');
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                }
              },
              child: const Text('Pick File'),
            ),
          ],
        ),
      ),
    );
  }
}
