import '../repositories/wallet_repository.dart';

class SendMoney {
  final WalletRepository repo;

  SendMoney(this.repo);

  Future<void> call(double amount) => repo.sendMoney(amount);
}