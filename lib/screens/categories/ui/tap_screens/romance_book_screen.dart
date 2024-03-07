import 'package:book_shop/core/widget/build_book.dart';
import 'package:book_shop/screens/categories/logic/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RomanceBooksScreen extends StatefulWidget {
  const RomanceBooksScreen({super.key});

  @override
  State<RomanceBooksScreen> createState() => _RomanceBooksScreenState();
}

class _RomanceBooksScreenState extends State<RomanceBooksScreen> {
  @override

  void initState() {
    context.read<CategoriesCubit>().romanceList.isEmpty
        ? context.read<CategoriesCubit>().getCategory('romance')
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
        final romanceList = context.read<CategoriesCubit>().romanceList;
        return Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .75,
              mainAxisSpacing: .5,
              crossAxisSpacing: .5,
            ),
            itemBuilder: (ctx, index) {
              return BuildBook(categoryList: romanceList[index]);
            },
            itemCount: romanceList.length,
          ),
        );
      },
    );
  }
}
