import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:sendmoney/features/wallet/domain/entities/transaction.dart';
import 'package:sendmoney/features/wallet/presentation/pages/wallet_page.dart';
import 'package:sendmoney/features/wallet/presentation/pages/send_money_page.dart';
import 'package:sendmoney/features/wallet/presentation/pages/transactions_page.dart';
import 'package:sendmoney/features/wallet/presentation/bloc/wallet_cubit.dart';
import 'package:sendmoney/features/wallet/presentation/bloc/transaction_cubit.dart';
import 'package:sendmoney/features/wallet/presentation/bloc/transaction_state.dart';
import 'package:sendmoney/features/wallet/presentation/bloc/send_money_cubit.dart';


// Mocks
class MockWalletCubit extends Mock implements WalletCubit {}
class MockTransactionCubit extends Mock implements TransactionCubit {}
class MockSendMoneyCubit extends Mock implements SendMoneyCubit {}

// Fallbacks
class FakeTransactionState extends Fake implements TransactionState {}
class FakeSendMoneyState extends Fake implements SendMoneyState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeTransactionState());
    registerFallbackValue(FakeSendMoneyState());
  });

  group('WalletPage', () {
    testWidgets('renders balance and buttons', (WidgetTester tester) async {
      final walletCubit = MockWalletCubit();
      when(() => walletCubit.state).thenReturn(500.0);
      when(() => walletCubit.stream).thenAnswer((_) => const Stream<double>.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<WalletCubit>.value(
            value: walletCubit,
            child: WalletPage(),
          ),
        ),
      );

      expect(find.textContaining('₱500.00'), findsOneWidget);
      expect(find.text('Send Money'), findsOneWidget);
      expect(find.text('Transactions'), findsOneWidget);
    });
  });

  group('SendMoneyPage', () {
    testWidgets('submits amount and shows loading/success', (WidgetTester tester) async {
      final sendMoneyCubit = MockSendMoneyCubit();

      when(() => sendMoneyCubit.state).thenReturn(SendMoneyState.initial());
      when(() => sendMoneyCubit.stream)
          .thenAnswer((_) => Stream.value(SendMoneyState.initial()));
      when(() => sendMoneyCubit.sendMoney(any())).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: SendMoneyPage(cubit: sendMoneyCubit), //  pass mock here
        ),
      );

      await tester.enterText(find.byType(TextField), '100');
      await tester.tap(find.text('Send Money'));
      await tester.pumpAndSettle();

      verify(() => sendMoneyCubit.sendMoney(100.0)).called(1);
    });
  });

  group('TransactionsPage', () {
    testWidgets('renders list of transactions', (WidgetTester tester) async {
      final transactionCubit = MockTransactionCubit();
      final txList = [
        Transaction(id: 1, title: 'A', body: 'body', amount: 100),
        Transaction(id: 2, title: 'B', body: 'body', amount: 250),
      ];

      when(() => transactionCubit.state).thenReturn(TransactionLoaded(txList));
      when(() => transactionCubit.stream).thenAnswer((_) => Stream.value(TransactionLoaded(txList)));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<TransactionCubit>.value(
            value: transactionCubit,
            child: const TransactionsPage(),
          ),
        ),
      );

      expect(find.textContaining('₱100.00'), findsOneWidget);
      expect(find.textContaining('₱250.00'), findsOneWidget);
    });

    testWidgets('shows loading indicator', (WidgetTester tester) async {
      final transactionCubit = MockTransactionCubit();
      when(() => transactionCubit.state).thenReturn(TransactionLoading());
      when(() => transactionCubit.stream).thenAnswer((_) => Stream.value(TransactionLoading()));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<TransactionCubit>.value(
            value: transactionCubit,
            child: const TransactionsPage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message', (WidgetTester tester) async {
      final transactionCubit = MockTransactionCubit();
      const errorMessage = 'Failed';
      when(() => transactionCubit.state).thenReturn(TransactionError(errorMessage));
      when(() => transactionCubit.stream).thenAnswer((_) => Stream.value(TransactionError(errorMessage)));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<TransactionCubit>.value(
            value: transactionCubit,
            child: const TransactionsPage(),
          ),
        ),
      );

      expect(find.text(errorMessage), findsOneWidget);
    });
  });
}