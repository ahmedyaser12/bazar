import 'package:book_shop/core/widget/build_book.dart';
import 'package:book_shop/screens/categories/logic/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({super.key});

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  @override
  void initState() {
    context.read<CategoriesCubit>().allCategoryList.isEmpty
        ? context.read<CategoriesCubit>().getCategory('all')
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is LoadingList) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final allCategoryList = context.read<CategoriesCubit>().allCategoryList;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .65,
            mainAxisSpacing: 0.5,
            crossAxisSpacing: .5,
          ),
          itemBuilder: (ctx, index) {
            return BuildBook(categoryList: allCategoryList[0]);
          },
          itemCount: allCategoryList.length,
        );
      },
    );
  }
}
