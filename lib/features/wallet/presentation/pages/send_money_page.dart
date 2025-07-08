import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/send_money_cubit.dart';

class SendMoneyPage extends StatelessWidget {
  final SendMoneyCubit? cubit;

  const SendMoneyPage({super.key, this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SendMoneyCubit>.value(
      value: cubit ?? SendMoneyCubit(),
      child: SendMoneyBody(),
    );
  }
}

class SendMoneyBody extends StatefulWidget {
  @override
  State<SendMoneyBody> createState() => _SendMoneyBodyState();
}

class _SendMoneyBodyState extends State<SendMoneyBody> {
  final TextEditingController _controller = TextEditingController();

  void _showBottomSheet(String message, bool isSuccess) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Wrap(
          children: [
            Center(
              child: Column(
                children: [
                  Icon(
                    isSuccess ? Icons.check_circle : Icons.error,
                    color: isSuccess ? Colors.green : Colors.red,
                    size: 48,
                  ),
                  SizedBox(height: 12),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).then((_) {
      if (isSuccess) Navigator.pop(context);
    });

    if (isSuccess) {
      Future.delayed(Duration(seconds: 2), () {
        if (Navigator.canPop(context)) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Send Money Page'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<SendMoneyCubit, SendMoneyState>(
          listener: (context, state) {
            if (state.status == SendStatus.success ||
                state.status == SendStatus.error) {
              _showBottomSheet(state.message, state.status == SendStatus.success);
            }
          },
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 💸 Amount Card
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.attach_money, size: 48, color: Colors.teal),
                        SizedBox(height: 12),
                        Text(
                          'Enter Amount',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            hintText: '₱0.00',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // ✅ Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      icon: state.status == SendStatus.loading
                          ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : Icon(Icons.send),
                      label: Text(state.status == SendStatus.loading ? '' : 'Send Money'),
                      onPressed: state.status == SendStatus.loading
                          ? null
                          : () {
                        final amount = double.tryParse(_controller.text) ?? 0.0;
                        context.read<SendMoneyCubit>().sendMoney(amount);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}