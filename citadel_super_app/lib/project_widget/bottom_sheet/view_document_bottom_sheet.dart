import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/vo/product_order_documents_vo.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/download_file_helper.dart';
import 'package:citadel_super_app/screen/universal/view_document_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> showViewDocumentBottomSheet(BuildContext context,
    {required ProductOrderDocumentsVo documents}) async {
  await showModalBottomSheet(
    backgroundColor: AppColor.white,
    context: context,
    isScrollControlled: true,
    builder: (context) => ViewDocumentBottomSheet(documents: documents),
  );
}

class ViewDocumentBottomSheet extends HookConsumerWidget {
  final ProductOrderDocumentsVo documents;
  const ViewDocumentBottomSheet({super.key, required this.documents});

  List<Widget> getDocumentsList(BuildContext context) {
    List<Widget> widgets = [];

    if (documents.profitSharingSchedule != null) {
      widgets.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, CustomRouter.viewDocument,
              arguments: ViewDocumentPage(
                url: documents.profitSharingSchedule!,
                docName: 'Profit Sharing Schedule',
              ));
        },
        child: Row(
          children: [
            Image.asset(
              Assets.images.icons.profitSharing.path,
              width: 24.w,
              height: 24.h,
            ),
            gapWidth16,
            Text(
              'Profit Sharing Schedule',
              style: AppTextStyle.bodyText.copyWith(color: AppColor.popupGray),
            ),
          ],
        ),
      ));
    }

    if (documents.officialReceipt != null) {
      if (widgets.isNotEmpty) {
        widgets.add(gapHeight16);
        widgets.add(const Divider());
        widgets.add(gapHeight16);
      }

      widgets.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, CustomRouter.viewDocument,
              arguments: ViewDocumentPage(
                url: documents.officialReceipt!,
                docName: 'Official Receipt',
              ));
        },
        child: Row(
          children: [
            Image.asset(
              Assets.images.icons.officialReceipt.path,
              width: 24.w,
              height: 24.h,
            ),
            gapWidth16,
            Text(
              'Official Receipt',
              style: AppTextStyle.bodyText.copyWith(color: AppColor.popupGray),
            ),
          ],
        ),
      ));
    }

    if (documents.statementOfAccount != null) {
      if (widgets.isNotEmpty) {
        widgets.add(gapHeight16);
        widgets.add(const Divider());
        widgets.add(gapHeight16);
      }
      widgets.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, CustomRouter.viewDocument,
              arguments: ViewDocumentPage(
                url: documents.statementOfAccount!,
                docName: 'Statement of Account',
              ));
        },
        child: Row(
          children: [
            Image.asset(
              Assets.images.icons.accountStatement.path,
              width: 24.w,
              height: 24.h,
            ),
            gapWidth16,
            Text(
              'Statement of Account',
              style: AppTextStyle.bodyText.copyWith(color: AppColor.popupGray),
            ),
          ],
        ),
      ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          gapHeight32,
          Text(
            'View Documents',
            style: AppTextStyle.header3.copyWith(color: AppColor.mainBlack),
          ),
          gapHeight24,
          ...getDocumentsList(context),
          gapHeight32,
        ],
      ),
    );
  }
}
