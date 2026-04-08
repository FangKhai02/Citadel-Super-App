import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/fund/payment.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<PaymentMethod?> showPaymentMethodBottomSheet(
    BuildContext context) async {
  PaymentMethod? method = await showModalBottomSheet(
    backgroundColor: AppColor.white,
    context: context,
    isScrollControlled: true,
    builder: (context) => const PaymentMethodSelectionBottomSheet(),
  );
  return method;
}

class PaymentMethodSelectionBottomSheet extends HookConsumerWidget {
  const PaymentMethodSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            gapHeight32,
            Text(
              'Select Payment Method',
              style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
            ),
            gapHeight24,
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context, PaymentMethod.manualTransfer);
              },
              child: Row(
                children: [
                  Image.asset(
                    Assets.images.icons.manualTransfer.path,
                    width: 24.w,
                    height: 24.h,
                  ),
                  gapWidth16,
                  Text(
                    'Manual Transfer',
                    style: AppTextStyle.bodyText
                        .copyWith(color: AppColor.popupGray),
                  ),
                ],
              ),
            ),
            // gapHeight16,
            // const Divider(),
            // gapHeight16,
            // GestureDetector(
            //   behavior: HitTestBehavior.opaque,
            //   onTap: () {
            //     Navigator.pop(context, PaymentMethod.onlineBanking);
            //   },
            //   child: Row(
            //     children: [
            //       Image.asset(
            //         Assets.images.icons.onlineBanking.path,
            //         width: 24.w,
            //         height: 24.h,
            //       ),
            //       gapWidth16,
            //       Text(
            //         'Online Banking',
            //         style:
            //             AppTextStyle.bodyText.copyWith(color: AppColor.popupGray),
            //       ),
            //     ],
            //   ),
            // ),
            gapHeight32,
          ],
        ),
      ),
    );
  }
}
