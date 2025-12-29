import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/app_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(ProfileDataRequested());
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (image != null) {
      context.read<ProfileBloc>().add(
        ProfileUpdateRequested(avatar: File(image.path)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.updateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Settings updated successfully!")),
            );
          } else if (state.status == ProfileStatus.updateFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? "Failed to update settings"),
              ),
            );
          }
        },
        builder: (context, state) {
          final user = state.user;
          final settings = state.settings;

          if (state.status == ProfileStatus.loading && user == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(
                    "Settings",
                    style: GoogleFonts.outfit(
                      color: AppTheme.deepTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
                ),
              ),

              // Profile Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppTheme.mintGreen.withOpacity(0.2),
                                  width: 4,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child:
                                    (user?.avatarUrl != null &&
                                        user!.avatarUrl!.isNotEmpty)
                                    ? Image.network(
                                        user.avatarUrl!,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(
                                        color: AppTheme.mintGreen.withOpacity(
                                          0.1,
                                        ),
                                        child: const Icon(
                                          Icons.person,
                                          size: 50,
                                          color: AppTheme.deepTeal,
                                        ),
                                      ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: AppTheme.deepTeal,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "${user?.firstName ?? ''} ${user?.lastName ?? ''}",
                          style: GoogleFonts.outfit(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.deepTeal,
                          ),
                        ),
                        Text(
                          user?.email ?? '',
                          style: GoogleFonts.outfit(
                            fontSize: 14,
                            color: AppTheme.deepTeal.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () {
                            // TODO: Implement Edit Profile modal/screen
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppTheme.mintGreen.withOpacity(0.3),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                          ),
                          child: Text(
                            "Edit Profile",
                            style: GoogleFonts.outfit(
                              color: AppTheme.deepTeal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Settings Categories
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildCategoryHeader("ACCOUNT"),
                    _buildSettingItem(
                      icon: LucideIcons.shield,
                      title: "Security & Privacy",
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.creditCard,
                      title: "Payment Methods",
                      onTap: () => const CardsRoute().push(context),
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.layoutDashboard,
                      title: "Identity Verification",
                      trailing: user?.kycStatus == 'approved'
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 20,
                            )
                          : const Icon(
                              Icons.info_outline,
                              color: Colors.orange,
                              size: 20,
                            ),
                      onTap: () => const KYCRoute().push(context),
                    ),

                    const SizedBox(height: 32),
                    _buildCategoryHeader("PREFERENCES"),
                    _buildSettingItem(
                      icon: LucideIcons.globe,
                      title: "Language",
                      trailing: Text(
                        settings['language']?.toUpperCase() ?? "EN",
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.deepTeal.withOpacity(0.4),
                        ),
                      ),
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.coins,
                      title: "Primary Currency",
                      trailing: Text(
                        settings['currency'] ?? "USD",
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.deepTeal.withOpacity(0.4),
                        ),
                      ),
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.bell,
                      title: "Notifications",
                      onTap: () {},
                    ),

                    const SizedBox(height: 32),
                    _buildCategoryHeader("SUPPORT"),
                    _buildSettingItem(
                      icon: LucideIcons.helpCircle,
                      title: "Help Center",
                      onTap: () {},
                    ),
                    _buildSettingItem(
                      icon: LucideIcons.fileText,
                      title: "Legal & Policies",
                      onTap: () {},
                    ),

                    const SizedBox(height: 32),
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogoutRequested());
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.logout, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            "Sign Out",
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 64),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppTheme.deepTeal.withOpacity(0.3),
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppTheme.mintGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppTheme.deepTeal, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.deepTeal,
                    ),
                  ),
                ),
                if (trailing != null) trailing,
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  color: AppTheme.deepTeal.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
