import '../../domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required int id,
    required String title,
    required String body,
    required double amount,
  }) : super(
    id: id,
    title: title,
    body: body,
    amount: amount,
  );

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      amount: (json['id'] * 10).toDouble(), // simulated amount
    );
  }
}