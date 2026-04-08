import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum BackgroundType {
  darkToBright,
  darkToBrightSplash,
  darkToBright2,
  pureBlack,
  pureWhite,
  brightToDark,
  brightToDark2,
  blueToOrange,
  blueToOrange2,
  maintenance
}

class CitadelBackground extends HookWidget {
  final PreferredSizeWidget? appBar;
  final Widget? child;
  final BackgroundType? backgroundType;
  final Widget? bottomNavigationBar;
  final Future<void> Function()? onRefresh;
  final bool showAppBar;

  const CitadelBackground(
      {super.key,
      required this.backgroundType,
      required this.child,
      this.appBar,
      this.bottomNavigationBar,
      this.onRefresh,
      this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    final minHeight =
        ScreenUtil().screenHeight - (appBar != null ? kToolbarHeight + 44 : 0);
    final padding =
        EdgeInsets.only(bottom: 80.h + (onRefresh != null ? 50.h : 0));

    switch (backgroundType) {
      case BackgroundType.darkToBrightSplash:
        return Scaffold(
          backgroundColor: AppColor.mainBlack,
          resizeToAvoidBottomInset: true,
          extendBody: true,
          appBar: appBar,
          body: Container(
            decoration: BoxDecoration(
              gradient: AppColor.darkToBrightGradientSplash,
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      AppColor.bigBlue.withOpacity(0.6), BlendMode.srcIn),
                  image: AssetImage(
                      Assets.images.backgrounds.loginDecorationFrame.path),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter),
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: Container(
                  padding: padding,
                  alignment: Alignment.center,
                  child: child,
                ),
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigationBar != null
              ? SafeArea(child: bottomNavigationBar!)
              : const SizedBox.shrink(),
        );
      case BackgroundType.darkToBright:
        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          backgroundColor: AppColor.mainBlack,
          appBar: appBar,
          body: Container(
            decoration: BoxDecoration(
              gradient: AppColor.darkToBrightGradient,
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      AppColor.bigBlue.withOpacity(0.6), BlendMode.srcIn),
                  image: AssetImage(
                      Assets.images.backgrounds.loginDecorationFrame.path),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter),
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: Container(
                  padding: padding,
                  alignment: Alignment.center,
                  child: child,
                ),
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigationBar != null
              ? SafeArea(child: bottomNavigationBar!)
              : const SizedBox.shrink(),
        );
      case BackgroundType.darkToBright2:
        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          backgroundColor: AppColor.mainBlack,
          appBar: showAppBar ? (appBar ?? const CitadelAppBar()) : null,
          body: Container(
            decoration: BoxDecoration(
              gradient: AppColor.darkToBrightGradient2,
              image: DecorationImage(
                  image: AssetImage(
                    Assets.images.backgrounds.signUpDecorationFrame.path,
                  ),
                  scale: 2.8,
                  alignment: Alignment.bottomRight),
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: Container(
                  padding: padding,
                  child: child,
                ),
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigationBar != null
              ? SafeArea(child: bottomNavigationBar!)
              : const SizedBox.shrink(),
        );
      case BackgroundType.brightToDark:
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.mainBlack,
          extendBody: true,
          body: Container(
            decoration: BoxDecoration(
              gradient: AppColor.brightToDarkGradient,
              image: DecorationImage(
                  image: AssetImage(Assets
                      .images.backgrounds.identificationDecorationFrame.path),
                  scale: 2.8,
                  alignment: Alignment.bottomLeft),
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight + 150.h),
                child: Container(
                  padding: padding,
                  child: Column(
                    children: [
                      appBar ?? const CitadelAppBar(),
                      child ?? const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigationBar != null
              ? SafeArea(child: bottomNavigationBar!)
              : const SizedBox.shrink(),
        );
      case BackgroundType.brightToDark2:
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.mainBlack,
          extendBody: true,
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppColor.brightToDarkGradient2,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: Container(
                  padding: padding,
                  alignment: Alignment.center,
                  child: child,
                ),
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigationBar != null
              ? SafeArea(child: bottomNavigationBar!)
              : const SizedBox.shrink(),
        );
      case BackgroundType.pureBlack:
        final content = Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  Assets.images.backgrounds.signUpDecorationFrame.path,
                ),
                scale: 2.5,
                alignment: Alignment.bottomRight),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: Container(
                padding: padding,
                child: child,
              ),
            ),
          ),
        );

        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          backgroundColor: AppColor.mainBlack,
          appBar: showAppBar ? appBar ?? const CitadelAppBar() : null,
          body: onRefresh != null
              ? RefreshIndicator(onRefresh: onRefresh!, child: content)
              : content,
          bottomNavigationBar: bottomNavigationBar != null
              ? SafeArea(child: bottomNavigationBar!)
              : const SizedBox.shrink(),
        );
      case BackgroundType.pureWhite:
        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          backgroundColor: AppColor.white,
          appBar: appBar ?? const CitadelAppBar(),
          body: child,
          bottomNavigationBar: bottomNavigationBar != null
              ? SafeArea(child: bottomNavigationBar!)
              : const SizedBox.shrink(),
        );
      case BackgroundType.blueToOrange:
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: appBar,
          extendBody: true,
          body: Container(
            decoration: BoxDecoration(
              gradient: AppColor.blueToOrangeGradient,
              image: DecorationImage(
                  image: AssetImage(
                    Assets.images.backgrounds.gradientDecorationFrame.path,
                  ),
                  alignment: Alignment.topCenter),
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: Container(
                  padding: padding,
                  alignment: Alignment.center,
                  child: child,
                ),
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigationBar != null
              ? SafeArea(child: bottomNavigationBar!)
              : const SizedBox.shrink(),
        );
      case BackgroundType.blueToOrange2:
        final content = Container(
          decoration: BoxDecoration(
            color: AppColor.mainBlack,
            image: DecorationImage(
                image: AssetImage(
                  Assets.images.backgrounds.dashboardDecorationFrame.path,
                ),
                fit: BoxFit.fitWidth,
                scale: 5,
                alignment: Alignment.topCenter),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: Container(
                padding: padding,
                child: child,
              ),
            ),
          ),
        );

        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          body: onRefresh != null
              ? RefreshIndicator(onRefresh: onRefresh!, child: content)
              : content,
          bottomNavigationBar: bottomNavigationBar != null
              ? SafeArea(child: bottomNavigationBar!)
              : const SizedBox.shrink(),
        );
      case BackgroundType.maintenance:
        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          appBar: appBar,
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppColor.maintenanceGradient,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: minHeight,
                ),
                child: Container(
                  padding: padding,
                  alignment: Alignment.center,
                  child: child,
                ),
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigationBar != null
              ? SafeArea(child: bottomNavigationBar!)
              : const SizedBox.shrink(),
        );
      default:
        return const SizedBox();
    }
  }
}
