import 'package:book_shop/core/widget/build_book.dart';
import 'package:book_shop/screens/categories/logic/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({super.key});

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  @override
  void initState() {
    super.initState();
    if (context.read<CategoriesCubit>().allCategoryList.isEmpty) {
      context.read<CategoriesCubit>().getCategory('all');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CategoriesCubit, CategoriesState, Tuple2<bool, List>>(
      selector: (state) {
        final isLoading = state is LoadingList;
        final allCategoryList = context.read<CategoriesCubit>().allCategoryList;
        return Tuple2(isLoading, allCategoryList);
      },
      builder: (context, tuple) {
        final isLoading = tuple.item1;
        final allCategoryList = tuple.item2;

        if (tuple.item2.isEmpty) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
        }

        double screenWidth = MediaQuery.of(context).size.width;
        int crossAxisCount = screenWidth < 600
            ? 2
            : screenWidth < 900
                ? 3
                : 4;
        double aspectRatio = screenWidth < 400 ? 0.65 : 0.75;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: aspectRatio,
            mainAxisSpacing: 0.5,
            crossAxisSpacing: 0.5,
          ),
          itemBuilder: (ctx, index) {
            return Center(
                child: BuildBook(
                    categoryList:
                        allCategoryList[0])); // Corrected to use index
          },
          itemCount: allCategoryList.length,
        );
      },
    );
  }
}
