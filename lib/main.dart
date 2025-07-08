import 'package:flutter/material.dart';

import 'features/wallet/presentation/pages/wallet_page.dart';



void main() {
  runApp(SendMoneyApp());
}

class SendMoneyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Money App',
      home: WalletPage(),
    );
  }
}