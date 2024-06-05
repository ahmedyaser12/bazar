import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/core/utils/extintions.dart';
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
  final int bookId;

  const BookDetailsScreen({
    this.scrollController,
    super.key,
    required this.bookId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<BookDetailsCubit>(),
      child: BookDetails(
        scrollController,
        bookId: bookId,
      ),
    );
  }
}

class BookDetails extends StatefulWidget {
  final ScrollController? scrollController;
  final int bookId;

  const BookDetails(
    this.scrollController, {
    super.key,
    required this.bookId,
  });

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  void initState() {
    super.initState();
    context.read<BookDetailsCubit>().getCartItems();
    context.read<BookDetailsCubit>().getBookDetailed(widget.bookId);
    context.read<BookDetailsCubit>().getProductCounterNumber();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: BlocBuilder<BookDetailsCubit, BookDetailsState>(
        buildWhen: (previous, current) => current is DetailsLoaded,
        builder: (context, state) {
          if (state is DetailsLoaded) {
            var bookDetails = state.bookDetails;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Image.network(
                    bookDetails.image.toString(),
                    scale: .3,
                  ),
                ),
                heightSpace(10),
                TitleAndFavourite(bookDetails: bookDetails),
                heightSpace(24),
                ReadMoreText(
                  bookDetails.synopsis.toString(),
                  numLines: 4,
                  readMoreText: 'Read more',
                  readLessText: 'Read less',
                  style: TextStyles.font16grey(context),
                ),
                heightSpace(20),
                ReviewWidget(bookDetails: bookDetails),
                heightSpace(24),
                BlocConsumer<BookDetailsCubit, BookDetailsState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color.fromARGB(255, 40, 40, 54)
                                    : AppColors.lightGery,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const CounterButtons(),
                            ),
                            widthSpace(16),
                            Text(
                              '\$${int.parse(bookDetails.id.toString().substring(0, 2))}',
                              style: TextStyles.font16PrimarySemi,
                            ),
                          ],
                        ),
                        heightSpace(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: context.read<BookDetailsCubit>().isExist
                                  ? 360
                                  : 0,
                              height: 50,
                              child: context.read<BookDetailsCubit>().isExist
                                  ? secondaryButton(context, 'View Cart').onTap(
                                      () {
                                        context
                                            .navigateTo(RouteName.CART)
                                            .then((value) async {
                                          await context
                                              .read<BookDetailsCubit>()
                                              .checkBookIsExist();
                                          context
                                              .read<BookDetailsCubit>()
                                              .getProductCounterNumber();
                                        });
                                      },
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: context.read<BookDetailsCubit>().isExist
                                  ? 0
                                  : 360,
                              height: 50,
                              child: state is AddToCard
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : primaryButton(
                                      title: 'Continue shopping',
                                      borderRadius: 50,
                                    ).onTap(() {
                                      context
                                          .read<BookDetailsCubit>()
                                          .addToCard();
                                    }),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
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
