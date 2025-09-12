import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ngo/core/contracts/opportunities_repository.dart';
import 'package:ngo/core/theme/my_colors.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/opportunities/cubit/opportunities_cubit.dart';
import 'package:ngo/models/opportunity.dart';
import 'package:ngo/service_locator.dart';

class OpportunityDetailView extends HookWidget {
  final String opportunityId;

  const OpportunityDetailView({
    super.key,
    required this.opportunityId,
  });

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => sl<OpportunitiesCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Opportunity Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share, color: Colors.black),
              onPressed: () {
                // Handle sharing
              },
            ),
          ],
        ),
        body: FutureBuilder<Opportunity>(
          future: sl<OpportunitiesCubit>().fetch(opportunityId, language: lang.localeName),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 80,
                      color: Colors.red[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load opportunity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
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

            if (!snapshot.hasData) {
              return const Center(
                child: Text('No opportunity data available'),
              );
            }

            final opportunity = snapshot.data!;
            return _buildOpportunityDetails(context, opportunity);
          },
        ),
      ),
    );
  }

  Widget _buildOpportunityDetails(BuildContext context, Opportunity opportunity) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  MyColors.primaryColor.withValues(alpha: 0.1),
                  MyColors.primaryColor.withValues(alpha: 0.05),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Organization Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.business,
                    color: MyColors.primaryColor,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Title
                Text(
                  opportunity.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Organization
                Text(
                  opportunity.organization.name,
                  style: TextStyle(
                    fontSize: 16,
                    color: MyColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Key Info Row
                Row(
                  children: [
                    _buildInfoChip(
                      Icons.location_on,
                      opportunity.locationDescription ?? 'Location ID: ${opportunity.locationId}',
                    ),
                    const SizedBox(width: 12),
                    _buildInfoChip(
                      Icons.access_time,
                      '${opportunity.duration} days',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                if (opportunity.isFeatured)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange[300]!),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.orange[700], size: 16),
                        const SizedBox(width: 4),
                        Text(
                          'Featured',
                          style: TextStyle(
                            color: Colors.orange[700],
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          // Content Sections
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                _buildSection(
                  'About This Opportunity',
                  opportunity.description,
                ),
                
                if (opportunity.aboutTheRole != null) ...[
                  const SizedBox(height: 24),
                  _buildSection(
                    'About The Role',
                    opportunity.aboutTheRole!,
                  ),
                ],
                
                // Key Responsibilities
                if (opportunity.keyResponsibilities.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildListSection(
                    'Key Responsibilities',
                    opportunity.keyResponsibilities,
                    Icons.check_circle_outline,
                  ),
                ],
                
                // Required Skills
                if (opportunity.requiredSkills.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildListSection(
                    'Required Skills',
                    opportunity.requiredSkills,
                    Icons.star_outline,
                  ),
                ],
                
                // Time Commitment
                if (opportunity.timeCommitment.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildListSection(
                    'Time Commitment',
                    opportunity.timeCommitment,
                    Icons.schedule,
                  ),
                ],
                
                // Benefits
                if (opportunity.benefits.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildListSection(
                    'Benefits',
                    opportunity.benefits,
                    Icons.card_giftcard,
                  ),
                ],
                
                // Tags
                // if (opportunity.tags.isNotEmpty) ...[
                //   const SizedBox(height: 24),
                //   _buildTagsSection(opportunity.tagsList),
                // ],
                
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
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
    );
  }

  Widget _buildListSection(String title, List<String> items, IconData icon) {
    return Column(
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
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 16,
                color: MyColors.primaryColor,
              ),
              const SizedBox(width: 8),
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
        )),
      ],
    );
  }

  Widget _buildTagsSection(List<String> tags) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tags',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((tag) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: MyColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: MyColors.primaryColor.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              tag,
              style: TextStyle(
                fontSize: 12,
                color: MyColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }
}

extension OpportunitiesCubitExtension on OpportunitiesCubit {
  Future<Opportunity> fetch(String id, {String language = 'en'}) async {
    final repository = sl<OpportunitiesRepository>();
    return await repository.fetch(id, language: language);
  }
}
