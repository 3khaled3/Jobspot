import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jobs_fantastic/core/const/app_colors.dart';
import 'package:jobs_fantastic/core/const/app_text_styles.dart';
import 'package:jobs_fantastic/core/const/assets.dart';
import 'package:jobs_fantastic/core/extension/sized_box_extension.dart';
import 'package:jobs_fantastic/app/home/view/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Give the animation time to play, plus a beat to let the brand register.
    await Future.delayed(const Duration(milliseconds: 1800));

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const HomeView(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.logo, width: 60, height: 60),
            4.hSpace,
            Text(
              'Jobspot',
              style: AppTextStyles.bold26.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
