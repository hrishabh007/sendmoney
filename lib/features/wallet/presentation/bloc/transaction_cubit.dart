import 'package:flutter_bloc/flutter_bloc.dart';


import '../../domain/usecases/get_transactions.dart';
import 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetTransactions getTransactions;

  TransactionCubit(this.getTransactions) : super(TransactionInitial());

  Future<void> fetchTransactions() async {
    emit(TransactionLoading());

    final result = await getTransactions();

    result.fold(
          (failure) => emit(TransactionError(failure.message)),
          (transactions) => emit(TransactionLoaded(transactions)),
    );
  }
}