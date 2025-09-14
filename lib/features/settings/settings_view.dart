import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ngo/core/constant/app_assets.dart';
import 'package:ngo/export_tools.dart';
import 'package:ngo/features/support_ticket/support_ticket_view.dart';

import '../../core/theme/my_colors.dart';
import '../../core/theme/my_fonts.dart';
import '../../l10n/locale/cubit/locale_cubit.dart';
import '../../service_locator.dart';
import '../auth/cubit/auth_cubit.dart';
import '../components/text_component.dart';
import '../edit_proflie/edit_profile_view.dart';
import '../splash/splash.dart';
import '../static_page_features/about.dart';
import '../user_management/cubit/user_management_cubit.dart';
import 'change_password_section.dart';

class SettingsView extends HookWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UserManagementCubit>()..fetchUserPreferences(),
      child: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                AppLocalizations.of(context)!.settings,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            body: CustomScrollView(
              slivers: [
                // Account Section
                SliverToBoxAdapter(
                  child: _buildSection(
                    title: AppLocalizations.of(context)!.account,
                    items: [
                      _buildSettingsItem(
                        assetName: AppIconsSettings.profileSettings,
                        title: AppLocalizations.of(context)!.edit_profile,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileView(),
                            ),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        assetName: AppIconsSettings.change,
                        title: AppLocalizations.of(context)!.change_password,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordSection(),
                            ),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        assetName: AppIconsSettings.deleteAccount,
                        title: AppLocalizations.of(context)!.deactivate_account,
                        titleColor: Colors.red,
                        onTap: () {
                          // Handle deactivate account
                        },
                      ),
                    ],
                  ),
                ),

                // Notifications Section
                SliverToBoxAdapter(
                  child: _buildSection(
                    title: AppLocalizations.of(context)!.notifications,
                    items: [
                      _buildToggleItem(
                        assetName: AppIconsSettings.push,
                        title: AppLocalizations.of(context)!.push_notifications,
                        value:
                            (state.runtimeType.toString().contains('Loaded') &&
                                (state as dynamic).preferences != null)
                            ? (state as dynamic).preferences!.pushNotifications
                            : true,
                        onChanged: (value) {
                          final currentPrefs =
                              (state.runtimeType.toString().contains(
                                    'Loaded',
                                  ) &&
                                  (state as dynamic).preferences != null)
                              ? (state as dynamic).preferences!
                              : null;

                          final updateData = <String, dynamic>{
                            'pushNotifications': value,
                            'emailNotifications':
                                currentPrefs?.emailNotifications ?? false,
                            'language': currentPrefs?.language ?? 'en',
                          };

                          // Remove null values
                          updateData.removeWhere((key, value) => value == null);

                          context.read<UserManagementCubit>().updatePreferences(
                            updateData,
                          );
                        },
                      ),
                      _buildToggleItem(
                        assetName: AppIconsSettings.email,

                        title: AppLocalizations.of(
                          context,
                        )!.email_notifications,
                        value:
                            (state.runtimeType.toString().contains('Loaded') &&
                                (state as dynamic).preferences != null)
                            ? (state as dynamic).preferences!.emailNotifications
                            : false,
                        onChanged: (value) {
                          final currentPrefs =
                              (state.runtimeType.toString().contains(
                                    'Loaded',
                                  ) &&
                                  (state as dynamic).preferences != null)
                              ? (state as dynamic).preferences!
                              : null;

                          final updateData = <String, dynamic>{
                            'emailNotifications': value,
                            'pushNotifications':
                                currentPrefs?.pushNotifications ?? true,
                            'language': currentPrefs?.language ?? 'en',
                          };

                          // Remove null values
                          updateData.removeWhere((key, value) => value == null);

                          context.read<UserManagementCubit>().updatePreferences(
                            updateData,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Privacy Section
                SliverToBoxAdapter(
                  child: _buildSection(
                    title: AppLocalizations.of(context)!.privacy,
                    items: [
                      _buildToggleItem(
                        assetName: AppIconsSettings.visibility,
                        title: AppLocalizations.of(context)!.profile_visibility,
                        value:
                            (state.runtimeType.toString().contains('Loaded') &&
                                (state as dynamic).preferences != null)
                            ? ((state as dynamic).preferences!.profileVisibility ?? 'public') == 'public'
                            : true, // Default to public (true)
                        onChanged: (value) {
                          // Temporary: Only allow setting to public due to API limitations
                          if (!value) {
                            // Show dialog explaining the limitation
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Feature Not Available'),
                                content: Text('Private profile visibility is not currently supported by the server. Please contact support for more information.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }

                          final currentPrefs =
                              (state.runtimeType.toString().contains(
                                    'Loaded',
                                  ) &&
                                  (state as dynamic).preferences != null)
                              ? (state as dynamic).preferences!
                              : null;

                          final updateData = <String, dynamic>{
                            'profileVisibility': 'public', // Only send public for now
                            'emailNotifications':
                                currentPrefs?.emailNotifications ?? false,
                            'pushNotifications':
                                currentPrefs?.pushNotifications ?? true,
                            'language': currentPrefs?.language ?? 'en',
                          };

                          // Remove null values
                          updateData.removeWhere((key, value) => value == null);

                          context.read<UserManagementCubit>().updatePreferences(
                            updateData,
                          );
                        },
                      ),
                      _buildSettingsItem(
                        assetName: AppIconsSettings.dataManagement,

                        title: AppLocalizations.of(context)!.data_management,
                        onTap: () {
                          // Handle data management
                        },
                      ),
                    ],
                  ),
                ),

                // General Section
                SliverToBoxAdapter(
                  child: _buildSection(
                    title: AppLocalizations.of(context)!.general,
                    items: [
                      BlocBuilder<LocaleCubit, LocaleState>(
                        bloc: LocaleCubit(),
                        builder: (context, localeState) {
                          final languageText =
                              localeState is LocaleSetSuccess &&
                                  localeState.isArabic
                              ? 'العربية'
                              : 'English';

                          return _buildSettingsItem(
                            assetName: AppIconsSettings.language,

                            title: AppLocalizations.of(context)!.language,
                            trailing: languageText,
                            onTap: () {
                              _showLanguageDialog(context);
                            },
                          );
                        },
                      ),

                      _buildSettingsItem(
                        assetName: AppIconsSettings.helpCenter,

                        title: AppLocalizations.of(context)!.help_center,
                        onTap: () {
                          // Handle help center
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SupportTicketView(),
                            ),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        assetName: AppIconsSettings.report,

                        title: AppLocalizations.of(context)!.report_problem,
                        onTap: () {
                          // Handle report problem
                        },
                      ),
                      _buildSettingsItem(
                        assetName: AppIconsSettings.aboutApp,

                        title: AppLocalizations.of(context)!.about_app,
                        trailing: '1.0.0',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutSection(),
                            ),
                          );
                          // Handle about app
                        },
                      ),
                    ],
                  ),
                ),

                // Log Out Section
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    child: _buildLogoutItem(context),
                  ),
                ),

                // Bottom padding
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Column(children: items),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required String assetName,
    required String title,
    String? trailing,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(assetName, width: 28, height: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: titleColor ?? Colors.black87,
                ),
              ),
            ),
            if (trailing != null) ...[
              Text(
                trailing,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(width: 8),
            ],
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required String assetName,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]!, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(assetName, width: 28, height: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
          Theme(
            data: ThemeData(
              switchTheme: SwitchThemeData(
                
                thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.selected)) {
                    return Colors.white;
                  }
                  return Colors.white;
                }),
                trackColor: MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.selected)) {
                    return MyColors.primaryColor;
                  }
                  
                  return Colors.grey[300]!;
                }),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                // splashRadius: 0,
                // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            child: Switch(
              value: value,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutItem(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle logout
        _showLogoutDialog(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Icon(Icons.logout, size: 24, color: Colors.red),
            SizedBox(width: 12),
            Text(
              AppLocalizations.of(context)!.logout,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    final userManagementCubit = context.read<UserManagementCubit>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: LocaleCubit(),
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)!.language),
            content: SizedBox(
              width: double.maxFinite,
              child: _buildLanguageSelector(
                context,
                dialogContext,
                userManagementCubit,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageSelector(
    BuildContext context,
    BuildContext dialogContext,
    UserManagementCubit userManagementCubit,
  ) {
    var lang = AppLocalizations.of(context)!;
    var cubit = context.read<LocaleCubit>();

    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        final isEnglish = state is LocaleSetSuccess && state.isEnglish;
        final isArabic = state is LocaleSetSuccess && state.isArabic;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                onPressed: isEnglish
                    ? null
                    : () {
                        cubit.switchLanguage();
                        _updateUserLanguagePreference(
                          userManagementCubit,
                          'en',
                        );
                        Navigator.of(dialogContext).pop();
                      },
                child: TextComponent(
                  title: lang.english,
                  style: MyFonts.font14BlackBold.copyWith(
                    color: isEnglish
                        ? MyColors.primaryColor
                        : MyColors.borderColor,
                  ),
                ),
              ),
            ),
            Container(
              height: 20,
              width: 1,
              color: MyColors.darkGrayColor,
              margin: const EdgeInsets.symmetric(horizontal: 10),
            ),
            Expanded(
              child: TextButton(
                onPressed: isArabic
                    ? null
                    : () {
                        cubit.switchLanguage();
                        _updateUserLanguagePreference(
                          userManagementCubit,
                          'ar',
                        );
                        Navigator.of(dialogContext).pop();
                      },
                child: TextComponent(
                  title: lang.arabic,
                  style: MyFonts.font14BlackBold.copyWith(
                    color: isArabic
                        ? MyColors.primaryColor
                        : MyColors.borderColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateUserLanguagePreference(
    UserManagementCubit userManagementCubit,
    String languageCode,
  ) {
    final currentState = userManagementCubit.state;
    final currentPrefs =
        (currentState.runtimeType.toString().contains('Loaded') &&
            (currentState as dynamic).preferences != null)
        ? (currentState as dynamic).preferences!
        : null;

    final updateData = <String, dynamic>{
      'language': languageCode,
      'emailNotifications': currentPrefs?.emailNotifications ?? false,
      'pushNotifications': currentPrefs?.pushNotifications ?? true,
    };

    // Remove null values
    updateData.removeWhere((key, value) => value == null);

    userManagementCubit.updatePreferences(updateData);
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return BlocProvider.value(
          value: sl<AuthCubit>(),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              final stateType = state.runtimeType.toString();
              if (stateType.contains('Unauthenticated')) {
                // Close dialog first
                Navigator.of(dialogContext).pop();
                // Navigate to splash screen and remove all routes
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Splash()),
                  (route) => false,
                );
              } else if (stateType.contains('LogoutError')) {
                // Close dialog and show error
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logout failed. Please try again.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                final stateType = state.runtimeType.toString();
                final isLoggingOut = stateType.contains('LoggingOut');

                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.logout),
                  content: isLoggingOut
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            SizedBox(width: 16),
                            Text(AppLocalizations.of(context)!.logging_out),
                          ],
                        )
                      : Text(AppLocalizations.of(context)!.are_you_sure_logout),
                  actions: isLoggingOut
                      ? []
                      : [
                          TextButton(
                            onPressed: () {
                              Navigator.of(dialogContext).pop();
                            },
                            child: Text(AppLocalizations.of(context)!.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              final authCubit = context.read<AuthCubit>();
                              authCubit.logout();
                            },
                            child: Text(AppLocalizations.of(context)!.logout),
                          ),
                        ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
