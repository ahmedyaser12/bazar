import 'package:book_shop/core/utils/common_functions.dart';
import 'package:book_shop/screens/author_details_screen/ui/widget/about_author.dart';
import 'package:book_shop/screens/author_details_screen/ui/widget/author_title_and_image_and_rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/styles.dart';
import '../../../services/services_locator.dart';
import '../logic/author_details_cubit.dart';

class AuthorDetailsScreen extends StatelessWidget {
  final ScrollController? scrollController;
  final int authorId;

  const AuthorDetailsScreen(
    this.scrollController, {
    super.key,
    required this.authorId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<AuthorDetailsCubit>(),
      child: AuthorDetails(
        authorId: authorId,
        scrollController!,
      ),
    );
  }
}

class AuthorDetails extends StatefulWidget {
  final ScrollController scrollController;
  final int authorId;

  const AuthorDetails(this.scrollController,
      {super.key, required this.authorId});

  @override
  State<AuthorDetails> createState() => _AuthorDetailsState();
}

class _AuthorDetailsState extends State<AuthorDetails> {
  @override
  void initState() {
    context.read<AuthorDetailsCubit>().getAuthorDetailed(widget.authorId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: BlocBuilder<AuthorDetailsCubit, AuthorDetailsState>(
        builder: (context, state) {
          if (state is DetailsLoaded) {
            final authorDetails = state.authorDetails;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Author',
                      style: TextStyles.font24BlackBold,
                    ),
                  ],
                ),
                heightSpace(16),
                AuthorTitleAndImageAndRating(authorDetails: authorDetails),
                heightSpace(20),
                AboutAuthor(authorDetails: authorDetails),
                heightSpace(20),
                Text(
                  'Product',
                  style: TextStyles.font15BlackMedium,
                ),
                heightSpace(16),
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 50,
                        mainAxisSpacing: .5,
                        childAspectRatio: 2.5,
                        crossAxisCount: 2,
                      ),
                      children: authorDetails.authorBooks!
                          .map((e) => Column(
                                children: [
                                  Text(
                                    e.name.toString(),
                                    style: TextStyles.font15BlackMedium,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text(e.rating.toString()),
                                    ],
                                  ),
                                ],
                              ))
                          .toList()),
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
