import 'package:flutter/material.dart';
import 'package:food_delivery_service/screens/location/location_screen.dart';
import 'package:food_delivery_service/widgets/dot_indicator.dart';
import 'package:food_delivery_service/widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  static const String routeName = '/on-boarding';

  static Route route() {
    return MaterialPageRoute(
        builder: ((_) => OnboardingScreen()),
        settings: RouteSettings(name: routeName));
  }

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            Expanded(
                flex: 14,
                child: PageView.builder(
                    itemCount: demoData.length,
                    onPageChanged: ((value) {
                      setState(() {
                        currentPage = value;
                      });
                    }),
                    itemBuilder: (context, index) => OnboardingContent(
                          illustration: demoData[index]["illustration"],
                          title: demoData[index]["title"],
                          subtitle: demoData[index]["text"],
                        ))),
            Spacer(),
            //dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(demoData.length,
                  (index) => DotIndicator(isActive: index == currentPage)),
            ),
            Spacer(
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                 style: ElevatedButton.styleFrom(fixedSize: Size(350, 40)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'GET STARTED',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  )),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}

// Demo data for our Onboarding screen
List<Map<String, dynamic>> demoData = [
  {
    "illustration": "assets/illustrations/Illustrations_1.svg",
    "title": "All your favorites",
    "text":
        "Order from the best local restaurants \nwith easy, on-demand delivery.",
  },
  {
    "illustration": "assets/illustrations/Illustrations_2.svg",
    "title": "Free delivery offers",
    "text":
        "Free delivery for new customers via Apple Pay\nand others payment methods.",
  },
  {
    "illustration": "assets/illustrations/Illustrations_3.svg",
    "title": "Choose your food",
    "text":
        "Easily find your type of food craving and\nyou’ll get delivery in wide range.",
  },
];
