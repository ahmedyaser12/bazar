import 'package:book_shop/config/routs/routs_names.dart';
import 'package:book_shop/core/cubits/local_cubit/localization.dart';
import 'package:book_shop/core/utils/extintions.dart';
import 'package:book_shop/screens/author_details_screen/ui/author_details_screen.dart';
import 'package:book_shop/screens/home/UI/widget/auther_widget.dart';
import 'package:book_shop/screens/home/UI/widget/shimmer.dart';
import 'package:book_shop/screens/home/UI/widget/swiper_widget.dart';
import 'package:book_shop/screens/home/UI/widget/top_of_week.dart';
import 'package:book_shop/screens/home/data/top_author_model.dart';
import 'package:book_shop/screens/home/logic/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../core/cubits/cubit_theme/theme_cubit.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/styles.dart';
import '../../../core/widget/custom_appBar.dart';
import '../../../generated/l10n.dart';
import '../../onboarding_screen/Ui/widget/dots_indicator_widget.dart';
import '../data/top_book_of_weak_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _swiperOffsetAnimation;
  late List<Animation<Offset>> _topOfWeekAnimations;
  late List<Animation<Offset>> _authorAnimations;
  bool isAnimated = false;

  List<TopWeakModel> topWeakList = [];
  List<TopAuthorsModel> authorsList = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1700),
      vsync: this,
    );

    // Trigger data load
    if (context.read<HomeCubit>().topBookWeak.isEmpty ||
        context.read<HomeCubit>().topAuthors.isEmpty) {
      context.read<HomeCubit>().getTopWeakBook();
    }
  }

  void _setupAnimations() {
    _swiperOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _topOfWeekAnimations = List<Animation<Offset>>.generate(10, (index) {
      return Tween<Offset>(
        begin: index == 0 ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    });

    _authorAnimations = List<Animation<Offset>>.generate(5, (index) {
      return Tween<Offset>(
        begin:
            index % 2 == 0 ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    });
    _controller.forward();
    setState(() {
      isAnimated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(
        context: context,
        title: S.of(context).title,
        leading: const Icon(Icons.search).onTap(() {
          context.navigateTo(RouteName.SEARCH);
        }),
        action: [
          IconButton(
            onPressed: () {
              context.read<LocaleCubit>().toggleLocale();
            },
            icon: SvgPicture.asset(
              'assets/svgs/Notification.svg',
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.whiteColor
                  : AppColors.darkBlue,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.brightness_6,
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.whiteColor
                  : AppColors.darkBlue,
            ),
            onPressed: () => context.read<ThemeCubit>().toggleTheme(),
          ),
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listenWhen: (previous, current) => current is ListTopWeakLoaded,
        buildWhen: (previous, current) => current is ListTopWeakLoaded,
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
          if (state is ListTopWeakLoaded && !isAnimated) {
            _setupAnimations();
          }
        },
        builder: (context, state) {
          if (state is LoadingList) {
            return const Shammer();
          }
          if (state is ListTopWeakLoaded) {
            topWeakList = state.topWeakList;
            authorsList = state.topAuthorsList;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isAnimated
                        ? SlideTransition(
                            position: _swiperOffsetAnimation,
                            child: SizedBox(
                              height: context.heightPercent(20),
                              child: Swiper(
                                onIndexChanged: (value) {
                                  setState(() {
                                    context
                                        .read<HomeCubit>()
                                        .currentSwiperIndex = value;
                                  });
                                },
                                itemCount: 3,
                                itemBuilder: (_, index) {
                                  return const ContentCard();
                                },
                              ),
                            ),
                          )
                        : SizedBox(
                            height: context.heightPercent(20),
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
                    SizedBox(
                      height: context.heightPercent(3),
                      child: Center(
                        child: DotsIndicatorWidget(
                            currentIndex:
                                context.read<HomeCubit>().currentSwiperIndex),
                      ),
                    ),
                    isAnimated
                        ? SizedBox(
                            height: context.heightPercent(37),
                            child: TopOfWeekWidget(
                              position: _topOfWeekAnimations,
                              topWeakList: topWeakList,
                            ),
                          )
                        : SizedBox(
                            height: context.heightPercent(37),
                            child: TopOfWeekWidget(
                              position: null,
                              topWeakList: topWeakList,
                            ),
                          ),
                    isAnimated
                        ? SizedBox(
                            height: context.heightPercent(30),
                            child: AuthorWidget(
                              position: _authorAnimations,
                              authorsList: authorsList,
                              onTab: (authorsModel) {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) =>
                                      DraggableScrollableSheet(
                                    initialChildSize: 0.4,
                                    minChildSize: 0.2,
                                    maxChildSize: 1.0,
                                    expand: false,
                                    builder: (context, scrollController) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? AppColors.darkBlue
                                                    : AppColors.whiteColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            )),
                                        child: AuthorDetailsScreen(
                                            scrollController,
                                            authorId: authorsModel!.authorId!),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        : SizedBox(
                            height: context.heightPercent(30),
                            child: AuthorWidget(
                              position: null,
                              authorsList: authorsList,
                              onTab: (authorsModel) {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) =>
                                      DraggableScrollableSheet(
                                    initialChildSize: 0.4,
                                    minChildSize: 0.2,
                                    maxChildSize: 1.0,
                                    expand: false,
                                    builder: (context, scrollController) {
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? AppColors.darkBlue
                                                    : AppColors.whiteColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            )),
                                        child: AuthorDetailsScreen(
                                            scrollController,
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
            return Container();
          }
        },
      ),
      // bottomNavigationBar: const BottomNavBar(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
