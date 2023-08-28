import 'package:flutter/material.dart';
import 'package:shop/models/on_boarding_model.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
      title: 'On Board 1 Title',
      image: 'assets/images/onboard_1.jpg',
      body: 'On Board 1 Body',
    ),
    OnBoardingModel(
      title: 'On Board 2 Title',
      image: 'assets/images/onboard_1.jpg',
      body: 'On Board 2 Body',
    ),
    OnBoardingModel(
      title: 'On Board 3 Title',
      image: 'assets/images/onboard_1.jpg',
      body: 'On Board 3 Body',
    ),
  ];
  var onBoardingController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: onSubmit,
            text: 'SKIP',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: onBoardingController,
                onPageChanged: (index) {
                  if (index == onBoardingList.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(onBoardingList[index]),
                itemCount: onBoardingList.length,
              ),
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: onBoardingController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: onBoardingList.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      onSubmit();
                    } else {
                      onBoardingController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void onSubmit() {
    CacheHelper.setData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        navigateAndFinish(context, const LoginScreen());
      }
    });
  }

  Widget buildBoardingItem(OnBoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage(model.image))),
          const SizedBox(height: 15.0),
          Text(model.title, style: const TextStyle(fontSize: 20.0)),
          const SizedBox(height: 15.0),
          Text(model.body, style: const TextStyle(fontSize: 15.0)),
          const SizedBox(height: 15.0),
        ],
      );
}
