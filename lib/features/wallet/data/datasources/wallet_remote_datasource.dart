import '../../../../core/network/api_client.dart';

import 'dart:convert';

import '../models/transaction_model.dart';

class WalletRemoteDataSource {
  final ApiClient client;

  WalletRemoteDataSource(this.client);

  Future<List<TransactionModel>> fetchTransactions() async {
    final response = await client.get('/posts'); // Valid test endpoint

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => TransactionModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch transactions (${response.statusCode})");
    }
  }

  Future<void> sendMoney(double amount) async {
    final response = await client.post('/posts', {
      'title': 'Send Money',
      'body': 'Sent ₱$amount',
      'userId': 1, // required by jsonplaceholder
    });

    if (response.statusCode != 201) {
      throw Exception('Failed to send money (Status ${response.statusCode})');
    }
  }
}