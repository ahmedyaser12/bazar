import 'package:book_shop/screens/payment_screen/logic/payment_cubit.dart';
import 'package:book_shop/screens/status_order_screen/logic/status_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';
import '../../../services/services_locator.dart';

class StatusOrder extends StatefulWidget {
  const StatusOrder({super.key});

  @override
  State<StatusOrder> createState() => _StatusOrderState();
}

class _StatusOrderState extends State<StatusOrder> {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Background color of the screen
      appBar: AppBar(
        title: const Text('Order Status'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () {},
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
              return Screenshot(
                controller: screenshotController,
                child: Container(
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
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
                        _buildSummaryLine(
                            'Subtotal', '\$${order['totalPrice']}'),
                        _buildSummaryLine('Shipping', '\$2.00'),
                        const Divider(),
                        _buildSummaryLine(
                            'Total Payment', '\$${order['totalPrice'] + 2.00}',
                            isTotal: true),
                        _buildSummaryLine(
                          'Delivery in',
                          "(${context.read<StatusScreenCubit>().getDayLeft(order)}Left)  ${order['deliveryDate']}",
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
                        BlocProvider(
                          create: (context) => locator<PaymentCubit>(),
                          child: BlocBuilder<PaymentCubit, PaymentState>(
                            builder: (context, state) {
                              return Image.asset(
                                  context.read<PaymentCubit>().paymentName !=
                                          'paymob'
                                      ? 'assets/images/paypal.png'
                                      : 'assets/images/paymob.png');
                            },
                          ),
                        )
                      ],
                    ),
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

// Future<void> _takeScreenshot() async {
//   final directory = await getApplicationDocumentsDirectory();
//   String imagePath = path.join(directory.path, 'screenshot.png');
//   String pdfPath = path.join(directory.path, 'screenshot.pdf');
//
//   // Capture the screenshot
//   screenshotController.capture().then((image) async {
//     if (image != null) {
//       // Save image to local storage
//       File(imagePath).writeAsBytesSync(image);
//
//       // Convert image to PDF
//       final pdf = pw.Document();
//       final imageMemory = pw.MemoryImage(image);
//
//       pdf.addPage(pw.Page(build: (pw.Context context) {
//         return pw.Center(child: pw.Image(imageMemory));
//       }));
//
//       // Save PDF to local storage
//       final pdfFile = File(pdfPath);
//       await pdfFile.writeAsBytes(await pdf.save());
//
//       // Optionally: Open the PDF
//       Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
//
//       // Show a dialog or toast to indicate success
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Screenshot saved as PDF: $pdfPath')),
//       );
//     }
//   }).catchError((onError) {
//     print(onError);
//   });
// }
}
