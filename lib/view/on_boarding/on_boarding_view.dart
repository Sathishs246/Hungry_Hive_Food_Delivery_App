import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/color_extension.dart';
import '../../common_widget/round_button.dart';
import '../main_tabview/main_tabview.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _controller = PageController();
  int _selectedPage = 0;

  final List<Map<String, String>> _pages = [
    {
      "title": "Find Food You Love",
      "subtitle":
          "Discover the best foods from over 2000\nrestaurants and fast delivery to your doorstep",
      "image": "assets/images/on_boarding_1.png",
    },
    {
      "title": "Fast Delivery",
      "subtitle": "Fast food delivery to your home, office\nwherever you are",
      "image": "assets/images/on_boarding_2.png",
    },
    {
      "title": "Live Tracking",
      "subtitle":
          "Real time tracking of your food on the app\nonce you placed order",
      "image": "assets/images/on_boarding_3.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _selectedPage = _controller.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPage(Map<String, String> data, Size media) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            child: Image.asset(
              data["image"]!,
              width: media.width * 0.7,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: 1,
            child: Text(
              data["title"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: TColor.primaryText,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: 1,
            child: Text(
              data["subtitle"]!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: TColor.secondaryText,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int index) {
    bool isActive = index == _selectedPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: isActive ? 24 : 10,
      decoration: BoxDecoration(
        color: isActive ? TColor.primary : TColor.placeholder,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: TColor.bgColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _buildPage(_pages[index], media);
            },
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, _buildIndicator),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: RoundButton(
              title:
                  _selectedPage == _pages.length - 1 ? "Get Started" : "Next",
              onPressed: () {
                if (_selectedPage == _pages.length - 1) {
                  Get.offAll(() => const MainTabview());
                } else {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
