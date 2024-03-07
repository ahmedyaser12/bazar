import 'package:flutter/material.dart';

import '../../../core/widget/app_buttons.dart';
import 'widget/adress_widget.dart';
import 'widget/date_time_widget.dart';
import 'widget/payment_widget.dart';
import 'widget/summary_widget.dart';

class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Confirm Order'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {
              // TODO: Implement edit action
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const AddressWidget(),
          const SizedBox(height: 16),
          const SummaryWidget(),
          const SizedBox(height: 16),
          const DateTimeWidget(),
          const SizedBox(height: 16),
          const PaymentWidget(),
          const SizedBox(height: 16),
          primaryButton(title: 'Ordered', borderRadius: 50, verticalHeight: 15)
        ],
      ),
    );
  }
}
