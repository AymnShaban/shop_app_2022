import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashe_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.body, required this.title, required this.image});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'https://assets4.lottiefiles.com/packages/lf20_9aaqrsgf.json',
      body: 'I am very happy that you have downloaded my program  ',
      title: 'how are you ',
    ),
    BoardingModel(
      image: 'https://assets9.lottiefiles.com/packages/lf20_5ngs2ksb.json',
      body: 'You can easily order your products from here ',
      title: 'are yoe ready ',
    ),
    BoardingModel(
      image: 'https://assets9.lottiefiles.com/packages/lf20_TMRZ23.json',
      body: 'Let\'s get started by logging in',
      title: 'are you excited',
    ),
  ];
  bool isLast = false;
  void submit(){
    CasheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value) {
        myNavigator2(context: context, Widget: LoginScreen());
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: const Text(
                'SKIP',
                style: TextStyle(
                  fontFamily: 'Qq',
                  fontSize: 30,
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
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
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.deepOrange),
                    count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: 200,
              child: Lottie.network(model.image, width: 300, height: 300),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            model.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black54),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Aas',
                color: Colors.black54),
          ),
          const SizedBox(
            height: 45,
          ),
        ],
      );
}
