import 'dart:io';
import 'dart:typed_data';

import 'package:book_shop/screens/payment_screen/logic/payment_cubit.dart';
import 'package:book_shop/screens/status_order_screen/logic/status_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';
import '../../../services/services_locator.dart';

class StatusOrderScreen extends StatelessWidget {
  const StatusOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<PaymentCubit>(),
      child: const StatusOrder(),
    );
  }
}

class StatusOrder extends StatefulWidget {
  const StatusOrder({super.key});

  @override
  State<StatusOrder> createState() => _StatusOrderState();
}

class _StatusOrderState extends State<StatusOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Background color of the screen
      appBar: AppBar(
        title: const Text('Order Status'),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf, color: AppColors.greyColor),
            onPressed: _generatePdf,
          ),
        ],
      ),
      body: Center(
        child: BlocConsumer<StatusScreenCubit, StatusScreenState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is StatusScreenLoaded) {
              final order = state.response;
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppColors.greyColor,
                    ),
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                          children: List.generate(
                        order['cartItems'].length,
                        (index) => ListTile(
                          title: Text(order['cartItems'][index]['name'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Text(
                              '\$${order['cartItems'][index]['price'] * order['cartItems'][index]['num']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13)),
                          leading: Text(
                            order['cartItems'][index]['num'].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ),
                      )),
                      const Divider(),
                      _buildSummaryLine('Subtotal', '\$${order['totalPrice']}'),
                      _buildSummaryLine('Shipping', '\$2.00'),
                      const Divider(),
                      _buildSummaryLine(
                          'Total Payment', '\$${order['totalPrice'] + 2.00}',
                          isTotal: true),
                      _buildSummaryLine(
                        'Delivery in',
                        "(${context.read<StatusScreenCubit>().getDayLeft(order)} Left) ${order['deliveryDate']}",
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Location: ',
                            style: TextStyles.font15BlackMedium(context)
                                .copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.normal),
                          ),
                          Text(
                            order['location'] != null
                                ? '${order['location']['street'].substring(0, order['location']['street'].length - 11)},\n${order['location']['administrativeArea']}, ${order['location']['country']}'
                                : 'not found',
                            style: TextStyles.font15BlackMedium(context)
                                .copyWith(color: AppColors.blackColor),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Payment:',
                            style: TextStyles.font15BlackMedium(context)
                                .copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      BlocBuilder<PaymentCubit, PaymentState>(
                        builder: (context, state) {
                          return Image.asset(
                              context.read<PaymentCubit>().paymentName !=
                                      'paymob'
                                  ? 'assets/images/paypal.png'
                                  : 'assets/images/paymob.png');
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSummaryLine(String leading, String trailing,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leading,
              style: TextStyle(
                  fontSize: isTotal ? 18 : 15,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: AppColors.blackColor)),
          Text(trailing,
              style: TextStyle(
                  fontSize: isTotal ? 18 : 15,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: isTotal ? AppColors.primary : AppColors.blackColor)),
        ],
      ),
    );
  }

  Future<void> _generatePdf() async {
    print('Generate PDF clicked');
    final state = context.read<StatusScreenCubit>().state;
    if (state is StatusScreenLoaded) {
      print('StatusScreenLoaded state detected');
      final order = state.response;
      final getDay = context.read<StatusScreenCubit>().getDayLeft(order);
      final pdf = pw.Document();

      final imageName = context.read<PaymentCubit>().paymentName;
      final font = await PdfGoogleFonts.amiriRegular();
      final fontBold = await PdfGoogleFonts.amiriBold();
      final imageData = await _getImageFromAssets(
        imageName != 'paymob'
            ? 'assets/images/paypal.png'
            : 'assets/images/paymob.png',
      );

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    width: 1,
                    color: PdfColors.grey,
                  ),
                  color: PdfColors.white,
                  borderRadius: pw.BorderRadius.circular(12),
                ),
                margin: const pw.EdgeInsets.all(16),
                padding: const pw.EdgeInsets.all(16),
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: <pw.Widget>[
                    pw.Column(
                      children: List.generate(
                        order['cartItems'].length,
                        (index) => pw.Container(
                          padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
                          child: pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                index == 0
                                    ? 'Quantity'
                                    : order['cartItems'][index]['num']
                                        .toString(),
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 13,
                                ),
                              ),
                              pw.Text(
                                index == 0
                                    ? 'Product Name:'
                                    : order['cartItems'][index]['name'],
                                style: pw.TextStyle(
                                  font: fontBold,
                                ),
                              ),
                              pw.Text(
                                index == 0
                                    ? 'Price:'
                                    : '\$${order['cartItems'][index]['price'] * order['cartItems'][index]['num']}',
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    pw.Divider(),
                    _buildPdfSummaryLine(
                        'Subtotal', '\$${order['totalPrice']}', font, fontBold),
                    _buildPdfSummaryLine('Shipping', '\$2.00', font, fontBold),
                    pw.Divider(),
                    _buildPdfSummaryLine('Total Payment',
                        '\$${order['totalPrice'] + 2.00}', font, fontBold,
                        isTotal: true),
                    _buildPdfSummaryLine(
                      'Delivery in',
                      "($getDay Left) ${order['deliveryDate']}",
                      font,
                      fontBold,
                    ),
                    pw.Divider(),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Location:',
                          style: pw.TextStyle(
                            font: font,
                            fontWeight: pw.FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                        pw.Text(
                          order['location'] != null
                              ? '${order['location']['street'].substring(0, order['location']['street'].length - 11)},\n${order['location']['administrativeArea']}, ${order['location']['country']}'
                              : 'not found',
                          style: pw.TextStyle(
                            font: font,
                          ),
                          textDirection: pw.TextDirection.rtl, // Add this line
                        ),
                      ],
                    ),
                    pw.Text(
                      'Payment:',
                      style: pw.TextStyle(
                        font: font,
                        fontWeight: pw.FontWeight.normal,
                        fontSize: 15,
                      ),
                    ),
                    pw.Image(pw.MemoryImage(imageData)),
                  ],
                ),
              ),
            );
          },
        ),
      );

      final directory = await getTemporaryDirectory();
      final file = File(path.join(directory.path, 'order_status.pdf'));
      await file.writeAsBytes(await pdf.save());

      print('PDF saved at: ${file.path}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF saved at: ${file.path}')),
      );

      OpenFilex.open(file.path);
    } else {
      print('StatusScreenCubit state is not loaded');
    }
  }

  pw.Widget _buildPdfSummaryLine(
      String leading, String trailing, pw.Font font, pw.Font fontBold,
      {bool isTotal = false}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            leading,
            style: pw.TextStyle(
              fontSize: isTotal ? 18 : 15,
              font: isTotal ? fontBold : font,
              color: PdfColors.black,
            ),
          ),
          pw.Text(
            trailing,
            style: pw.TextStyle(
              fontSize: isTotal ? 18 : 15,
              font: isTotal ? fontBold : font,
              color: isTotal ? PdfColors.blue : PdfColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> _getImageFromAssets(String assetPath) async {
    final byteData = await DefaultAssetBundle.of(context).load(assetPath);
    return byteData.buffer.asUint8List();
  }
}
