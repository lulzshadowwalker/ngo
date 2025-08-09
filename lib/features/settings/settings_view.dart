
import 'package:ngo/export_tools.dart';

import '../../core/theme/my_colors.dart';

class SettingsView extends HookWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final pushNotifications = useState(true);
    final emailNotifications = useState(false);
    final darkMode = useState(true);

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
        title: const Text(
          'Settings',
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
              title: 'Account',
              items: [
                _buildSettingsItem(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  onTap: () {
                    // Handle edit profile
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.lock_outline,
                  title: 'Change Password',
                  onTap: () {
                    // Handle change password
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.warning_outlined,
                  title: 'Deactivate Account',
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
              title: 'Notifications',
              items: [
                _buildToggleItem(
                  icon: Icons.notifications_outlined,
                  title: 'Push Notifications',
                  value: pushNotifications.value,
                  onChanged: (value) {
                    pushNotifications.value = value;
                  },
                ),
                _buildToggleItem(
                  icon: Icons.email_outlined,
                  title: 'Email Notifications',
                  value: emailNotifications.value,
                  onChanged: (value) {
                    emailNotifications.value = value;
                  },
                ),
              ],
            ),
          ),

          // Privacy Section
          SliverToBoxAdapter(
            child: _buildSection(
              title: 'Privacy',
              items: [
                _buildSettingsItem(
                  icon: Icons.visibility_outlined,
                  title: 'Profile Visibility',
                  onTap: () {
                    // Handle profile visibility
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.description_outlined,
                  title: 'Data Management',
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
              title: 'General',
              items: [
                _buildSettingsItem(
                  icon: Icons.translate_outlined,
                  title: 'Language',
                  trailing: 'English',
                  onTap: () {
                    // Handle language selection
                  },
                ),
                _buildToggleItem(
                  icon: Icons.dark_mode_outlined,
                  title: 'Appearance',
                  value: darkMode.value,
                  onChanged: (value) {
                    darkMode.value = value;
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  onTap: () {
                    // Handle help center
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.report_outlined,
                  title: 'Report a Problem',
                  onTap: () {
                    // Handle report problem
                  },
                ),
                _buildSettingsItem(
                  icon: Icons.info_outline,
                  title: 'About App',
                  trailing: '1.0.0',
                  onTap: () {
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
              child: _buildLogoutItem(),
            ),
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> items,
  }) {
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
          Column(
            children: items,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
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
          
          border: Border(
              bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: titleColor ?? Colors.black87,
            ),
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
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[100]!,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.black87,
          ),
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: MyColors.primaryColor,
            activeTrackColor: MyColors.primaryColor.withValues(alpha: 0.3),
            inactiveTrackColor: Colors.grey[300],
            inactiveThumbColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutItem() {
    return InkWell(
      onTap: () {
        // Handle logout
        _showLogoutDialog();
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
          children: const [
            Icon(
              Icons.logout,
              size: 24,
              color: Colors.red,
            ),
            SizedBox(width: 12),
            Text(
              'Log Out',
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

  void _showLogoutDialog() {
    // This would show a logout confirmation dialog
    // Implementation can be added when needed
  }
}
