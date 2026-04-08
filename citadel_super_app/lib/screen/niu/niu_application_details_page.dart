import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/network_file.dart';
import 'package:citadel_super_app/data/state/niu_state.dart';
import 'package:citadel_super_app/data/vo/niu_get_application_details_vo.dart';
import 'package:citadel_super_app/extension/niu_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/project_widget/app_info_text.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/container/app_info_container.dart';
import 'package:citadel_super_app/project_widget/document/app_document_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NiuApplicationDetailsPage extends HookConsumerWidget {
  final NiuGetApplicationDetailsVo niu;

  const NiuApplicationDetailsPage({
    super.key,
    required this.niu,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final niuDetails = ref.watch(niuApplicationDetailsFutureProvider);
    return CitadelBackground(
      backgroundType: BackgroundType.blueToOrange2,
      child: Column(
        children: [
          const CitadelAppBar(
            title: 'Application Details',
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: niuDetails.when(
              data: (data) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  gapHeight16,
                  Row(
                    children: [
                      Image.asset(
                        niu.isPersonal
                            ? Assets.images.icons.personal.path
                            : Assets.images.icons.company.path,
                      ),
                      gapWidth12,
                      Text(
                        '${niu.amountDisplay} ',
                        style: AppTextStyle.number,
                      ),
                    ],
                  ),
                  gapHeight8,
                  Text(
                    'Requested On: ${niu.requestedOn} ',
                    style: AppTextStyle.description,
                  ),
                  gapHeight32,
                  Text(
                    niu.isPersonal ? 'Personal details' : 'Company details',
                    style: AppTextStyle.header2,
                  ),
                  gapHeight16,
                  AppInfoContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppInfoText("Full Name", niu.nameDisplay),
                        gapHeight16,
                        AppInfoText("MyKad Number", niu.documentNumberDisplay),
                        gapHeight16,
                        AppInfoText("Address", niu.fullAddressDisplay),
                        gapHeight16,
                        AppInfoText(
                            "Mobile Number", niu.fullMobileNumberDisplay),
                        gapHeight16,
                        AppInfoText("Email", niu.emailDisplay),
                      ],
                    ),
                  ),
                  gapHeight32,
                  Text(
                    'Documents uploaded',
                    style: AppTextStyle.header3,
                  ),
                  gapHeight16,
                  AppInfoContainer(
                    child: ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: (niu.documents ?? []).length,
                        separatorBuilder: (context, index) => gapHeight16,
                        itemBuilder: (BuildContext context, int index) {
                          final doc = niu.documents![index];
                          return AppDocumentWidget(
                            file: NetworkFile(url: doc.url ?? ''),
                            onDelete: () {},
                            viewOnly: true,
                            showFileSize: false,
                            fileName: doc.filename,
                          );
                        }),
                  )
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Text(
                  'Failed to load application details',
                  style: AppTextStyle.header2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
