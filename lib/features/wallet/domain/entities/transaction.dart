class Transaction {
  final int id;
  final String title;
  final String body;
  final double amount;

  Transaction({
    required this.id,
    required this.title,
    required this.body,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      amount: (json['id'] * 10).toDouble(), // simulated amount
    );
  }
}