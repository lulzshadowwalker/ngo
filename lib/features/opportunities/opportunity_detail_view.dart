import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/core/contracts/opportunities_repository.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/applications/cubit/application_cubit.dart';
import 'package:ngo/features/opportunities/cubit/opportunities_cubit.dart';
import 'package:ngo/models/opportunity.dart';
import 'package:ngo/service_locator.dart';

class OpportunityDetailView extends HookWidget {
  final String opportunityId;

  const OpportunityDetailView({super.key, required this.opportunityId});

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<OpportunitiesCubit>()),
        BlocProvider(create: (context) => sl<ApplicationCubit>()),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<Opportunity>(
          future: sl<OpportunitiesCubit>().fetch(
            opportunityId,
            language: lang.localeName,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return _buildErrorState(context);
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No opportunity data available'));
            }

            final opportunity = snapshot.data!;
            return Stack(
              children: [
                _buildOpportunityDetails(context, opportunity),
                _buildBottomActionButtons(context, opportunity),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Failed to load opportunity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }

  Widget _buildOpportunityDetails(
    BuildContext context,
    Opportunity opportunity,
  ) {
    return CustomScrollView(
      slivers: [
        // App Bar with Image
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: const Text(
            'Opportunity Details',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                // Background image placeholder
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(opportunity.cover),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 0.3),
                        BlendMode.darken,
                      ),
                      onError: (exception, stackTrace) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Content
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      opportunity.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        opportunity.status.name.toUpperCase(),
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Duration and Time Info
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildInfoItem(
                            Icons.access_time,
                            '${(opportunity.duration / 30).round()} ${AppLocalizations.of(context)!.months_duration}',
                          ),
                          const SizedBox(width: 10),
                          _buildInfoItem(Icons.schedule, '5 hrs/week'),
                          const SizedBox(width: 10),
                          _buildInfoItem(Icons.location_on, 'On site'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              _buildSection(
                AppLocalizations.of(context)!.about_the_role,
                opportunity.aboutTheRole ?? opportunity.description,
              ),

              // Key Responsibilities
              if (opportunity.keyResponsibilities.isNotEmpty)
                _buildListSection(
                  AppLocalizations.of(context)!.key_responsibilities,
                  opportunity.keyResponsibilities,
                ),

              // Required Skills
              if (opportunity.requiredSkills.isNotEmpty)
                _buildSkillsSection(
                  AppLocalizations.of(context)!.required_skills,
                  opportunity.requiredSkills,
                ),

              // Time Commitment
              if (opportunity.timeCommitment.isNotEmpty)
                _buildListSection(
                  AppLocalizations.of(context)!.time_commitment,
                  opportunity.timeCommitment,
                ),

              // Location Section
              _buildLocationSection(opportunity, context),

              // Benefits
              if (opportunity.benefits.isNotEmpty)
                _buildBenefitsSection(opportunity.benefits, context),
             

               // Benefits
              if (opportunity.tags.isNotEmpty)
                _buildTageSection(opportunity.tags, context),

             if(opportunity.extra != null && opportunity.extra!.isNotEmpty)
                _buildSection(
                  AppLocalizations.of(context)!.additional_information,
                  opportunity.extra!,
                ),

              // Application Deadline
              _buildDeadlineSection(opportunity.expiryDate , context),

              const SizedBox(height: 100), // Space for bottom buttons
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListSection(String title, List<String> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 6, right: 12),
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection(String title, List<String> skills) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills
                .map(
                  (skill) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: MyColors.primaryColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      skill,
                      style: TextStyle(
                        fontSize: 12,
                        color: MyColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(Opportunity opportunity, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.location,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // Map placeholder
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Stack(
              children: [
                // Map placeholder pattern
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey[100]!, Colors.grey[200]!],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.map, size: 40, color: Colors.grey[400]),
                      const SizedBox(height: 8),
                      Text(
                        'Map View',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Text(
            opportunity.locationDescription ??
                'Location ID: ${opportunity.locationId}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection(List<String> benefits, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.benefits,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...benefits.map(
            (benefit) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, size: 20, color: Colors.green[600]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      benefit,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
// _buildTageSection


  Widget _buildTageSection(List<String> tags, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.tags,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: tags
                .map(
                  (tag) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                       decoration: BoxDecoration(
                      color: MyColors.primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: MyColors.primaryColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_offer,
                          size: 14,
                          color: MyColors.primaryColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          tag,
                          style: TextStyle(
                            fontSize: 13,
                            color: MyColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
 




  Widget _buildDeadlineSection(DateTime expiryDate , BuildContext context) {
    final daysLeft = expiryDate.difference(DateTime.now()).inDays;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.schedule, color: Colors.red[600], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.applications_close} ${expiryDate.day}/${expiryDate.month}/${expiryDate.year}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (daysLeft > 0)
                  Text(
                    AppLocalizations.of(context)!.days_left_to_apply(daysLeft),
                    style: TextStyle(fontSize: 12, color: Colors.red[600]),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionButtons(
    BuildContext context,
    Opportunity opportunity,
  ) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BlocConsumer<ApplicationCubit, ApplicationState>(
          listener: (context, state) {
            final stateType = state.runtimeType.toString();
            if (stateType.contains('Submitted')) {
              _showSuccessSnackBar(
                context,
                'Application submitted successfully!',
              );
            } else if (stateType.contains('SavedAsDraft')) {
              _showSuccessSnackBar(context, 'Application saved as draft!');
            } else if (stateType.contains('Error')) {
              _showErrorSnackBar(
                context,
                'Application failed. Please try again.',
              );
            }
          },
          builder: (context, state) {
            final stateType = state.runtimeType.toString();
            final isLoading =
                stateType.contains('Submitting') ||
                stateType.contains('Saving');
            final isAlreadyApplied = stateType.contains('AlreadyApplied');

            return Row(
              children: [
                // Save Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: isLoading || isAlreadyApplied
                        ? null
                        : () => _handleSave(context, opportunity),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: MyColors.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading && stateType.contains('Saving')
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            AppLocalizations.of(context)!.save,
                            style: TextStyle(
                              color: MyColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 16),

                // Apply Button
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: isLoading || isAlreadyApplied
                        ? null
                        : () => _handleApply(context, opportunity),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAlreadyApplied
                          ? Colors.grey
                          : MyColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: isLoading && stateType.contains('Submitting')
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            isAlreadyApplied ? AppLocalizations.of(context)!.already_applied :AppLocalizations.of(context)!.apply_now,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleSave(BuildContext context, Opportunity opportunity) {
    // For now, just simulate saving
    context.read<ApplicationCubit>().saveAsDraft(
      opportunityId: int.parse(opportunity.id),
      responses: [], // This would be filled with actual form responses
    );
  }

  void _handleApply(BuildContext context, Opportunity opportunity) {
    // Check if application form exists
    if (opportunity.applicationForm != null) {
      // Navigate to application form
      _showApplicationForm(context, opportunity);
    } else {
      // Direct application without form
      context.read<ApplicationCubit>().submitApplication(
        opportunityId: int.parse(opportunity.id),
        responses: [], // Basic application without custom form
      );
    }
  }

  void _showApplicationForm(BuildContext context, Opportunity opportunity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Application Form',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Application form implementation\ncoming soon!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<ApplicationCubit>().submitApplication(
                          opportunityId: int.parse(opportunity.id),
                          responses: [],
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

extension OpportunitiesCubitExtension on OpportunitiesCubit {
  Future<Opportunity> fetch(String id, {String language = 'en'}) async {
    final repository = sl<OpportunitiesRepository>();
    return await repository.fetch(id, language: language);
  }
}
