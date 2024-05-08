import 'package:book_shop/core/widget/build_book.dart';
import 'package:book_shop/screens/categories/logic/categories_cubit.dart';
import 'package:book_shop/screens/home/data/top_book_of_weak_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart'; // Add tuple to your dependencies if not already included

class ActionBooksScreen extends StatefulWidget {
  const ActionBooksScreen({super.key});

  @override
  State<ActionBooksScreen> createState() => _ActionBooksScreenState();
}

class _ActionBooksScreenState extends State<ActionBooksScreen> {
  @override
  void initState() {
    super.initState();
    if (context.read<CategoriesCubit>().actionList.isEmpty) {
      context.read<CategoriesCubit>().getCategory('action');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CategoriesCubit, CategoriesState, Tuple2<bool, List<TopWeakModel>>>(
      selector: (state) {
        final isLoading = state is LoadingList;
        final actionList = context.read<CategoriesCubit>().actionList;
        return Tuple2(isLoading, actionList);
      },
      builder: (context, tuple) {
        final isLoading = tuple.item1;
        final actionList = tuple.item2;

        if (tuple.item2.isEmpty) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
        }

        double screenWidth = MediaQuery.of(context).size.width;
        int crossAxisCount = screenWidth < 600 ? 2 : screenWidth < 900 ? 3 : 4;
        double aspectRatio = screenWidth < 400 ? 0.65 : 0.75;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: aspectRatio,
            mainAxisSpacing: 0.5,
            crossAxisSpacing: 0.5,
          ),
          itemBuilder: (ctx, index) {
            return Center(child: BuildBook(categoryList: actionList[index]));
          },
          itemCount: actionList.length,
        );
      },
    );
  }
}
