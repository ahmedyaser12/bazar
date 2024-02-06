import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/styles.dart';
import 'package:book_shop/core/widget/app_buttons.dart';
import 'package:book_shop/screens/book_detailes_screen/logic/book_details_cubit.dart';
import 'package:book_shop/screens/book_detailes_screen/ui/widget/counter_button.dart';
import 'package:book_shop/screens/book_detailes_screen/ui/widget/review_widget.dart';
import 'package:book_shop/screens/book_detailes_screen/ui/widget/title_and_favourit.dart';
import 'package:book_shop/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_more_text/read_more_text.dart';

class BookDetailsScreen extends StatelessWidget {
  final ScrollController? scrollController;

  const BookDetailsScreen(
    this.scrollController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<BookDetailsCubit>(),
      child: BookDetails(
        scrollController,
      ),
    );
  }
}

class BookDetails extends StatelessWidget {
  final ScrollController? scrollController;

  const BookDetails(
    this.scrollController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: BlocBuilder<BookDetailsCubit, BookDetailsState>(
        builder: (context, state) {
          if (state is GetId) {
            print('idbookscreen${state.id}');
            context.read<BookDetailsCubit>().getBookDetailed(state.id);
          }
          if (state is DetailsLoaded) {
            var bookDetails = state.bookDetails;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                    child: Image.network(
                  bookDetails.cover.toString(),
                  scale: .3,
                )),
                heightSpace(10),
                TitleAndFavourite(bookDetails: bookDetails),
                heightSpace(24),
                ReadMoreText(
                  bookDetails.synopsis.toString(),
                  numLines: 4,
                  readMoreText: 'Read more',
                  readLessText: 'Read less',
                  style: TextStyles.font16grey,
                ),
                heightSpace(20),
                ReviewWidget(bookDetails: bookDetails),
                heightSpace(24),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.lightGery,
                          borderRadius: BorderRadius.circular(8)),
                      child: const CounterButtons(),
                    ),
                    widthSpace(16),
                    Text(
                      '\$39.99',
                      style: TextStyles.font16PrimarySemi,
                    ),
                  ],
                ),
                heightSpace(10),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: primaryButton(
                          title: 'Continue shopping', borderRadius: 50),
                    ),
                    widthSpace(10),
                    Expanded(
                      flex: 1,
                      child: secondaryButton('View Card'),
                    )
                  ],
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
