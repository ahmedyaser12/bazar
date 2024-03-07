import 'package:book_shop/core/widget/build_book.dart';
import 'package:book_shop/screens/categories/logic/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HorrorBooksScreen extends StatefulWidget {
  const HorrorBooksScreen({super.key});

  @override
  State<HorrorBooksScreen> createState() => _HorrorBooksScreenState();
}

class _HorrorBooksScreenState extends State<HorrorBooksScreen> {
  @override
  void initState() {
    context.read<CategoriesCubit>().horrorList.isEmpty
        ? context.read<CategoriesCubit>().getCategory('horror')
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
        final horrorList = context.read<CategoriesCubit>().horrorList;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .75,
            mainAxisSpacing: .5,
            crossAxisSpacing: .5,
          ),
          itemBuilder: (ctx, index) {
            return BuildBook(categoryList: horrorList[index]);
          },
          itemCount: horrorList.length,
        );
      },
    );
  }
}
