import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../bloc/billing_bloc.dart';
import '../bloc/billing_bloc_parts.dart';
import '../../../../core/theme/app_theme.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BillingBloc>().add(BillingLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF9),
      appBar: AppBar(
        title: Text(
          "Billing & Invoices",
          style: GoogleFonts.outfit(
            color: AppTheme.deepTeal,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: AppTheme.deepTeal),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<BillingBloc, BillingState>(
        listener: (context, state) {
          if (state.status == BillingStatus.actionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Action completed successfully!")),
            );
          } else if (state.status == BillingStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? "An error occurred")),
            );
          }
        },
        builder: (context, state) {
          if (state.status == BillingStatus.loading && state.invoices.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<BillingBloc>().add(BillingLoadRequested());
            },
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                _buildStatsGrid(state),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
                _buildInvoicesList(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsGrid(BillingState state) {
    final stats = state.stats;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
        ),
        delegate: SliverChildListDelegate([
          _buildStatCard(
            title: "Total Paid",
            amount: "\$${stats?.totalPaid.toStringAsFixed(2) ?? "0.00"}",
            icon: LucideIcons.checkCircle2,
            color: Colors.green,
          ),
          _buildStatCard(
            title: "Pending",
            amount: "\$${stats?.totalPending.toStringAsFixed(2) ?? "0.00"}",
            icon: LucideIcons.clock,
            color: Colors.amber,
          ),
        ]),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String amount,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amount,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.deepTeal,
                ),
              ),
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 10,
                  color: AppTheme.deepTeal.withOpacity(0.4),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInvoicesList(BillingState state) {
    if (state.invoices.isEmpty && state.status == BillingStatus.success) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.receipt,
                size: 64,
                color: AppTheme.deepTeal.withOpacity(0.1),
              ),
              const SizedBox(height: 16),
              Text(
                "No Invoices Found",
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.deepTeal.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final invoice = state.invoices[index];
          return _buildInvoiceItem(invoice);
        }, childCount: state.invoices.length),
      ),
    );
  }

  Widget _buildInvoiceItem(dynamic invoice) {
    final statusColor = _getStatusColor(invoice.status);
    final statusIcon = _getStatusIcon(invoice.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(statusIcon, color: statusColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.description,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.deepTeal,
                  ),
                ),
                Text(
                  "Due ${invoice.dueDate.substring(0, 10)}",
                  style: GoogleFonts.outfit(
                    fontSize: 12,
                    color: AppTheme.deepTeal.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "\$${invoice.amount.toStringAsFixed(2)}",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.deepTeal,
                ),
              ),
              if (invoice.status == 'pending')
                TextButton(
                  onPressed: () => context.read<BillingBloc>().add(
                    BillingPayInvoiceRequested(invoice.id),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Pay Now",
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.mintGreen,
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    invoice.status.toUpperCase(),
                    style: GoogleFonts.outfit(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'canceled':
        return Colors.grey;
      case 'overdue':
        return Colors.red;
      default:
        return AppTheme.deepTeal;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'paid':
        return LucideIcons.checkCircle2;
      case 'pending':
        return LucideIcons.clock;
      case 'canceled':
        return LucideIcons.xCircle;
      case 'overdue':
        return LucideIcons.alertCircle;
      default:
        return LucideIcons.receipt;
    }
  }
}
