import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:levpay_mobile/core/theme/app_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../presentation/bloc/admin_bloc.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(AdminDashboardRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            color: AppColors.deepTeal,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: AppColors.deepTeal),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.users, color: AppColors.deepTeal),
            onPressed: () {
              // Navigate to User List - For now just refresh or show snackbar
              // implementing full separate screen might be next step or integrated here
            },
          ),
        ],
      ),
      body: BlocBuilder<AdminBloc, AdminState>(
        builder: (context, state) {
          if (state is AdminLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.mintGreen),
            );
          } else if (state is AdminError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is AdminDashboardLoaded) {
            final stats = state.stats;
            final userCount = stats['system']?['total_users'] ?? 0;
            final walletCount = stats['system']?['total_wallets'] ?? 0;
            final pendingKyc = stats['system']?['kyc_pending'] ?? 0;
            final volume = stats['transaction']?['total_volume'] ?? 0;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.deepTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _buildStatCard(
                        'Users',
                        '$userCount',
                        LucideIcons.user,
                        Colors.blue,
                      ),
                      _buildStatCard(
                        'Wallets',
                        '$walletCount',
                        LucideIcons.wallet,
                        Colors.purple,
                      ),
                      _buildStatCard(
                        'Pending KYC',
                        '$pendingKyc',
                        LucideIcons.shieldAlert,
                        Colors.orange,
                      ),
                      _buildStatCard(
                        'Volume',
                        '\$${volume.toStringAsFixed(0)}',
                        LucideIcons.dollarSign,
                        Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Future: Recent Users List
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.mintGreen.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.mintGreen.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.deepTeal,
                ),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepTeal.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
