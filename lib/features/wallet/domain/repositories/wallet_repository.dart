

import 'package:dartz/dartz.dart';

import '../entities/transaction.dart';
import '../entities/transaction.dart';
import '../../../../core/error/failures.dart';

abstract class WalletRepository {
  Future<Either<Failure, void>> sendMoney(double amount);
  Future<Either<Failure, List<Transaction>>> getTransactions();
}