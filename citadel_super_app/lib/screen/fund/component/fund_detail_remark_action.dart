import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/fund/portfolio_status.dart';
import 'package:citadel_super_app/data/vo/product_order_documents_vo.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/bottom_sheet/view_document_bottom_sheet.dart';
import 'package:citadel_super_app/project_widget/button/rounded_border_button.dart';
import 'package:citadel_super_app/screen/fund/component/fund_status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FundDetailRemarkAction extends HookWidget {
  final PortfolioStatus? status;
  final String? remark;
  final ProductOrderDocumentsVo? documents;

  const FundDetailRemarkAction(
      {super.key, required this.status, required this.remark, this.documents});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (documents != null) ...[
          RoundedBorderButton(
            title: 'View Documents',
            onTap: () {
              showViewDocumentBottomSheet(context, documents: documents!);
            },
            image: Image.asset(
              Assets.images.icons.view.path,
              width: 16.w,
              height: 16.h,
            ),
            backgroundColor: Colors.transparent,
            borderColor: Colors.white,
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 6.r, vertical: 8.r),
          ),
          gapHeight32,
        ],
        if (remark != null) ...[
          Padding(
            padding: EdgeInsets.only(bottom: 32.h),
            child: Row(
              children: [
                Image.asset(
                  Assets.images.icons.alert.path,
                  width: 14.w,
                  color: getStatusColor(status!),
                ),
                gapWidth8,
                Expanded(
                  child: Text(remark ?? '',
                      style: AppTextStyle.header3
                          .copyWith(color: getStatusColor(status!))),
                ),
              ],
            ),
          )
        ]
      ],
    );
  }
}
