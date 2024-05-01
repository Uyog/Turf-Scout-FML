// PaymentPage.dart
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Implement payment logic here
            // After successful payment, you can navigate to a confirmation page
            Navigator.pushNamed(context, '/confirmation');
          },
          child: const Text('Pay Now'),
        ),
      ),
    );
  }
}
