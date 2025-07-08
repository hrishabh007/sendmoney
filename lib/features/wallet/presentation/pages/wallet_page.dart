import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sendmoney/features/wallet/presentation/pages/send_money_page.dart';
import 'package:sendmoney/features/wallet/presentation/pages/transactions_page.dart';
import 'package:sendmoney/features/wallet/presentation/bloc/transaction_cubit.dart';
import 'package:sendmoney/features/wallet/presentation/bloc/wallet_cubit.dart';
import 'package:sendmoney/features/wallet/presentation/bloc/transaction_state.dart';

import 'package:sendmoney/features/wallet/domain/usecases/get_transactions.dart';
import 'package:sendmoney/features/wallet/data/datasources/wallet_remote_datasource.dart';

import 'package:sendmoney/core/network/api_client.dart';

import '../../data/respositories/wallet_repository_impl.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WalletCubit(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('My Wallet'),
          backgroundColor: Colors.teal,
        ),
        body: WalletBody(),
      ),
    );
  }
}

class WalletBody extends StatefulWidget {
  @override
  State<WalletBody> createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> {
  bool hidden = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, double>(
      builder: (context, balance) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // 💰 Balance Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal, Colors.tealAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wallet Balance',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hidden ? '******' : '₱${balance.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              hidden ? Icons.visibility_off : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () => setState(() => hidden = !hidden),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // 🚀 Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.teal,
                        ),
                        icon: Icon(Icons.send),
                        label: Text('Send Money'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SendMoneyPage()),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.blueGrey,
                        ),
                        icon: Icon(Icons.history),
                        label: Text('Transactions'),
                        onPressed: () {
                          final getTransactions = GetTransactions(
                            WalletRepositoryImpl(
                              WalletRemoteDataSource(ApiClient()),
                            ),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (_) =>
                                TransactionCubit(getTransactions)..fetchTransactions(),
                                child: TransactionsPage(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}