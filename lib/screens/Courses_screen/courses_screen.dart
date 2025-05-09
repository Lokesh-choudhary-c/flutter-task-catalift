import 'package:catalift_task/screens/spalsh_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedInterestsProvider = StateProvider<Set<int>>((ref) => {});
final searchQueryProvider = StateProvider<String>((ref) => '');

class InterestSelectionScreen extends ConsumerWidget {
  const InterestSelectionScreen({super.key});

  static const List<String> interests = [
    "Lorem ipsum", "Lorem", "Lorem ipsum", "Lorem", "sit amet", "Lorem ipsum",
    "Lorem ipsum", "Lorem", "Lorem ipsum", "Lorem", "Lorem", "Lorem ipsum",
    "Lorem ipsum", "Lorem", "Lorem ipsum", "Lorem", "sit amet", "Lorem ipsum",
    "Lorem ipsum", "Lorem", "Lorem ipsum", "Lorem", "Lorem", "Lorem ipsum",
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSet = ref.watch(selectedInterestsProvider);
    final query = ref.watch(searchQueryProvider).toLowerCase();
    final filteredInterests = interests
        .asMap()
        .entries
        .where((entry) => entry.value.toLowerCase().contains(query))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your Interests",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A0B75),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) =>
                    ref.read(searchQueryProvider.notifier).state = value,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Color(0xFFB6C9F0), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Color(0xFFB6C9F0), width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: List.generate(filteredInterests.length, (i) {
                      final entry = filteredInterests[i];
                      final index = entry.key;
                      final label = entry.value;
                      final selected = selectedSet.contains(index);

                      return GestureDetector(
                        onTap: () {
                          final notifier =
                              ref.read(selectedInterestsProvider.notifier);
                          final newSet = Set<int>.from(selectedSet);
                          if (newSet.contains(index)) {
                            newSet.remove(index);
                          } else {
                            newSet.add(index);
                          }
                          notifier.state = newSet;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: selected
                                ? const Color(0xFF0A0B75)
                                : Colors.transparent,
                            border: Border.all(
                              color: const Color(0xFF0A0B75),
                              width: 1.2,
                            ),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Text(
                            label,
                            style: TextStyle(
                              fontSize: 14,
                              color: selected
                                  ? Colors.white
                                  : const Color(0xFF0A0B75),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>  SplashScreen(),
                        ),
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A0B75),
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF0A0B75)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
            ],
          ),
        ),
      ),
    );
  }
}


