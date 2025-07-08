

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_remote_datasource.dart';
import '../models/transaction_model.dart';
class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource dataSource;

  WalletRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> sendMoney(double amount) async {
    try {
      await dataSource.sendMoney(amount);
      return Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions() async {
    try {
      final List<TransactionModel> models = await dataSource.fetchTransactions();

      final transactions = models.map((m) => Transaction(
        id: m.id,
        title: m.title,
        body: m.body,
        amount: m.amount,
      )).toList();

      return Right(transactions);

    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}