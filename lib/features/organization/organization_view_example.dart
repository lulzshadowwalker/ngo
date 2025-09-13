// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ngo/export_tools.dart';
// import 'package:ngo/features/components/search_and_filter_widget.dart';
// import 'package:ngo/features/organization/cubit/organization_cubit.dart';
// import 'package:ngo/service_locator.dart';

// import '../sectors_features/cubit/sectors_cubit.dart';

// class OrganizationView extends HookWidget {
//   const OrganizationView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final searchController = useTextEditingController();
//     final scrollController = useScrollController();
//     var lang = AppLocalizations.of(context)!;

//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) =>
//               sl<OrganizationCubit>()..fetchAllOrganizations(language: lang.localeName),
//         ),
//         BlocProvider(
//           create: (context) =>
//               sl<SectorsCubit>()..fetchAllSectors(language: lang.localeName),
//         ),
//       ],
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: const Text(
//             'Organizations',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // Search and Filter Component
//               SearchAndFilterWidget(
//                 filterType: FilterType.organization,
//                 searchController: searchController,
//                 searchHint: 'Search organizations...',
//                 onSearch: (query) {
//                   context.read<OrganizationCubit>().searchOrganizations(
//                     query: query,
//                     language: lang.localeName,
//                   );
//                 },
//                 onFilter: (label, sectorId) {
//                   if (sectorId != null) {
//                     context.read<OrganizationCubit>().filterBySector(
//                       sectorId: sectorId,
//                       language: lang.localeName,
//                     );
//                   } else {
//                     context.read<OrganizationCubit>().fetchAllOrganizations(
//                       language: lang.localeName,
//                     );
//                   }
//                 },
//                 onClearFilters: () {
//                   context.read<OrganizationCubit>().fetchAllOrganizations(
//                     language: lang.localeName,
//                   );
//                 },
//               ),
//               const SizedBox(height: 20),

//               // Organizations List
//               Expanded(
//                 child: BlocBuilder<OrganizationCubit, OrganizationState>(
//                   builder: (context, state) {
//                     final stateType = state.runtimeType.toString();

//                     if (stateType.contains('Loading')) {
//                       return const Center(child: CircularProgressIndicator());
//                     }

//                     if (stateType.contains('Error')) {
//                       return const Center(
//                         child: Text('Error loading organizations'),
//                       );
//                     }

//                     if (stateType.contains('Loaded')) {
//                       final loadedState = state as dynamic;
//                       final organizations = loadedState.organizations as List<dynamic>;

//                       if (organizations.isEmpty) {
//                         return const Center(
//                           child: Text('No organizations found'),
//                         );
//                       }

//                       return ListView.builder(
//                         controller: scrollController,
//                         itemCount: organizations.length,
//                         itemBuilder: (context, index) {
//                           final organization = organizations[index];
//                           return _buildOrganizationCard(organization, context);
//                         },
//                       );
//                     }

//                     return const SizedBox.shrink();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildOrganizationCard(dynamic organization, BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withValues(alpha: 0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               organization.name ?? 'Organization',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               organization.description ?? 'No description available',
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//               ),
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
