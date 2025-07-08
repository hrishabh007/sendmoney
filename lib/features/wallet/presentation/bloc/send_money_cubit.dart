import 'package:flutter_bloc/flutter_bloc.dart';

enum SendStatus { initial, loading, success, error }

class SendMoneyState {
  final SendStatus status;
  final String message;

  SendMoneyState({required this.status, this.message = ''});

  factory SendMoneyState.initial() => SendMoneyState(status: SendStatus.initial);
}

class SendMoneyCubit extends Cubit<SendMoneyState> {
  SendMoneyCubit() : super(SendMoneyState.initial());

  Future<void> sendMoney(double amount) async {
    emit(SendMoneyState(status: SendStatus.loading));

    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    if (amount > 0) {
      emit(SendMoneyState(
        status: SendStatus.success,
        message: 'Sent ₱${amount.toStringAsFixed(2)} successfully!',
      ));
    } else {
      emit(SendMoneyState(
        status: SendStatus.error,
        message: 'Invalid amount entered.',
      ));
    }
  }

  void reset() => emit(SendMoneyState.initial());
}