import 'package:citadel_super_app/app_folder/app_color.dart';
import 'package:citadel_super_app/app_folder/app_constant.dart';
import 'package:citadel_super_app/app_folder/app_text_style.dart';
import 'package:citadel_super_app/data/model/country_code.dart';
import 'package:citadel_super_app/data/state/country_code_state.dart';
import 'package:citadel_super_app/extension/string_extension.dart';
import 'package:citadel_super_app/project_widget/bottom_sheet/phone_code_selection_bottom_sheet.dart';
import 'package:citadel_super_app/project_widget/form/app_form.dart';
import 'package:citadel_super_app/project_widget/form/app_text_form_field.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppMobileFormField extends StatefulHookConsumerWidget {
  /// Provide formKey for auto-validate all filled with button
  final GlobalKey<AppFormState> formKey;
  final String country;
  final String? initialValue;
  final String? label;
  final TextEditingController? controller;
  final bool enabled;

  const AppMobileFormField(
      {super.key,
      required this.formKey,
      this.country = 'Malaysia',
      this.initialValue,
      this.label,
      this.controller,
      this.enabled = true});

  @override
  AppMobileFormFieldState createState() => AppMobileFormFieldState();
}

class AppMobileFormFieldState extends ConsumerState<AppMobileFormField> {
  CountryCodes? countryCode;
  late TextEditingController mobileNumberController;

  @override
  void initState() {
    countryCode = ref.read(countryCodeProvider.notifier).getObjectByCountryName(
        country: widget.country.nullOrEmpty() ? 'Malaysia' : widget.country);

    mobileNumberController =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    super.initState();
  }

  ({String countryCode, String mobileNumber}) onSaved() {
    String mobileNumber = mobileNumberController.text.trim();

    // Handle Malaysian phone numbers that start with 0
    if (countryCode?.diallingCode == '+60' && mobileNumber.startsWith('0')) {
      mobileNumber = mobileNumber.substring(1);
    }

    return (
      countryCode: countryCode?.diallingCode ?? '',
      mobileNumber: mobileNumber
    );
  }

  bool validate() {
    return countryCode != null && mobileNumberController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      countryCode = ref
          .read(countryCodeProvider.notifier)
          .getObjectByCountryName(
              country:
                  widget.country.nullOrEmpty() ? 'Malaysia' : widget.country);
      return null;
    }, [widget.country]);

    return AppTextFormField(
      formKey: widget.formKey,
      isEnabled: widget.enabled,
      prefix: GestureDetector(
        onTap: () {
          showCountrySelectionBottomSheet(context, selectedCountry: countryCode)
              .then((value) {
            if (value != null) {
              setState(() {
                countryCode = value;
              });
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 0.1.sw),
            child: Text(countryCode?.diallingCode ?? '',
                style:
                    AppTextStyle.header3.copyWith(color: AppColor.brightBlue)),
          ),
        ),
      ),
      label: widget.label ?? 'Mobile Number',
      controller: mobileNumberController,
      keyboardType: TextInputType.phone,
      fieldKey: AppFormFieldKey.mobileNumberKey,
      maxLength: 16,
      validator: (value) {
        if (countryCode?.countryName != null &&
            countryCode!.countryName!.equalsIgnoreCase('malaysia')) {
          if (value.toString().length < 9 || value.toString().length > 11) {
            return 'Invalid Mobile Number';
          }
        } else {
          if (value.toString().length < 7 || value.toString().length > 16) {
            return 'Invalid Mobile Number';
          }
        }
        return '';
      },
    );
  }
}
