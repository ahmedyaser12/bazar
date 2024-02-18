import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/screens/categories/ui/tap_screens/action_book_screen.dart';
import 'package:book_shop/screens/categories/ui/tap_screens/all_books_screen.dart';
import 'package:book_shop/screens/categories/ui/tap_screens/horror_book_screen.dart';
import 'package:book_shop/screens/categories/ui/tap_screens/romance_book_screen.dart';
import 'package:book_shop/screens/categories/ui/tap_screens/science_book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/colors.dart';

class CategoriesScreens extends StatefulWidget {
  const CategoriesScreens({
    super.key,
  });

  @override
  State<CategoriesScreens> createState() => _TabScreenState();
}

class _TabScreenState extends State<CategoriesScreens>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 5, vsync: this);

    controller.addListener(() {
      setState(() {});
    });
    Future.delayed(Duration.zero);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> pages = <Widget>[
      AllBooksScreen(),
      HorrorBooksScreen(),
      RomanceBooksScreen(),
      ScienceBooksScreen(),
      ActionBooksScreen(),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.search),
        iconTheme: IconThemeData(
          color: AppColors.blackColor,
        ),
        title: const Text('Category'),
        backgroundColor: AppColors.whiteColor,
        actions: [
          IconButton(
              onPressed: () {
                //FirebaseAuth.instance.signOut();
              },
              icon:
                  SvgPicture.asset('assets/svgs/Notification.svg').onTap(() {}))
        ],
        bottom: TabBar(
          controller: controller,

          padding: EdgeInsets.zero,
          isScrollable: true,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: "horror"),
            Tab(text: "romance"),
            Tab(text: 'science'),
            Tab(text: 'Action'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          pages[0],
          pages[1],
          pages[2],
          pages[3],
          pages[4],
        ],
      ),
    );
  }
}
