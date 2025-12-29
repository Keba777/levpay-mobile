import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../bloc/send_money_bloc.dart';
import '../bloc/send_money_event.dart';
import '../bloc/send_money_state.dart';
import '../bloc/wallet_bloc.dart';
import '../bloc/wallet_state.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendMoneyBloc, SendMoneyState>(
      listener: (context, state) {
        if (state.status == SendMoneyStatus.success) {
          // Success handled in UI or via navigation
        }
        if (state.status == SendMoneyStatus.failure && state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFFBFFE4),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF3D8D7A)),
              onPressed: () {
                if (state.status == SendMoneyStatus.initial ||
                    state.status == SendMoneyStatus.success) {
                  context.pop();
                } else {
                  context.read<SendMoneyBloc>().add(SendMoneyReset());
                }
              },
            ),
            title: Text(
              _getTitle(state.status),
              style: GoogleFonts.outfit(
                color: const Color(0xFF3D8D7A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  String _getTitle(SendMoneyStatus status) {
    switch (status) {
      case SendMoneyStatus.initial:
      case SendMoneyStatus.searching:
        return "Send Money";
      case SendMoneyStatus.recipientSelected:
      case SendMoneyStatus.amountEntering:
        return "Enter Amount";
      case SendMoneyStatus.reviewing:
        return "Review Transfer";
      case SendMoneyStatus.success:
        return "Success";
      default:
        return "Send Money";
    }
  }

  Widget _buildBody(BuildContext context, SendMoneyState state) {
    switch (state.status) {
      case SendMoneyStatus.initial:
      case SendMoneyStatus.searching:
        return _buildSearchStep(context, state);
      case SendMoneyStatus.recipientSelected:
      case SendMoneyStatus.amountEntering:
        return _buildAmountStep(context, state);
      case SendMoneyStatus.reviewing:
      case SendMoneyStatus.processing:
        return _buildReviewStep(context, state);
      case SendMoneyStatus.success:
        return _buildSuccessStep(context, state);
      case SendMoneyStatus.failure:
        return _buildSearchStep(
          context,
          state,
        ); // Fallback to search or previous
    }
  }

  Widget _buildSearchStep(BuildContext context, SendMoneyState state) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Who is the recipient?",
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF3D8D7A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Search by name, email, or username",
            style: GoogleFonts.outfit(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _searchController,
            onChanged: (value) {
              context.read<SendMoneyBloc>().add(
                SendMoneySearchRequested(value),
              );
            },
            decoration: InputDecoration(
              hintText: "Search people...",
              prefixIcon: const Icon(Icons.search, color: Color(0xFF3D8D7A)),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(20),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: state.status == SendMoneyStatus.searching
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: state.searchResults.length,
                    itemBuilder: (context, index) {
                      final user = state.searchResults[index];
                      return ListTile(
                        onTap: () {
                          context.read<SendMoneyBloc>().add(
                            SendMoneyRecipientSelected(user),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundImage: user.avatarUrl != null
                              ? NetworkImage(user.avatarUrl!)
                              : null,
                          backgroundColor: const Color(0xFFB3D8A8),
                          child: user.avatarUrl == null
                              ? Text(user.firstName[0])
                              : null,
                        ),
                        title: Text(
                          "${user.firstName} ${user.lastName}",
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          "@${user.username ?? 'user'}",
                          style: GoogleFonts.outfit(fontSize: 12),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Color(0xFF3D8D7A),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountStep(BuildContext context, SendMoneyState state) {
    final walletState = context.read<WalletBloc>().state;
    double currentBalance = 0.0;
    String currency = "USD";
    if (walletState is WalletDashboardLoaded) {
      currentBalance = walletState.balance.balance;
      currency = walletState.balance.currency;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: state.selectedRecipient?.avatarUrl != null
                      ? NetworkImage(state.selectedRecipient!.avatarUrl!)
                      : null,
                  backgroundColor: const Color(0xFFB3D8A8),
                  child: state.selectedRecipient?.avatarUrl == null
                      ? Text(state.selectedRecipient?.firstName[0] ?? "?")
                      : null,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${state.selectedRecipient?.firstName} ${state.selectedRecipient?.lastName}",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      state.selectedRecipient?.email ?? "",
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            "Amount to Send",
            style: GoogleFonts.outfit(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                currency,
                style: GoogleFonts.outfit(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "0.00",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Balance: $currency ${currentBalance.toStringAsFixed(2)}",
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 48),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              hintText: "Add a note (Optional)",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(_amountController.text) ?? 0.0;
              if (amount > 0 && amount <= currentBalance) {
                context.read<SendMoneyBloc>().add(
                  SendMoneyAmountEntered(
                    amount: amount,
                    description: _descriptionController.text,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3D8D7A),
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              "Review Transfer",
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewStep(BuildContext context, SendMoneyState state) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "You are sending",
                  style: GoogleFonts.outfit(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                Text(
                  "\$${state.amount.toStringAsFixed(2)}",
                  style: GoogleFonts.outfit(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF3D8D7A),
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
                _buildReviewRow(
                  "Recipient",
                  "${state.selectedRecipient?.firstName} ${state.selectedRecipient?.lastName}",
                ),
                _buildReviewRow("Fee", "FREE"),
                _buildReviewRow(
                  "Total",
                  "\$${state.amount.toStringAsFixed(2)}",
                ),
                if (state.description?.isNotEmpty ?? false) ...[
                  const SizedBox(height: 16),
                  Text(
                    "Note: \"${state.description}\"",
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: state.status == SendMoneyStatus.processing
                ? null
                : () {
                    context.read<SendMoneyBloc>().add(SendMoneyConfirmed());
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3D8D7A),
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: state.status == SendMoneyStatus.processing
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    "Send Now",
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.outfit(color: Colors.grey)),
          Text(value, style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSuccessStep(BuildContext context, SendMoneyState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 24),
            Text(
              "Money Sent!",
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3D8D7A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "You've successfully sent \$${state.amount.toStringAsFixed(2)} to ${state.selectedRecipient?.firstName}.",
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D8D7A),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "Back to Home",
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
