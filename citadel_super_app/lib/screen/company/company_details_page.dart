import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_spacing.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/app_folder/app_utils.dart';
import 'package:citadel_super_app/custom_router.dart';
import 'package:citadel_super_app/data/repository/corporate_repository.dart';
import 'package:citadel_super_app/data/repository/validation_repository.dart';
import 'package:citadel_super_app/data/request/corporate_client_sign_up_request_vo.dart';
import 'package:citadel_super_app/data/state/app_state.dart';
import 'package:citadel_super_app/data/state/corporate_profile_state.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/data/state/profile_state.dart';
import 'package:citadel_super_app/data/vo/corporate_details_vo.dart';
import 'package:citadel_super_app/extension/client_profile_extension.dart';
import 'package:citadel_super_app/extension/corporate_extension.dart';
import 'package:citadel_super_app/extension/int_extension.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/extension/web_service_extension.dart';
import 'package:citadel_super_app/helper/easy_loading_helper.dart';
import 'package:citadel_super_app/helper/form_validation_helper.dart';
import 'package:citadel_super_app/helper/parameter_helper.dart';
import 'package:citadel_super_app/project_widget/appbar/citadel_app_bar.dart';
import 'package:citadel_super_app/project_widget/background/citadel_background.dart';
import 'package:citadel_super_app/project_widget/button/primary_button.dart';
import 'package:citadel_super_app/project_widget/dropdown/app_dropdown.dart';
import 'package:citadel_super_app/project_widget/form/app_date_picker_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_mobile_form_field.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:citadel_super_app/project_widget/form/form_field_widget/address_details_form.dart';
import 'package:citadel_super_app/project_widget/selection/app_checkbox.dart';
import 'package:citadel_super_app/screen/company/share_holder_details_page.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompanyDetailsPage extends StatefulHookConsumerWidget {
  final formKey = GlobalKey<AppFormState>();

  final CorporateDetailsVo? corporateDetail;
  final bool isEdit;

  CompanyDetailsPage({super.key, this.corporateDetail, this.isEdit = false});

  @override
  CompanyDetailsPageState createState() => CompanyDetailsPageState();
}

class CompanyDetailsPageState extends ConsumerState<CompanyDetailsPage> {
  late final TextEditingController primaryNameController;
  late final TextEditingController primaryEmailController;
  late String primaryContactCountryCode;
  late final TextEditingController primaryContactController;
  late final TextEditingController entityController;
  late final TextEditingController placeIncoporateController;
  late final TextEditingController businessTypeController;

  @override
  void initState() {
    primaryNameController =
        TextEditingController(text: widget.corporateDetail.contactNameDisplay);
    primaryEmailController =
        TextEditingController(text: widget.corporateDetail.contactEmailDisplay);
    primaryContactCountryCode =
        widget.corporateDetail?.contactCountryCode ?? 'Malaysia';
    primaryContactController = TextEditingController(
        text: widget.corporateDetail.contactMobileNumberDisplay);
    entityController = TextEditingController(
        text: getValueForKey(widget.corporateDetail.entityTypeDisplay, ref));
    placeIncoporateController = TextEditingController(
        text: widget.corporateDetail.placeIncorporateDisplay);
    businessTypeController = TextEditingController(
        text: getValueForKey(widget.corporateDetail.businessTypeDisplay, ref));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(corporateSignUpProvider);
    final isBusinessAddress = useState(
      widget.corporateDetail == null
          ? false
          : (widget.corporateDetail!.corporateAddressDetails
                  ?.isDifferentRegisteredAddress ??
              false),
    );

    final isSelfContact = useState(widget.corporateDetail == null
        ? false
        : (widget.corporateDetail!.contactIsMyself ?? false));

    final profileState = ref.watch(profileProvider(null));
    final countryCodeNotifier = ref.watch(countryCodeProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.formKey.currentState!.validateFormButton();
      });
      return;
    }, []);

    return CitadelBackground(
      backgroundType: BackgroundType.darkToBright2,
      appBar: const CitadelAppBar(title: 'Enter your details'),
      child: profileState.when(
        data: (profile) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: AppForm(
                  key: widget.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Company Details',
                        style: AppTextStyle.header1,
                      ),
                      AppTextFormField(
                        formKey: widget.formKey,
                        label: 'Name of Entity',
                        fieldKey: AppFormFieldKey.entityNameKey,
                        initialValue: widget.corporateDetail.entityNameDisplay,
                      ),
                      Consumer(builder: (context, ref, child) {
                        final constants = ref.read(appProvider).constants ?? [];
                        final businessTypeConstants = constants.firstWhere(
                            (element) =>
                                element.category ==
                                AppConstantsKey.corporateEntityType);
                        final options = businessTypeConstants.list!
                            .map((e) =>
                                AppDropDownItem(value: e.key!, text: e.value!))
                            .toList();
                        final initialOptions = options.firstWhereOrNull(
                            (element) =>
                                element.value ==
                                widget.corporateDetail?.entityType);
                        return AppDropdown(
                          formKey: widget.formKey,
                          label: 'Type of Entity',
                          fieldKey: AppFormFieldKey.entityTypeKey,
                          hintText: 'Type of Entity',
                          options: options,
                          textController: entityController,
                          initialValue: initialOptions?.text ?? '',
                        );
                      }),
                      AppTextFormField(
                        formKey: widget.formKey,
                        label: 'Registration Number',
                        fieldKey: AppFormFieldKey.registrationNumberKey,
                        initialValue:
                            widget.corporateDetail.registrationNumberDisplay,
                      ),
                      AppDatePickerFormField(
                        formKey: widget.formKey,
                        label: 'Date of Incorporation',
                        fieldKey: AppFormFieldKey.incorporationDateKey,
                        initialValue: widget.corporateDetail != null
                            ? widget.corporateDetail!.dateIncorporate
                                .toDateFormat("MM-dd-yyyy")
                            : '',
                      ),
                      Consumer(builder: (context, ref, child) {
                        final countries =
                            ref.read(countryCodeProvider).countryCodes ?? [];
                        return AppDropdown(
                            formKey: widget.formKey,
                            label: 'Place of Incorporation',
                            fieldKey: AppFormFieldKey.incorporationPlaceKey,
                            hintText: 'Place of Incorporation',
                            textController: placeIncoporateController,
                            options: countries
                                .map((country) => AppDropDownItem(
                                    value: country.countryName ?? '',
                                    text: country.countryName ?? ''))
                                .toList());
                      }),
                      Consumer(builder: (context, ref, child) {
                        final constants = ref.read(appProvider).constants ?? [];
                        final businessTypeConstants = constants.firstWhere(
                            (element) =>
                                element.category ==
                                AppConstantsKey.industryType);
                        return AppDropdown(
                            formKey: widget.formKey,
                            label: 'Business Type',
                            fieldKey: AppFormFieldKey.businessTypeKey,
                            hintText: 'Business Type',
                            textController: businessTypeController,
                            options: businessTypeConstants.list!
                                .map((e) => AppDropDownItem(
                                    value: e.key!, text: e.value!))
                                .toList());
                      }),
                      AddressDetailsForm(
                        addressLabel: 'Registered Address',
                        formKey: widget.formKey,
                        address:
                            widget.corporateDetail?.registeredAddressObject,
                      ),
                      gapHeight24,
                      AppCheckbox(
                          formKey: widget.formKey,
                          label:
                              'My business address is different with my registered address.',
                          fieldKey:
                              AppFormFieldKey.differentRegisteredAddressKey,
                          onCheck: (checked) {
                            isBusinessAddress.value = checked;
                            widget.formKey.currentState!.validateFormButton();
                          },
                          isTick: isBusinessAddress.value),
                      if (isBusinessAddress.value)
                        AddressDetailsForm(
                          addressLabel: 'Business Address',
                          formKey: widget.formKey,
                          fieldKey:
                              AppFormFieldKey.companyAddressDetailsFormKey,
                          address:
                              widget.corporateDetail?.businessAddressObject,
                        ),
                      AppTextFormField(
                        formKey: widget.formKey,
                        label: 'Primary Contact Person Name',
                        fieldKey: AppFormFieldKey.nameKey,
                        controller: primaryNameController,
                      ),
                      gapHeight24,
                      AppCheckbox(
                          formKey: widget.formKey,
                          label: 'The primary contact person is myself.',
                          onCheck: (checked) {
                            isSelfContact.value = checked;
                            if (checked) {
                              primaryNameController.text =
                                  profile.personalDetails.nameDisplay;
                              primaryEmailController.text =
                                  profile.personalDetails.emailDisplay;
                              primaryContactCountryCode = profile
                                  .personalDetails.mobileCountryCodeDisplay;
                              primaryContactController.text =
                                  profile.personalDetails.mobileNumberDisplay;
                            } else {
                              primaryNameController.text = '';
                              primaryEmailController.text = '';
                              primaryContactController.text = '';
                              primaryContactCountryCode = 'Malaysia';
                            }
                          },
                          fieldKey: AppFormFieldKey.selfContactKey,
                          isTick: isSelfContact.value),
                      AppTextFormField(
                        formKey: widget.formKey,
                        label: 'Primary Contact Designation',
                        fieldKey: AppFormFieldKey.designationKey,
                        initialValue:
                            widget.corporateDetail.contactDesignationDisplay,
                      ),
                      AppMobileFormField(
                        formKey: widget.formKey,
                        country: countryCodeNotifier
                                .getObjectByDialCode(
                                    dialCode: primaryContactCountryCode)
                                ?.countryName ??
                            '',
                        label: 'Primary Contact Mobile Number',
                        controller: primaryContactController,
                      ),
                      AppTextFormField(
                        formKey: widget.formKey,
                        label: 'Primary Contact Email',
                        fieldKey: AppFormFieldKey.emailKey,
                        controller: primaryEmailController,
                      ),
                      gapHeight48,
                      PrimaryButton(
                        key:
                            const Key(AppFormFieldKey.primaryButtonValidateKey),
                        onTap: () async => widget.isEdit
                            ? await edit(context)
                            : await create(context),
                        title: 'Continue',
                      ),
                    ],
                  )));
        },
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, s) => CitadelBackground(
            backgroundType: BackgroundType.darkToBright2,
            appBar: const CitadelAppBar(title: 'Enter your details'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Something Went Wrong',
                  style: AppTextStyle.caption,
                ),
                gapHeight16,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: PrimaryButton(
                    title: 'Retry',
                    onTap: () {
                      // ignore: unused_result
                      ref.refresh(profileProvider(null).future);
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }

  Future<void> create(BuildContext context) async {
    widget.formKey.currentState!.validate(
      onSuccess: (formData) async {
        ValidationRepository repo = ValidationRepository();
        final req = ParameterHelper().corporateProfileParam(formData);
        EasyLoadingHelper.show();
        await repo.corporateDetailsValidation(req).baseThen(
          context,
          onResponseSuccess: (response) async {
            final profileData =
                await ref.read(corporateProfileProvider(null).future);

            CorporateRepository repo = CorporateRepository();

            final referenceNumber = ref.read(corporateRefProvider);
            await repo
                .createCorporate(
              referenceNumber,
              CorporateClientSignUpRequestVo(
                corporateDetails: req,
                annualIncomeDeclaration:
                    profileData.corporateClient?.annualIncomeDeclaration,
                sourceOfIncome: profileData.corporateClient?.sourceOfIncome,
                digitalSignature: profileData.corporateClient?.digitalSignature,
              ),
              true,
            )
                .baseThen(
              getAppContext() ?? context,
              onResponseSuccess: (_) async {
                // ignore: unused_result
                await ref.refresh(corporateProfileProvider(null).future);
                // ignore: unused_result
                await ref.refresh(shareholdersProvider.future);

                final corporateSignUpNotifier =
                    ref.read(corporateSignUpProvider.notifier);
                corporateSignUpNotifier.state =
                    CorporateClientSignUpRequestVo(corporateDetails: req);
                Navigator.pushNamed(
                    getAppContext() ?? context, CustomRouter.shareHolderDetails,
                    arguments: const ShareHolderDetailsPage(
                      showSaveDraftButton: true,
                    ));
              },
              onResponseError: (e, s) {
                if (e.message.contains('validation')) {
                  FormValidationHelper()
                      .resolveValidationError(widget.formKey, e.message);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message),
                      backgroundColor: AppColor.errorRed,
                    ),
                  );
                }
              },
            );
          },
          onResponseError: (e, s) {
            if (e.message.contains('validation')) {
              FormValidationHelper()
                  .resolveValidationError(widget.formKey, e.message);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message),
                  backgroundColor: AppColor.errorRed,
                ),
              );
            }
          },
        ).whenComplete(() => EasyLoadingHelper.dismiss());
      },
    );
  }

  Future<void> edit(BuildContext context) async {
    await widget.formKey.currentState!.validate(
      onSuccess: (formData) async {
        ValidationRepository repo = ValidationRepository();
        final req = ParameterHelper().corporateProfileParam(formData);
        EasyLoadingHelper.show();
        await repo.editCorporateDetailsValidation(req).baseThen(
          context,
          onResponseSuccess: (response) async {
            CorporateRepository corporateRepository = CorporateRepository();
            await corporateRepository.editCorporateDetail(req).baseThen(context,
                onResponseSuccess: (_) {
              ref.invalidate(corporateProfileProvider);
              Navigator.pop(context);
            });
          },
          onResponseError: (e, s) {
            if (e.message.contains('validation')) {
              FormValidationHelper()
                  .resolveValidationError(widget.formKey, e.message);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e.message),
                  backgroundColor: AppColor.errorRed,
                ),
              );
            }
          },
        ).whenComplete(() => EasyLoadingHelper.dismiss());
      },
    );
  }
}
