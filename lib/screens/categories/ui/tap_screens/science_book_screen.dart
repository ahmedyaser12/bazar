import 'package:book_shop/core/widget/build_book.dart';
import 'package:book_shop/screens/categories/logic/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScienceBooksScreen extends StatefulWidget {
  const ScienceBooksScreen({super.key});

  @override
  State<ScienceBooksScreen> createState() => _ScienceBooksScreenState();
}

class _ScienceBooksScreenState extends State<ScienceBooksScreen> {
  @override
  void initState() {
    context.read<CategoriesCubit>().scienceList.isEmpty
        ? context.read<CategoriesCubit>().getCategory('science')
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
        final scienceList = context.read<CategoriesCubit>().scienceList;
        return Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .75,
              mainAxisSpacing: .5,
              crossAxisSpacing: .5,
            ),
            itemBuilder: (ctx, index) {
              return BuildBook(categoryList: scienceList[index]);
            },
            itemCount: scienceList.length,
          ),
        );
      },
    );
  }
}
