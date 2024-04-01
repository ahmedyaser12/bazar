import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/screens/author_details_screen/ui/author_details_screen.dart';
import 'package:book_shop/screens/home/UI/widget/auther_widget.dart';
import 'package:book_shop/screens/home/UI/widget/swiper_widget.dart';
import 'package:book_shop/screens/home/UI/widget/top_of_week.dart';
import 'package:book_shop/screens/home/data/top_author_model.dart';
import 'package:book_shop/screens/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../core/utils/common_functions.dart';
import '../../../core/utils/styles.dart';
import '../../../core/widget/custom_appBar.dart';
import '../../onboarding_screen/Ui/widget/dots_indicator_widget.dart';
import '../data/top_book_of_weak_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TopWeakModel> topWeakList = [];
  List<TopAuthorsModel> authorsList = [];

  @override
  void initState() {
    context.read<HomeCubit>().topBookWeak == null
        ? context.read<HomeCubit>().getTopWeakBook()
        : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is FailureRequest) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                icon: const Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 32,
                ),
                content: Text(
                  state.error,
                  style: TextStyles.font16PrimarySemi,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(
                      'Got it',
                      style: TextStyles.font16PrimarySemi,
                    ),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ListTopWeakLoaded) {
            topWeakList = state.topWeakList;
            authorsList = state.topAuthorsList;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomAppBar(
                      title: 'Home',
                      leading: const Icon(Icons.search).onTap(() {
                        context.navigateTo(RouteName.SEARCH);
                      }),
                      color: AppColors.whiteColor,
                      iconThemeData: IconThemeData(
                        color: AppColors.blackColor,
                      ),
                      action: [
                        IconButton(
                            onPressed: () {
                              //FirebaseAuth.instance.signOut();
                              print('List$authorsList');
                            },
                            icon:
                                SvgPicture.asset('assets/svgs/Notification.svg')
                                    .onTap(() {
                              print(MediaQuery.of(context).size.width);
                            }))
                      ],
                    ),
                    SizedBox(
                      height: context.heightPercent(25),
                      child: Swiper(
                        onIndexChanged: (value) {
                          setState(() {
                            context.read<HomeCubit>().currentSwiperIndex =
                                value;
                          });
                        },
                        itemCount: 3,
                        itemBuilder: (_, index) {
                          return const ContentCard();
                        },
                      ),
                    ),
                    heightSpace(5),
                    Center(
                      child: DotsIndicatorWidget(
                          currentIndex:
                              context.read<HomeCubit>().currentSwiperIndex),
                    ),
                    SizedBox(
                      height: context.heightPercent(38),
                      child: TopOfWeekWidget(
                        topWeakList: topWeakList,
                      ),
                    ),
                    //heightSpace(10),
                    SizedBox(
                      height: context.heightPercent(30),
                      child: AuthorWidget(
                        authorsList: authorsList,
                        onTab: (authorsModel) {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => DraggableScrollableSheet(
                              initialChildSize: 0.4,
                              // 40% of screen height
                              minChildSize: 0.2,
                              // 20% of screen height
                              maxChildSize: 1.0,
                              expand: false,
                              //Full screen
                              builder: (context, scrollController) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      )),
                                  child: AuthorDetailsScreen(scrollController,
                                      authorId: authorsModel!.authorId!),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      // bottomNavigationBar: const BottomNavBar(),
    );
  }
}
