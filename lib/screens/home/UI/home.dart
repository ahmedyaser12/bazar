import 'package:book_shop/core/utils/colors.dart';
import 'package:book_shop/screens/home/UI/widget/auther_widget.dart';
import 'package:book_shop/screens/home/UI/widget/swiper_widget.dart';
import 'package:book_shop/screens/home/UI/widget/top_of_week.dart';
import 'package:book_shop/screens/home/logic/home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../core/utils/common_functions.dart';
import '../../../core/widget/custom_appBar.dart';
import '../../onboarding_screen/Ui/widget/dots_indicator_widget.dart';
import '../data/model.dart';

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

  @override
  void initState() {
    context.read<HomeCubit>().getTopWeakBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is LoadingList) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ListTopWeakLoaded) {
            topWeakList = state.topWeakList;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
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
                              FirebaseAuth.instance.signOut();
                            },
                            icon: SvgPicture.asset(
                                'assets/svgs/Notification.svg'))
                      ],
                    ),
                    SizedBox(
                      height: 210,
                      child: Swiper(
                        onIndexChanged: (value) {
                          context.read<HomeCubit>().currentSwiperNum(value);
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
                        height: 340,
                        child: TopOfWeekWidget(
                          topWeakList: topWeakList,
                        )),
                    heightSpace(20),
                    const SizedBox(height: 250, child: AuthorWidget())
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
