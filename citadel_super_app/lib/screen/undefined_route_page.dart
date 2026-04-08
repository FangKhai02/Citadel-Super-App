import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UndefinedRoutePage extends HookWidget {
  const UndefinedRoutePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              child: Text(
                  'Opps, seems like you are going to an unknown page. Press the home button to direct you back to home'),
            ),
            Padding(
              padding: EdgeInsets.all(24.h),
              child: PrimaryButton(
                title: 'Direct back to Home',
                onTap: () async {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
