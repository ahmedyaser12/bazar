import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/screens/home/UI/widget/auther_widget.dart';
import 'package:book_shop/screens/home/UI/widget/swiper_widget.dart';
import 'package:book_shop/screens/home/UI/widget/top_of_week.dart';
import 'package:book_shop/screens/home/data/top_author_model.dart';
import 'package:book_shop/screens/home/logic/home_cubit.dart';
import 'package:book_shop/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../core/utils/common_functions.dart';
import '../../../core/utils/styles.dart';
import '../../../core/widget/custom_appBar.dart';
import '../../onboarding_screen/Ui/widget/dots_indicator_widget.dart';
import '../data/top_book_of_weak_model.dart';

class HomeScreen extends StatefulWidget {
  //final User user;

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
    context.read<HomeCubit>().getTopWeakBook();
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
                padding: EdgeInsets.symmetric(horizontal: 24.0.w,vertical: 24.0.h),
                child: Column(
                  children: [
                    CustomAppBar(
                      title: 'Home',
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
                            icon: SvgPicture.asset(
                                'assets/svgs/Notification.svg').onTap((){
                                  firebaseAuth.signOut();
                            }))
                      ],
                    ),
                    SizedBox(
                      height: 210.h,
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
                        height: 340.h,
                        child: TopOfWeekWidget(
                          topWeakList: topWeakList,
                        )),
                    heightSpace(10),
                    SizedBox(
                      height: 250.h,
                      child: AuthorWidget(authorsList: authorsList),
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
    );
  }
}
