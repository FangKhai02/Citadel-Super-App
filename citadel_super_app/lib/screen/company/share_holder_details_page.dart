import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/request/corporate_client_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/request/corporate_shareholder_add_request_vo.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/vo/corporate_share_holder_add_vo.dart';
import 'package:citadel_super_app/data/vo/corporate_shareholder_base_vo.dart';
import 'package:citadel_super_app/extension/corporate_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/generated/assets.gen.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/button/secondary_button.dart';
import 'package:citadel_super_app/project_widget/container/white_border_container.dart';
import 'package:citadel_super_app/project_widget/dialog/animated_dialog.dart';
import 'package:citadel_super_app/project_widget/dialog/app_dialog.dart';
import 'package:citadel_super_app/screen/company/share_holder_info_page.dart';
import 'package:citadel_super_app/screen/company/share_holder_page.dart';
import 'package:citadel_super_app/screen/company/wealth_source_page.dart';
import 'package:citadel_super_app/screen/sign_up/document_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShareHolderDetailsPage extends StatefulHookConsumerWidget {
  final bool showSaveDraftButton;
  const ShareHolderDetailsPage({
    super.key,
    this.showSaveDraftButton = false,
  });

  @override
  ShareHolderDetailsPageState createState() => ShareHolderDetailsPageState();
}

class ShareHolderDetailsPageState
    extends ConsumerState<ShareHolderDetailsPage> {
  final GlobalKey<AnimatedDialogState> _dialogKey =
      GlobalKey<AnimatedDialogState>();

  @override
  Widget build(BuildContext context) {
    // final newShareholder = useState<CorporateShareholderAddRequestVo>(
    //     CorporateShareholderAddRequestVo());
    final shareholderProvider = ref.watch(shareholdersProvider);

    final mappedShareholders = useState<List<CorporateShareholderBaseVo>>([]);
    final draftShareholders = useState<List<CorporateShareholderBaseVo>>([]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final shareholders = await ref.read(shareholdersProvider.future);

        if (shareholders.isEmpty) {
          if (context.mounted) {
            Navigator.pushNamed(
              context,
              CustomRouter.document,
              arguments: DocumentPage(
                title: 'Scan Share Holder ID',
                onConfirm: () {
                  Navigator.pushReplacementNamed(
                    context,
                    CustomRouter.shareHolder,
                    arguments: ShareHolderPage(),
                  );
                },
              ),
            );
          }
        }
      });

      return null;
    }, []);

    return CitadelBackground(
        backgroundType: BackgroundType.darkToBright2,
        appBar: CitadelAppBar(
            title: 'Edit your details',
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AppDialog(
                      title: 'Confirmation to leave page',
                      message:
                          'Are you sure you want to leave this page? New shareholder information will be discarded',
                      positiveText: 'Confirm',
                      negativeText: 'Cancel',
                      positiveOnTap: () async {
                        ref.invalidate(shareholdersProvider);

                        if (widget.showSaveDraftButton) {
                          Navigator.popUntil(
                              context,
                              (route) =>
                                  route.settings.name ==
                                  CustomRouter.companyDetails);
                        } else {
                          Navigator.popUntil(
                              context,
                              (route) =>
                                  route.settings.name ==
                                  CustomRouter.corporateProfile);
                        }
                      },
                    );
                  });
            }),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              shareholderProvider.maybeWhen(
                data: (shareholderList) {
                  return PrimaryButton(
                    title: 'Continue',
                    onTap: (shareholderList.isNotEmpty)
                        ? () async {
                            CorporateShareholderAddRequestVo req =
                                CorporateShareholderAddRequestVo(
                                    shareHolders:
                                        shareholderList.map((shareholder) {
                              return CorporateShareHolderAddVo(
                                id: shareholder.id,
                                percentageOfShareholdings:
                                    (shareholder.percentageOfShareholdings ??
                                            0.0)
                                        .ceilToDouble(),
                              );
                            }).toList());
                            await addToCorporate(context, ref, req);
                          }
                        : null,
                  );
                },
                orElse: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              if (widget.showSaveDraftButton)
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: SecondaryButton(
                    title: 'Save draft & upload later',
                    onTap: () async {
                      Navigator.popUntil(getAppContext() ?? context, (routes) {
                        if ([CustomRouter.dashboard]
                            .contains(routes.settings.name)) {
                          return true;
                        }
                        return false;
                      });
                    },
                  ),
                )
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            shareholderProvider.maybeWhen(
              data: (shareholderList) {
                mappedShareholders.value = shareholderList
                    .where((e) => e.status != null && e.status != 'DRAFT')
                    .toList();

                draftShareholders.value = shareholderList
                    .where((e) => e.status != null && e.status == 'DRAFT')
                    .toList();

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Share Holder Details', style: AppTextStyle.header1),
                    gapHeight32,
                    if (mappedShareholders.value.isNotEmpty) ...[
                      Text('Mapped Shareholders', style: AppTextStyle.header2),
                      gapHeight16,
                      buildShareholderList(
                          mappedShareholders.value,
                          context,
                          ref,
                          shareholderList,
                          mappedShareholders,
                          draftShareholders),
                      gapHeight32,
                    ],
                    if (draftShareholders.value.isNotEmpty) ...[
                      Text('Draft Shareholders', style: AppTextStyle.header2),
                      gapHeight16,
                      buildShareholderList(
                          draftShareholders.value,
                          context,
                          ref,
                          shareholderList,
                          mappedShareholders,
                          draftShareholders),
                      gapHeight32,
                    ],
                    Visibility(
                      visible: shareholderList.length < 5,
                      child: SecondaryButton(
                        height: 32.h,
                        onTap: () {
                          Navigator.pushNamed(context, CustomRouter.document,
                              arguments: DocumentPage(
                                  title: 'Scan Share Holder ID',
                                  onConfirm: () {
                                    Navigator.pushReplacementNamed(
                                        context, CustomRouter.shareHolder,
                                        arguments: ShareHolderPage());
                                  }));
                        },
                        title: 'Add',
                        icon: Image.asset(
                          Assets.images.icons.plus.path,
                          width: 16.w,
                        ),
                      ),
                    ),
                  ],
                );
              },
              orElse: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ]),
        ));
  }

  Widget buildShareholderList(
    List<CorporateShareholderBaseVo> shareholders,
    BuildContext context,
    WidgetRef ref,
    List<CorporateShareholderBaseVo> shareholderList,
    ValueNotifier<List<CorporateShareholderBaseVo>> mappedShareholders,
    ValueNotifier<List<CorporateShareholderBaseVo>> draftShareholder,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: shareholders.length,
      itemBuilder: (context, index) {
        final shareHolder = shareholders[index];
        return GestureDetector(
          onTap: () {
            getShareholderDetail(context, ref, shareHolder, index);
          },
          child: WhiteBorderContainer(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shareHolder.status == 'DRAFT'
                            ? '${shareHolder.name ?? ''} [DRAFT]'
                            : shareHolder.name ?? '',
                        style: AppTextStyle.header3,
                      ),
                      gapHeight8,
                      Text(
                        'Share Holder ${index + 1}',
                        style: AppTextStyle.description,
                      ),
                      gapHeight8,
                      Slider(
                        value: shareHolder.percentageOfShareholdings ?? 0.0,
                        min: 0,
                        max: 100,
                        label: shareHolder.percentageOfShareholdings.toString(),
                        onChanged: (double value) {
                          if (shareHolder.status == 'DRAFT') {
                            draftShareholder.value =
                                draftShareholder.value.map((e) {
                              if (e.id == shareHolder.id) {
                                e.percentageOfShareholdings =
                                    value.ceilToDouble();
                                return shareHolder;
                              }
                              return e;
                            }).toList();
                          } else {
                            mappedShareholders.value =
                                mappedShareholders.value.map((e) {
                              if (e.id == shareHolder.id) {
                                e.percentageOfShareholdings =
                                    value.ceilToDouble();
                                return shareHolder;
                              }
                              return e;
                            }).toList();
                          }
                        },
                      ),
                      Text(
                        '${shareHolder.percentageOfShareholdings?.ceilToDouble()}%',
                        style: AppTextStyle.description,
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  Assets.images.icons.right.path,
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Column(
          children: [gapHeight16],
        );
      },
    );
  }

  Future<void> getShareholderDetail(BuildContext context, WidgetRef ref,
      CorporateShareholderBaseVo e, int index) async {
    final corporateRef = ref.read(corporateRefProvider);
    CorporateRepository corporateRepository = CorporateRepository();

    await corporateRepository
        .getShareholderById(e.id!, corporateRef!)
        .baseThen(context, onResponseSuccess: (data) {
      Navigator.pushNamed(context, CustomRouter.shareHolderInfo,
          arguments: ShareHolderInfoPage(shareholder: data, no: index));
    }, onResponseError: (e, s) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: AppColor.errorRed, content: Text(e.message)));
    });
  }

  Future<void> addToCorporate(BuildContext context, WidgetRef ref,
      CorporateShareholderAddRequestVo newShareholder) async {
    CorporateRepository corporateRepository = CorporateRepository();

    final referenceNumber = ref.read(corporateRefProvider);

    EasyLoadingHelper.show();
    await corporateRepository
        .addShareholderToCoporate(newShareholder, referenceNumber!)
        .baseThen(getAppContext() ?? context, onResponseSuccess: (data) async {
      // ignore: unused_result
      ref.refresh(shareholdersProvider);
      // ignore: unused_result
      ref.refresh(corporateProfileProvider(null).future);
      (widget.showSaveDraftButton)
          ? await proceed(context, ref)
          : Navigator.pop(context);
    }, onResponseError: (e, s) {
      if (e.message.equalsIgnoreCase('api.invalid.shareholdings.percentage')) {
        showDialog(
            context: context,
            builder: (ctx) {
              return Center(
                child: Material(
                  color: Colors.transparent,
                  child: AnimatedDialog(
                    key: _dialogKey,
                    child: AppDialog(
                      title: 'Total percentage is not 100%',
                      message:
                          'Sum of percentage for all shareholders holding must be 100%',
                      isRounded: true,
                      positiveOnTap: () async {
                        await _dialogKey.currentState?.closeDialog();
                      },
                      showNegativeButton: false,
                    ),
                  ),
                ),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (ctx) {
              return AppDialog(
                title: 'Error',
                message: e.message,
                isRounded: true,
                positiveOnTap: () {
                  Navigator.pop(context);
                },
                showNegativeButton: false,
              );
            });
      }
    }).whenComplete(() => EasyLoadingHelper.dismiss());
  }

  Future<void> proceed(BuildContext context, WidgetRef ref) async {
    final corporateSignUpNotifier = ref.read(corporateSignUpProvider.notifier);
    final profileData = await ref.read(corporateProfileProvider(null).future);

    Navigator.pushNamed(getAppContext() ?? context, CustomRouter.wealthSource,
        arguments: WealthSourcePage(
            initialIncome:
                profileData.corporateClient.annualIncomeDeclarationDisplay,
            initialSource: profileData.corporateClient.sourceofIncomeDisplay,
            onConfirm: (annualIncome, sourceOfIncome) async {
              CorporateRepository repo = CorporateRepository();

              final req = CorporateClientSignUpRequestVo(
                corporateDetails:
                    corporateSignUpNotifier.state?.corporateDetails,
                annualIncomeDeclaration: annualIncome,
                sourceOfIncome: sourceOfIncome,
                digitalSignature: profileData.corporateClient?.digitalSignature,
              );
              corporateSignUpNotifier.state = req;

              await repo
                  .createCorporate(ref.read(corporateRefProvider), req, true)
                  .baseThen(context, onResponseSuccess: (data) async {
                // ignore: unused_result
                await ref.refresh(corporateProfileProvider(null).future);
                Navigator.pushNamed(getAppContext() ?? context,
                    CustomRouter.documentUploadCompany);
              });
            }));
  }
}
