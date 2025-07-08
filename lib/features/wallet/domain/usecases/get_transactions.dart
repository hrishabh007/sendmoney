import 'package:dartz/dartz.dart';


import '../../../../core/error/failures.dart';
import '../entities/transaction.dart';
import '../repositories/wallet_repository.dart';

class GetTransactions {
  final WalletRepository repo;

  GetTransactions(this.repo);

  Future<Either<Failure, List<Transaction>>> call() {
    return repo.getTransactions();
  }
}