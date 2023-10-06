import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:To_Know_Me/layout/cubit/cubit.dart';
import 'package:To_Know_Me/layout/cubit/states.dart';
import 'package:To_Know_Me/shared/components/components.dart';

class OnBoardingPage extends StatelessWidget {
  final pages = [
    buildIntroductionPage(
      colorContainer: Colors.white,
      urlImage: "assets/images/m1.gif",
      subTitle: "stay connected to the world and know more people",
      colorSubTitle: Colors.grey,
    ),
    buildIntroductionPage(
      colorContainer: Color(0xff00B75D),
      urlImage: "assets/images/m2.gif",
      subTitle:
          "To Know Me  it helps you meet people Similar to you in the field of work , hobbies and ideas",
      colorSubTitle: Colors.black,
    ),
    buildIntroductionPage(
      colorContainer: Color(0xff044AC1),
      urlImage: "assets/images/m3.gif",
      subTitle:
          "Not Only that , but you can contact them to find out more details about each other",
      colorSubTitle: Colors.white,
      isLast: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        int currentIndex = SocialCubit.get(context).currentIntroductionIndex;
        return Scaffold(
          body: LiquidSwipe(
            pages: pages,
            enableLoop: false,
            fullTransitionValue: 300.0,
            enableSideReveal: true,
            slideIconWidget: Icon(
              currentIndex == pages.length - 1
                  ? null
                  : Icons.arrow_back_ios,
              size: 30.0,
              color: Colors.white,
            ),
            positionSlideIcon: 0.5,
            onPageChangeCallback: (index) {
              cubit.changeIntroductionPageIndex(index);
              if (index == pages.length - 1)
                cubit.changeIntroductionPage(true);
              else
                cubit.changeIntroductionPage(false);
            },
          ),
          bottomNavigationBar: cubit.isLastIntroductionPage
              ? defaultElevatedButton(
                  // text: "Get Started",
                  text: "Let's go",
                  backgroundColorButton: Colors.blueAccent.withOpacity(0.85),
                  function: () => cubit.navigateLogin(context),
                )
              : defaultElevatedButton(
                  text: "To Know Me",
                  colorText: currentIndex == 0 ? Colors.black : Colors.white,
                  backgroundColorButton: currentIndex == 0
                      ? Colors.grey.withOpacity(0.15)
                      : currentIndex == 1
                          ? Colors.green.withOpacity(0.85)
                          : Colors.transparent,
                  function: null,
                ),
        );
      },
    );
  }
}
