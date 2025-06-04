// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:ngo/providers/l10n.dart';

// class Home extends ConsumerWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final localeState = ref.watch(localeProvider);
//     final isEnglish = ref.watch(localeProvider).isEnglish;

//     return Scaffold(
//       appBar: AppBar(title: Text(isEnglish ? 'Home' : 'الرئيسية')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Current Language: ${localeState.languageCode.toUpperCase()}',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               isEnglish ? 'Welcome to our app!' : 'مرحبا بكم في تطبيقنا!',
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//             const SizedBox(height: 40),
//             ElevatedButton(
//               onPressed: () {
//                 ref.read(localeProvider.notifier).switchLanguage();
//               },
//               child: Text(
//                 isEnglish ? 'Switch to Arabic' : 'التبديل إلى الإنجليزية',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Example of a widget that only cares about language state
// class LanguageIndicator extends ConsumerWidget {
//   const LanguageIndicator({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final languageCode = ref.watch(localeProvider).languageCode;

//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         languageCode.toUpperCase(),
//         style: const TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }

// // Example of manually setting a specific locale
// class LocaleSelector extends ConsumerWidget {
//   const LocaleSelector({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             ref.read(localeProvider.notifier).setLocale(englishLocale);
//           },
//           child: const Text('English'),
//         ),
//         const SizedBox(width: 10),
//         ElevatedButton(
//           onPressed: () {
//             ref.read(localeProvider.notifier).setLocale(arabicLocale);
//           },
//           child: const Text('العربية'),
//         ),
//       ],
//     );
//   }
// }
