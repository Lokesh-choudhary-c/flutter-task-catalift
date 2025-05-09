import 'package:catalift_task/screens/Courses_screen/courses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final educationLevelProvider = StateProvider<String?>((ref) => null);
final institutionProvider = StateProvider<String?>((ref) => null);
final rolesTextProvider = StateProvider<String>((ref) => '');

final _formKey = GlobalKey<FormState>();

class EducationDetailsScreen extends ConsumerWidget {
  const EducationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLevel = ref.watch(educationLevelProvider);
    final selectedInstitution = ref.watch(institutionProvider);
    final rolesText = ref.watch(rolesTextProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFE),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Your Education Details',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0A0B75),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),

                          const Text(
                            'Highest Education Level',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: selectedLevel,
                            validator: (val) =>
                                val == null ? 'Please select education level' : null,
                            items: [
                              'High School',
                              'Bachelor’s',
                              'Master’s',
                              'PhD',
                            ]
                                .map((level) => DropdownMenuItem(
                                      value: level,
                                      child: Text(level),
                                    ))
                                .toList(),
                            onChanged: (val) => ref
                                .read(educationLevelProvider.notifier)
                                .state = val,
                            decoration: _dropdownDecoration,
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            'Current Institution',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: selectedInstitution,
                            validator: (val) =>
                                val == null ? 'Please select institution' : null,
                            items: [
                              'University A',
                              'University B',
                              'Institute C',
                            ]
                                .map((inst) => DropdownMenuItem(
                                      value: inst,
                                      child: Text(inst),
                                    ))
                                .toList(),
                            onChanged: (val) => ref
                                .read(institutionProvider.notifier)
                                .state = val,
                            decoration: _dropdownDecoration,
                          ),

                          const SizedBox(height: 24),

                          const Text(
                            'Relevant Past Roles/Internships',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 8),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              TextFormField(
                                maxLines: 6,
                                maxLength: 1000,
                                initialValue: rolesText,
                                validator: (val) {
                                  if (val == null || val.trim().isEmpty) {
                                    return 'Please describe past roles';
                                  }
                                  if (val.split(RegExp(r'\s+')).length > 100) {
                                    return 'Limit to 100 words';
                                  }
                                  return null;
                                },
                                onChanged: (val) => ref
                                    .read(rolesTextProvider.notifier)
                                    .state = val,
                                decoration: InputDecoration(
                                  hintText: 'Write in 100 words',
                                  hintStyle: const TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  contentPadding: const EdgeInsets.all(12),
                                  counterText: '',
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, bottom: 6),
                                child: Text(
                                  '${rolesText.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length}/100 words typed',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF0A0B75),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const InterestSelectionScreen(),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0A0B75),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Continue',
                                style: TextStyle(fontSize: 16,color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Back Button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                side: const BorderSide(color: Color(0xFF0A0B75)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: const Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF0A0B75),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

final _dropdownDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: Colors.blueAccent),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: Color(0xFFB6C9F0)),
  ),
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
);
