import 'package:flutter_bloc/flutter_bloc.dart';


class WalletCubit extends Cubit<double> {
  WalletCubit() : super(500.00); // Initial balance

  void updateBalance(double amount) => emit(amount);
}