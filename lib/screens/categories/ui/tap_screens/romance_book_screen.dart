import 'package:book_shop/core/widget/build_book.dart';
import 'package:book_shop/screens/categories/logic/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

class RomanceBooksScreen extends StatefulWidget {
  const RomanceBooksScreen({super.key});

  @override
  State<RomanceBooksScreen> createState() => _RomanceBooksScreenState();
}

class _RomanceBooksScreenState extends State<RomanceBooksScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().romanceList.isEmpty
        ? context.read<CategoriesCubit>().getCategory('romance')
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CategoriesCubit, CategoriesState, Tuple2<bool, List>>(
      selector: (state) {
        final isLoading = state is LoadingList;
        final romanceList = context.read<CategoriesCubit>().romanceList;
        return Tuple2(isLoading, romanceList);
      },
      builder: (context, tuple) {
        final isLoading = tuple.item1;
        final romanceList = tuple.item2;

        if (tuple.item2.isEmpty) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
        }

        double screenWidth = MediaQuery.of(context).size.width;
        int crossAxisCount = screenWidth < 600 ? 2 : screenWidth < 900 ? 3 : 4;
        double aspectRatio = screenWidth < 400 ? 0.65 : 0.75;

        return Center(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: aspectRatio,
              mainAxisSpacing: 0.5,
              crossAxisSpacing: 0.5,
            ),
            itemBuilder: (ctx, index) {
              return Center(child: BuildBook(categoryList: romanceList[index]));
            },
            itemCount: romanceList.length,
          ),
        );
      },
    );
  }
}
