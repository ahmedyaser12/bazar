import 'package:book_shop/core/widget/build_book.dart';
import 'package:book_shop/screens/categories/logic/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionBooksScreen extends StatefulWidget {
  const ActionBooksScreen({super.key});

  @override
  State<ActionBooksScreen> createState() => _ActionBooksScreenState();
}

class _ActionBooksScreenState extends State<ActionBooksScreen> {
  @override
  void initState() {
    context.read<CategoriesCubit>().actionList.isEmpty
        ? context.read<CategoriesCubit>().getCategory('action')
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
        final actionList = context.read<CategoriesCubit>().actionList;
        return Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .75,
              mainAxisSpacing: .5,
              crossAxisSpacing: .5,
            ),
            itemBuilder: (ctx, index) {
              return BuildBook(categoryList: actionList[index]);
            },
            itemCount: actionList.length,
          ),
        );
      },
    );
  }
}
